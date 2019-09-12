create or replace function get_segment_payment(AMoveSet_ID NUMBER, Asince_date date, Aend_date date) return number
is
--------------------------------------------------------------------------------------------------------------------------
-- функция считает ПРИБЛИЗИТЕЛЬНУЮ сумму, в диапозоне от Asince_date до Aend_date
---------------------------------------------------------------------------------------------------------------------------
result number;
BEGIN


-- очень большой и страшный запрос с расчетом
-- входящие данные:
   -- номер операции движения AMoveSet_ID,
   -- дата начала выборки - Asince_date
   -- дата конца выборки -  Aend_date
-- выход: сумма по дням входящих в периоды диапазона в переменную result

with days_dif_table_more as (  --выборка разници дней с положительным показателем

select  ddt.col_day plus_col_day, --важно что берется col_day
        ddt.id, ddt.sincedate, ddt.enddate ,ddt.dif_end_day
from (
 select mp.enddate-mp.sincedate+1 col_day -- дни в периоде
             ,mp.sincedate-Asince_date dif_day -- разница дней (переменная: дата начала выборки)
             ,(mp.enddate-mp.sincedate+1) +  (mp.sincedate-Asince_date) chek_day -- сумама разници и кол-ва дней - должно быль положительным тогда входит (переменная: дата начала выборки)
            ,Aend_date-mp.enddate dif_end_day  -- дата окончания (переменная: дата конца выборки)
             ,mp.*
      from sm.moveperiods mp,
           sm.movesets ms
      where
      mp.moveset_id = AMoveSet_ID -- id операции движения
      and ms.id=mp.moveset_id
      and ms.annulreasons_id not in (9, 663, 1264, 2303, 2731, 2732, 2796)
      order by mp.sincedate desc
      ) ddt
     where ddt.chek_day >0
     and ddt.dif_day>=0  --положительным показателем
     and Aend_date-Asince_date <>0 -- проверка на 2 одинаковых даты
),

 days_dif_table_less as ( --выборка разници дней с отрицательным показателем

select  ddt.chek_day plus_col_day, --важно что берется chek_day
        ddt.id, ddt.sincedate, ddt.enddate ,ddt.dif_end_day
from (
 select mp.enddate-mp.sincedate+1 col_day -- дни в периоде
             ,mp.sincedate-Asince_date dif_day -- разница дней (переменная: дата начала выборки)
             ,(mp.enddate-mp.sincedate+1) +  (mp.sincedate-Asince_date) chek_day -- сумама разници и кол-ва дней - должно быль положительным тогда входит (переменная: дата начала выборки)
            ,Aend_date-mp.enddate dif_end_day  -- дата окончания (переменная: дата конца выборки)
             ,mp.*
      from sm.moveperiods mp,
           sm.movesets ms
      where
      mp.moveset_id = AMoveSet_ID -- id операции движения
      and ms.id=mp.moveset_id
      and ms.annulreasons_id not in (9, 663, 1264, 2303, 2731, 2732, 2796)
      order by mp.sincedate desc
      ) ddt
     where ddt.chek_day >0
     and ddt.dif_day<=0 --отрицательным показателем
     and Aend_date-Asince_date <>0 -- проверка на 2 одинаковых даты
)

select nvl(sum(p.paysize*12/365*mpp.plus_col_day),0)  -- сумма по дням входящих в периоды диапазона дат
     -- p.paysize*12/365*mpp.plus_col_day,  mpp.*
      into result
from
(
select t.plus_col_day, t.id,  t.sincedate, t.enddate , t.dif_end_day
from  (
      select *
      from days_dif_table_more

      union

      select *
      from days_dif_table_less
      ) t
where (t.dif_end_day*-1)<t.plus_col_day
      and t.dif_end_day >= 0

union

select t.plus_col_day+t.dif_end_day plus_col_day, t.id,  t.sincedate, t.enddate , t.dif_end_day
from  (
      select *
      from days_dif_table_more

      union
      select *
      from days_dif_table_less
) t
where (t.dif_end_day*-1)<t.plus_col_day
      and t.dif_end_day <= 0
) mpp,

sm.paydocs p -- платежи
where
p.moveperiod_id = mpp.id
and p.obligationtype_id in (1,8) -- только арендная плата и аренда земли
--and rownum=1;
order by sincedate;



RETURN round(result, 2);
END;



--------



create or replace function get_full_payment(AMoveSet_ID NUMBER, alength NUMBER) return number
is
--------------------------------------------------------------------------------------------------------------------------
-- функция выдает ПРИБЛИЗИТЕЛЬНУЮ сумму, которую заплатят за весь последний период
-- второй параметр делит операции 3 типа: длительность до года, от 1 до 3 лет, больше 3 лет
-- второй парамет = 4 это для куреленко
-- верия от 14.05.2019
-- переписан запрос позволяющий брать диапазон по значениям
---------------------------------------------------------------------------------------------------------------------------
sys_date number;
since_date date;
end_date date;
dif number;
result number;
BEGIN

select extract(year from sysdate) into sys_date from dual;
sys_date:=sys_date+1;

-- исключить sys_date+1

select mpp.sincedate,
       decode(EXTRACT (YEAR FROM mpp.sincedate),sys_date,nvl(ADD_MONTHS(mpp_end.enddate,-12),to_date('01.01.'||sys_date)),mpp_end.enddate ), -- отнять год, если начало периода с 19 года - так как автомат при разбитии периода увеличивает дату окончания на год
       trunc((mpp_end.enddate-mpp.sincedate)/365)

into since_date, end_date,  dif

from (select mp.*
      from sm.moveperiods mp
      where
      mp.moveset_id = AMoveSet_ID
      and mp.sincedate < to_date('01.01.'||sys_date)
      order by mp.sincedate desc
      )mpp,

      (select mp.enddate
       from
            sm.movesets ms,
            sm.moveperiods mp
      where
      ms.id = AMoveSet_ID and
      mp.id = ms.last_period_id --последний период, который висит на операции движения
      )mpp_end
where rownum=1;


--нас интересуют ОД в диапазоне от 01.01.sys_date до конца веремен

if since_date < '01.01.'||(sys_date-1) then
since_date:=to_date('01.01.'||(sys_date-1));
end if;


--------------- ПРОВЕРЯЕМ alength  -------------------
-- до года


if alength = 1 and (end_date - since_date) > 365 then

  end_date :=to_date('01.01.'||sys_date);

end if;

-- от 1 до 3
if alength = 2 then

  since_date:=to_date('01.01.'||(sys_date)); -- начало со след год
  
  if  ((end_date - since_date) <= 365 or (end_date - since_date) > 365*3) then

      if dif > 0 then  -- dif  это целочисленный коофициент -(энд_дейт - синс_дейт / 365) если она больше 0 значит между датами больше чем 1 год
         end_date :=to_date('01.01.'||(sys_date+2));
         since_date :=to_date('01.01.'||(sys_date));
      else
       --end_date :=to_date('01.01.2018');
         end_date:=since_date; -- если 0 значит по факту не считаем от 2х лет
      end if;                     
  end if;
end if;

-- больше 3
if alength = 3 then
  -- end_date :=to_date('01.01.2018');
  -- if (end_date - since_date) <= 365*3 then 
  -- end_date:=since_date;
  -- end if;
   since_date:='01.01.'||(sys_date+2);
end if;


if alength = 4 then
   
   -- непонятно но зачем то...
   -- куреленко хочет знать сколько было бы начиследно у закрытых операций движений
   -- начиная с конца последнего периода до конца года
   -- проблема в том что нет даты изменения состояния и мы не знаем когда ОД закрывается на самом деле
   
   
   select  
   decode(count(count(*)),0,to_date(sysdate, 'dd,mm,yyyy'), max(enddate)), 
   decode(count(count(*)),0,to_date(sysdate, 'dd,mm,yyyy'), to_date('31.12.'||to_char(extract(year from sysdate))))
   into since_date, -- начало периода - это конец =)
        end_date -- окончание периода последний день года или сисдейт - если период заканчивается в следующих годах
   from(

   select 
     mp.sincedate,
     mp.enddate
   from sm.movesets ms,
     sm.moveperiods mp

     where  ms.id =AMoveSet_ID 
             
              and ms.annulreasons_id in (select id from sm.annulreasons a where a.name like '%Закрыт%')
              and ms.last_period_id = mp.id
              and extract(year from sysdate) = extract(year from mp.enddate)
    
     )group by sincedate, enddate;
     

end if;

-- выход: сумма по дням входящих в периоды диапазона в переменную result
select sm.get_segment_payment(AMoveSet_ID,since_date,end_date) into result from dual;

RETURN round(result, 2);

END;