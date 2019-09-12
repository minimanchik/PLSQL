
-- Create table
create table PAYDOCS
(
  id                          NUMBER(27) not null,
  paysize                     NUMBER(27,2),
  clients_id                  NUMBER(27) not null,
  finepercent                 NUMBER,
  finedate                    NUMBER,
  periodical                  CHAR(1) default 'Y',
  oncepaydate                 DATE,
  obligationtype_id           NUMBER(27) not null,
  redirect_paydoc_id          NUMBER(27),
  explain_text                VARCHAR2(4000),
  kind                        CHAR(1) default 'A',
  moveperiod_id               NUMBER(27) not null,
  refinratepart               NUMBER,
  currency                    CHAR(1) default 'N',
  finemonths                  NUMBER default 1 not null,
  calendar_type_id            NUMBER(27) default 365 not null,
  is_yearly_paysize           CHAR(1),
  last_finedate               NUMBER,
  last_finemonths             NUMBER,
  main_cls_kbk_id             NUMBER(27),
  fine_cls_kbk_id             NUMBER(27),
  explain_xml                 CLOB,
  movement_id                 NUMBER(27),
  fine_kind                   CHAR(1) default 'P',
  fineondebt                  CHAR(1) default 'Y',
  finevaluefixed_daily        CHAR(1) default 'Y',
  finevaluefixed              NUMBER(27,2),
  fineoncreditpersent         CHAR(1) default 'N',
  creditsize                  NUMBER(27,2),
  creditcountmonth            NUMBER(27),
  creditstartdate             DATE,
  creditfirstpaydate          DATE,
  creditpercent               NUMBER(27,4),
  creditpercentondebt         CHAR(1) default 'Y',
  creditpercentconst          CHAR(1) default 'Y',
  creditpercentbydays         CHAR(1) default 'Y',
  creditrefinratepart_num     NUMBER(27),
  creditrefinratepart_denom   NUMBER(27),
  no_fine                     CHAR(1) default 'N',
  no_creditpercent            CHAR(1) default 'N',
  creditpay_period_months     NUMBER(27) default 1,
  oblig_periodical_presets_id NUMBER(27) default 1,
  percent_cls_kbk_id          NUMBER(27)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 216K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table PAYDOCS
  is 'Условия расчетов по обязательству в периоде ОД';
-- Add comments to the columns 
comment on column PAYDOCS.id
  is 'ID';
comment on column PAYDOCS.paysize
  is 'Cумма';
comment on column PAYDOCS.clients_id
  is 'Получатель платежа ID';
comment on column PAYDOCS.finepercent
  is 'Процент по пени';
comment on column PAYDOCS.finedate
  is 'Дата, с которой начислять пени';
comment on column PAYDOCS.periodical
  is 'Периодичность, Уникальный ключ - буква';
comment on column PAYDOCS.oncepaydate
  is 'Срок разового платежа';
comment on column PAYDOCS.obligationtype_id
  is 'Тип обязательства ID';
comment on column PAYDOCS.redirect_paydoc_id
  is 'Переназначение обязательства ID';
comment on column PAYDOCS.explain_text
  is 'Описание порядка расчета обязательства';
comment on column PAYDOCS.kind
  is 'В каком периоде начислять пеню A - в следующем, B - в текщем, P - в предшествующем, N - не указано (для единовременных)';
comment on column PAYDOCS.moveperiod_id
  is 'Период операции движения ID';
comment on column PAYDOCS.refinratepart
  is 'Доля ставки рефинансирования ЦБ (знаменатель)';
comment on column PAYDOCS.currency
  is 'Сумма представлена в у.е.';
comment on column PAYDOCS.finemonths
  is 'С какого месяца пени';
comment on column PAYDOCS.calendar_type_id
  is 'Тип календаря для расчета пени (кол-во дней в году)';
comment on column PAYDOCS.is_yearly_paysize
  is 'Размер оплаты указан за год';
comment on column PAYDOCS.last_finedate
  is 'С какого числа пеня в последнем периоде года';
comment on column PAYDOCS.last_finemonths
  is 'С какого месяца пеня в последнем периоде года';
comment on column PAYDOCS.main_cls_kbk_id
  is 'Код бюджетной классификации для основного начисления ID';
comment on column PAYDOCS.fine_cls_kbk_id
  is 'Код бюджетной классификации для начисления пени ID';
comment on column PAYDOCS.explain_xml
  is 'ХML данные об авторасчёте обязательства';
comment on column PAYDOCS.movement_id
  is '4.6.1.';
comment on column PAYDOCS.fine_kind
  is 'Способ исчисления пени: ''P''-процент (по умолчанию), ''R''-ставка рефинансирования, ''F''-фиксированная сумма';
comment on column PAYDOCS.fineondebt
  is 'База для определения процента пени - от долга (умолч.''Y'') / от суммы арендной платы (''N'')';
comment on column PAYDOCS.finevaluefixed_daily
  is 'Фиксированная пеня за каждый день просрочки исполнения обязательств (умолч. ''Y'')/за факт просрочки независимо от дней просрочки (штраф) (''N'')';
comment on column PAYDOCS.finevaluefixed
  is 'Размер фиксированной пени или штрафа.';
comment on column PAYDOCS.fineoncreditpersent
  is 'Начислять пеню на проценты по рассрочке (в добавок к очевидному начислению на просрочку оплаты основной суммы рассрочки, умолч.''N'')';
comment on column PAYDOCS.creditsize
  is 'Сумма рассрочки';
comment on column PAYDOCS.creditcountmonth
  is 'Количества месяцев рассрочки';
comment on column PAYDOCS.creditstartdate
  is 'С какой даты начинает действовать рассрочка';
comment on column PAYDOCS.creditfirstpaydate
  is 'Дата первого платежа по рассрочке';
comment on column PAYDOCS.creditpercent
  is 'Процент по рассрочке ';
comment on column PAYDOCS.creditpercentondebt
  is 'База начисления процентов: на остаток долга (умолч. ''Y'') / на исходную сумму (''N'')';
comment on column PAYDOCS.creditpercentconst
  is 'Процент твердый (умолч. ''Y'')/ от ставки рефинансирования (на день оплаты) (''N'')';
comment on column PAYDOCS.creditpercentbydays
  is 'Из расчета количества дней в периоде (умолч. ''Y'')/ независимо от числа дней';
comment on column PAYDOCS.creditrefinratepart_num
  is 'Доля ставки рефинансирования для исчисления процента по рассрочке на момент оплаты (числитель)';
comment on column PAYDOCS.creditrefinratepart_denom
  is 'Доля ставки рефинансирования для исчисления процента по рассрочке на момент оплаты (знаменатель)';
comment on column PAYDOCS.no_fine
  is 'Нет пени (''Y''), по умолч. ''N''';
comment on column PAYDOCS.no_creditpercent
  is 'Рассрочка без процентов (''Y'')/с начислением процентов (умолч. ''N'')';
comment on column PAYDOCS.creditpay_period_months
  is 'Периодичность погашения рассрочки в месяцах';
comment on column PAYDOCS.oblig_periodical_presets_id
  is 'Общие для всего периода договора настройки для фин.обязательств - чаще всего общие предустановки, но могут быть заданы индивидуально для ОД+периода.';
comment on column PAYDOCS.percent_cls_kbk_id
  is 'Код бюджетной классификации для процентов';
-- Create/Recreate indexes 
/*
create index IDXPAYDOCS_CLIENTS_ID on PAYDOCS (CLIENTS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 104K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_PDC_MOVEPERIOD_ID on PAYDOCS (MOVEPERIOD_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXREDIRPAYDOC on PAYDOCS (REDIRECT_PAYDOC_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index SYS_C007017 on PAYDOCS (ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 104K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAYDOCS
  add constraint PK_PAYDOCS primary key (ID);
--alter table PAYDOCS
--  add constraint CSOBLIG foreign key (OBLIGATIONTYPE_ID)
--  references OBLIGATIONTYPE (ID);
--alter table PAYDOCS
--  add constraint CSREDIRPAYDOC foreign key (REDIRECT_PAYDOC_ID)
--  references PAYDOCS (ID);
--alter table PAYDOCS
--  add constraint FK_OBJ_PRCL foreign key (PERIODICAL)
--  references OBL_PERIODTYPES (PERIODICAL);
--alter table PAYDOCS
--  add constraint FK_PAYDOCS_CALTYPES foreign key (CALENDAR_TYPE_ID)
--  references CALENDAR_TYPES (ID);
--alter table PAYDOCS
--  add constraint FK_PAYDOCS_CLIENTS_ID foreign key (CLIENTS_ID)
--  references RECEPIENTS (ID);
--alter table PAYDOCS
--  add constraint FK_PAYDOCS_FINE_CLS_KBK foreign key (FINE_CLS_KBK_ID)
--  references CLS_KBK (ID);
--alter table PAYDOCS
--  add constraint FK_PAYDOCS_MAIN_CLS_KBK foreign key (MAIN_CLS_KBK_ID)
 -- references CLS_KBK (ID);
--alter table PAYDOCS
--  add constraint FK_PAYDOCS_MOVEPERIODS foreign key (MOVEPERIOD_ID)
--  references MOVEPERIODS (ID) on delete cascade
--  deferrable;
--alter table PAYDOCS
--  add constraint FK_PAYDOCS_OBLIG_PRESETS foreign key (OBLIG_PERIODICAL_PRESETS_ID)
--  references OBLIG_PERIODICAL_PRESETS (ID);
-- Create/Recreate check constraints 
alter table PAYDOCS
  add constraint CHK_PAYDOCS_CRDTPERCENTCONST
  check (CREDITPERCENTCONST IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_CRDTPERCENTDBT
  check (CREDITPERCENTONDEBT IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_CREDITPRSNTBYDAYS
  check (CREDITPERCENTBYDAYS IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_FINE_KIND
  check (FINE_KIND IN ('P','R','F'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_FINEONDEBT
  check (FINEONDEBT IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_FINEVALFIXDAILY
  check (FINEVALUEFIXED_DAILY IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_FN_ONCREDITPRSNT
  check (FINEONCREDITPERSENT IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_NO_CREDITPRSNT
  check (NO_CREDITPERCENT IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_NO_FINE
  check (NO_FINE IN ('Y','N'));
alter table PAYDOCS
  add constraint CHK_PAYDOCS_PAY_PERIOD_MONTHS
  check (CREDITPAY_PERIOD_MONTHS IN (1,3,6,12));
alter table PAYDOCS
  add constraint CK_PAYDOCS_CURRENCY
  check (CURRENCY IN ('Y','N'));
alter table PAYDOCS
  add constraint CK_PAYDOCS_KIND
  check (kind in ('A','B','N','P'));
alter table PAYDOCS
  add constraint CK_YEARLY_PAYSIZE
  check (IS_YEARLY_PAYSIZE IN ('Y','N'));
-- Grant/Revoke object privileges 
--grant select on PAYDOCS to DEP_ADDRESS;
--grant select on PAYDOCS to LETTER;
--grant select, insert, update, delete on PAYDOCS to SM_ALLUSERS;
--grant select, insert, update, delete on PAYDOCS to SM_ALLUSERS_RESTRICT;
--grant select, insert, update, delete on PAYDOCS to SM_NOCHARGES;
--grant select on PAYDOCS to SM_READONLY;
--grant delete on PAYDOCS to SM_REMOVEMOVESET;
--grant select on PAYDOCS to SM_TEST;

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table MOVESETS
(
  id                         NUMBER(27) not null,
  movetype_id                NUMBER(27) not null,
  client_id                  NUMBER(27) not null,
  prevclient_id              NUMBER(27),
  docset_id                  NUMBER(27) not null,
  transferbasis_id           NUMBER(27) not null,
  sharemove_id               NUMBER(27),
  hideinreports              CHAR(1) default 'N',
  verified                   CHAR(1) default 'Y',
  munreport_id               NUMBER(27),
  annulreasons_id            NUMBER(27),
  b_arbitrage                CHAR(1) default 'N' not null,
  notes                      VARCHAR2(4000),
  registereduser_id          NUMBER(27),
  insert_date                DATE default trunc(sysdate),
  municipal                  CHAR(1) default 'N' not null,
  complex_name               VARCHAR2(60),
  address_id                 NUMBER(27),
  complex_activities_id      NUMBER(27),
  complex_cost               NUMBER(13,3),
  complex_fixed_assets       NUMBER(13,3),
  complex_floating_assets    NUMBER(13,3),
  b_moveset_denial           CHAR(1) default 'N',
  b_changes_lock             CHAR(1) default 'N',
  date_changes_lock          DATE,
  branch_client_id           NUMBER(27),
  last_period_id             NUMBER(27),
  date_start_municipal       DATE,
  municipal_moveset_id       NUMBER(27),
  do_not_recalc_charges_date DATE,
  control_date               DATE,
  is_multi_subject           CHAR(1) default 'N',
  date_reg_egrp              DATE,
  date_end_municipal         DATE,
  foreigner                  CHAR(1) default 'N' not null,
  act_from_mio               CHAR(1) default 'N',
  storndate                  DATE,
  wasbase                    CHAR(1) default 'N',
  kiosk                      CHAR(1) default 'N',
  period_construction        CHAR(1) default 'N',
  claim_work_id              NUMBER(27)
)
tablespace USR
  pctfree 0
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MOVESETS
  is 'Операции движения';
-- Add comments to the columns 
comment on column MOVESETS.id
  is 'ID {BUTTON:300,115,75,20,"В поиск","Show_Moveset"}';
comment on column MOVESETS.movetype_id
  is 'Вид  движения ID';
comment on column MOVESETS.client_id
  is 'Название субъекта права ID';
comment on column MOVESETS.prevclient_id
  is 'Предыдущий субъект права ID {BUTTON:380,115,75,20,"Техпаспорт","Add_TP" OPTION:(MOVETYPE_ID=29)}';
comment on column MOVESETS.docset_id
  is 'Совпадает с docset_id последнего периода операции';
comment on column MOVESETS.transferbasis_id
  is 'Основание ID';
comment on column MOVESETS.sharemove_id
  is 'Движение ЦБ';
comment on column MOVESETS.hideinreports
  is 'Скрывать в отчётах';
comment on column MOVESETS.verified
  is 'Кадаст. 2011{FIELD:5,65,200,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.munreport_id
  is 'Ссылка на ID отчета';
comment on column MOVESETS.annulreasons_id
  is 'Состояние операции ID {FIELD:95,25,200,14 LABEL:5,27,70,14,"Состояние" OPTION:((MOVETYPE_ID=1) or (MOVETYPE_ID=3)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19) or (MOVETYPE_ID=23) or (MOVETYPE_ID=22) or (MOVETYPE_ID=27) or (MOVETYPE_ID=29) or (MOVETYPE_ID=34) or (MOVETYPE_ID=37)or (MOVETYPE_ID=39)or (MOVETYPE_ID=56)or (MOVETYPE_ID=46))}';
comment on column MOVESETS.b_arbitrage
  is 'Арбитражный суд был {FIELD:5,45,133,14 OPTION:((MOVETYPE_ID=4)or (MOVETYPE_ID=57))}';
comment on column MOVESETS.notes
  is 'Примечание {FIELD:300,5,360,100}';
comment on column MOVESETS.registereduser_id
  is 'Ответственный {FIELD:95,5,200,14 LABEL:5,7,80,14,"Ответственный" OPTION:((MOVETYPE_ID=1) or (MOVETYPE_ID=3)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19) or (MOVETYPE_ID=23) or (MOVETYPE_ID=22) or (MOVETYPE_ID=27) or (MOVETYPE_ID=29)or (MOVETYPE_ID=34)or (MOVETYPE_ID=39)or(MOVETYPE_ID=37)or(MOVETYPE_ID=46)or (MOVETYPE_ID=56) or(MOVETYPE_ID=47))}';
comment on column MOVESETS.insert_date
  is 'Дата добавления';
comment on column MOVESETS.municipal
  is 'Муниципальный объект {FIELD:5,85,140,14 OPTION:((MOVETYPE_ID=22) or(MOVETYPE_ID=37) or (MOVETYPE_ID=1004))}';
comment on column MOVESETS.complex_name
  is 'Наименование комплекса {FIELD:96,47,198,14 LABEL:5,47,70,14,"Комплекс" OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.address_id
  is 'Адрес ID {FIELD:9,67,290,14 OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_activities_id
  is 'Деятельность комплекса имущества {FIELD:96,85,198,14 LABEL:5,87,70,14,"Деятельность" LINE:310,0,0,107 OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_cost
  is 'Стоимость комплекса {FIELD:357,98,60,14 LABEL:300,98,70,14,"Стоимость" OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_fixed_assets
  is 'Основные средства комплекса {FIELD:477,98,60,14 LABEL:422,98,70,14,"Осн. сред." OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_floating_assets
  is 'Оборотные средства коплекса {FIELD:600,98,60,14 LABEL:540,98,70,14,"Обор. сред." OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.b_moveset_denial
  is 'Отказ от права собственности {FIELD:5,45,210,14 OPTION:(MOVETYPE_ID=1)}';
comment on column MOVESETS.b_changes_lock
  is 'Изменение реквизитов объекта c {FIELD:5,85,220,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=1) or (MOVETYPE_ID=3) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19))}';
comment on column MOVESETS.date_changes_lock
  is 'Дата изменения реквизитов объекта {FIELD:220,83,75,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=1) or (MOVETYPE_ID=3) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19))}';
comment on column MOVESETS.branch_client_id
  is 'Филиал {FIELD:50,100,245,14 LABEL:5,100,40,14,"Филиал" OPTION:((MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=57) or (MOVETYPE_ID=19) or (MOVETYPE_ID=3) or (MOVETYPE_ID=1) or (MOVETYPE_ID=23) )}';
comment on column MOVESETS.last_period_id
  is 'Последний период ID {BUTTON:380,115,75,20,"КБК","Show_KBK" OPTION:(MOVETYPE_ID<>29) }';
comment on column MOVESETS.date_start_municipal
  is 'Дата начала муницпальной собственности {FIELD:162,65,80,14 LABEL:150,67,5,14,"c" OPTION:((MOVETYPE_ID=1004))}';
comment on column MOVESETS.municipal_moveset_id
  is 'Ссылка на муниципальную ОП собственность для аренды земли (заполнить как нить)';
comment on column MOVESETS.do_not_recalc_charges_date
  is 'Дата, до которой не пересичтывать начисления FIELD:180,120,115,14 LABEL:5,122,140,14,не пересчитывать начисления до';
comment on column MOVESETS.control_date
  is 'Дата контроля {LABEL:5,57,100,14,"Дата контроля продления договора" FIELD:220,55,75,14 OPTION:(MOVETYPE_ID=29)}';
comment on column MOVESETS.is_multi_subject
  is 'Множественность лиц на стороне субъекта';
comment on column MOVESETS.date_reg_egrp
  is 'Дата регистрации договора в ЕГРП {LABEL:22,122,220,14,"Дата регистрации договора в ЕГРП" FIELD:220,120,75,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=46)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=30) or (MOVETYPE_ID=47) or (MOVETYPE_ID=16) or (MOVETYPE_ID=12) or (MOVETYPE_ID=39) or (MOVETYPE_ID=18) or (MOVETYPE_ID=3) or (MOVETYPE_ID=5))}';
comment on column MOVESETS.date_end_municipal
  is 'Дата окончания мун.собственности{LABEL:22,85,220,14,"Дата окончания мун.собственности" FIELD:220,85,75,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=46) or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=30) or (MOVETYPE_ID=47) or (MOVETYPE_ID=16) or (MOVETYPE_ID=12) or (MOVETYPE_ID=39) or (MOVETYPE_ID=18) or (MOVETYPE_ID=3) or (MOVETYPE_ID=5))}';
comment on column MOVESETS.foreigner
  is 'Иностранцы{FIELD:150,45,133,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9)or (MOVETYPE_ID = 57))}';
comment on column MOVESETS.act_from_mio
  is 'По акту из МИО{FIELD:150,65,133,14 OPTION:((ANNULREASONS_ID = 568) or (ANNULREASONS_ID = 570) or (ANNULREASONS_ID = 582)or (ANNULREASONS_ID = 962)or (ANNULREASONS_ID = 2446)or (ANNULREASONS_ID = 2447)or (ANNULREASONS_ID = 1525)or (ANNULREASONS_ID =2300)or (ANNULREASONS_ID = 2303)or (ANNULREASONS_ID = 2321)or (ANNULREASONS_ID = 2362))}';
comment on column MOVESETS.storndate
  is 'Дата сторнирования {FIELD:576,118,86,14 LABEL:463,120,70,14,"Дата сторнирования" OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=7) or (MOVETYPE_ID=27))}';
comment on column MOVESETS.wasbase
  is 'Был базовым{FIELD:95,65,100,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.kiosk
  is 'НТО{FIELD:605,115,110,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.period_construction
  is 'Период установки{FIELD:480,115,120,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.claim_work_id
  is 'Претенз.работа {FIELD:95,142,200,14 LABEL:5,142,70,14,"Претенз.работа " OPTION:((MOVETYPE_ID=1) or (MOVETYPE_ID=3)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19) or (MOVETYPE_ID=23) or (MOVETYPE_ID=22) or (MOVETYPE_ID=27) or (MOVETYPE_ID=29) or (MOVETYPE_ID=34) or (MOVETYPE_ID=37)or (MOVETYPE_ID=39)or (MOVETYPE_ID=56)or (MOVETYPE_ID=46))}';
-- Create/Recreate indexes 
/*
create index IDX_MVS_ADDRESS_ID on MOVESETS (ADDRESS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_BRANCH_CLIENT_ID on MOVESETS (BRANCH_CLIENT_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_CLIENT_ID on MOVESETS (CLIENT_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_DOCSET_ID on MOVESETS (DOCSET_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_LAST_PERIOD_ID on MOVESETS (LAST_PERIOD_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_MUNREPORT_ID on MOVESETS (MUNREPORT_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_PREVCLIENT_ID on MOVESETS (PREVCLIENT_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_SHAREMOVE_ID on MOVESETS (SHAREMOVE_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IX_MVS_MOVETYPE_ANNUALREAS on MOVESETS (MOVETYPE_ID, ANNULREASONS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
-- Create/Recreate primary, unique and foreign key constraints 
alter table MOVESETS
  add constraint PK_MOVESETS primary key (ID)
  using index 
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
--alter table MOVESETS
--  add constraint CS_MS_SHAREMOVE foreign key (SHAREMOVE_ID)
--  references SHAREMOVE (ID)
--  deferrable;
--alter table MOVESETS
--  add constraint FK_COMPLEX_ACTIVITIES_ID foreign key (COMPLEX_ACTIVITIES_ID)
--  references COMPLEX_ACTIVITIES (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_ADDRESS_ID foreign key (ADDRESS_ID)
--  references ADDRESS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_ANNULREASONS foreign key (ANNULREASONS_ID)
--  references ANNULREASONS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_CLAIMWORK_TYPE foreign key (CLAIM_WORK_ID)
--  references CLAIM_WORK_TYPE (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_CLIENT foreign key (CLIENT_ID)
--  references CLIENTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_CLIENTS foreign key (BRANCH_CLIENT_ID)
--  references CLIENTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_DOCSET foreign key (DOCSET_ID)
--  references DOCSETS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_MOVETYPE foreign key (MOVETYPE_ID)
--  references MOVETYPE (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_MUN_MOVESETS foreign key (MUNICIPAL_MOVESET_ID)
--  references MOVESETS (ID)
--  deferrable initially deferred;
--alter table MOVESETS
--  add constraint FK_MOVESETS_MUNREPORT foreign key (MUNREPORT_ID)
--  references MUNREPORTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_PREVCLIENT foreign key (PREVCLIENT_ID)
--  references CLIENTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_REGISTEREDUSERS foreign key (REGISTEREDUSER_ID)
--  references REGISTEREDUSERS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_TRANSFERBASIS foreign key (TRANSFERBASIS_ID)
--  references TRANSFERBASIS (ID);
-- Create/Recreate check constraints 
alter table MOVESETS
  add constraint ACT_FROM_MIO_CH
  check (ACT_FROM_MIO  IN ('Y','N'));
alter table MOVESETS
  add constraint CHK_MOVESET_MULTI_SUBJECTS
  check (IS_MULTI_SUBJECT IN ('Y','N'));
alter table MOVESETS
  add constraint CS_ARBITRAGE
  check (b_arbitrage IN ('Y','N'));
alter table MOVESETS
  add constraint CS_B_CHANGES_LOCK
  check (B_CHANGES_LOCK IN ('Y','N'));
alter table MOVESETS
  add constraint CS_FOREIGNER
  check (FOREIGNER IN ('Y','N'));
alter table MOVESETS
  add constraint CS_MOVESET_DENIAL
  check (B_MOVESET_DENIAL IN ('Y','N'));
alter table MOVESETS
  add constraint CS_MUNICIPAL
  check (municipal IN ('Y','N'));
alter table MOVESETS
  add constraint CS_PERIOD_CONSTRUCTION
  check (PERIOD_CONSTRUCTION IN ('Y','N'));
alter table MOVESETS
  add check (WASBASE IN ('Y','N'));
alter table MOVESETS
  add check (KIOSK IN ('Y','N'));
alter table MOVESETS
  add check (HideInReports IN ('Y','N'));
alter table MOVESETS
  add check (VERIFIED IN ('Y','N'));
-- Grant/Revoke object privileges 
--grant select on MOVESETS to DEP_ADDRESS;
--grant select on MOVESETS to LETTER;
--grant select on MOVESETS to LOADER;
--grant select on MOVESETS to SM_ALLUSERS;
--grant select on MOVESETS to SM_ALLUSERS_RESTRICT;
--grant select, update on MOVESETS to SM_CANDISCOUNT;
--grant select, insert, update on MOVESETS to SM_CANMOVE;
--grant select, insert, update, delete on MOVESETS to SM_LAND_PARAMS;
--grant select on MOVESETS to SM_NOCHARGES;
--grant select on MOVESETS to SM_READONLY;
--grant delete on MOVESETS to SM_REMOVEMOVESET;
--grant select on MOVESETS to SM_TEST;

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table MOVEPERIODS
(
  id                    NUMBER(27) not null,
  sincedate             DATE not null,
  enddate               DATE,
  moveset_id            NUMBER(27) not null,
  docset_id             NUMBER(27) not null,
  prev_moveperiod_id    NUMBER(27),
  changedby             VARCHAR2(30),
  writedate             DATE,
  periodtypes_id        NUMBER(27),
  preferencetypes_id    NUMBER(27),
  preference_value      NUMBER(28,3),
  not_recalc_obl        CHAR(1) default 'N',
  modify_kfx            NUMBER(10,2),
  two_percent           CHAR(1) default 'N',
  date_of_charging      NUMBER(27),
  zeroseven             CHAR(1) default 'N',
  changed_ccost         CHAR(1),
  last_date_of_charging CHAR(1) default 'N'
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MOVEPERIODS
  is 'Периоды операции движения';
-- Add comments to the columns 
comment on column MOVEPERIODS.id
  is 'ID';
comment on column MOVEPERIODS.sincedate
  is 'Дата начала';
comment on column MOVEPERIODS.enddate
  is 'Дата окончания';
comment on column MOVEPERIODS.moveset_id
  is 'Операция движения ID';
comment on column MOVEPERIODS.docset_id
  is 'На основании пакета документов ID';
comment on column MOVEPERIODS.prev_moveperiod_id
  is 'Предыдущий период ID';
comment on column MOVEPERIODS.changedby
  is 'Подпись';
comment on column MOVEPERIODS.writedate
  is 'Дата подписания';
comment on column MOVEPERIODS.periodtypes_id
  is 'Тип периода ID {FIELD:90,3,250,14 LABEL:5,5,70,14,"Тип периода" OPTION:((MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=1) or (MOVESETS.MOVETYPE_ID=22) or (MOVESETS.MOVETYPE_ID=21) or (MOVESETS.MOVETYPE_ID=20) or (MOVESETS.MOVETYPE_ID=27) or (MOVESETS.MOVETYPE_ID=23) or (MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=5) or (MOVESETS.MOVETYPE_ID=9) or (MOVESETS.MOVETYPE_ID=19) or (MOVESETS.MOVETYPE_ID=18) or (MOVESETS.MOVETYPE_ID=3) or (MOVESETS.MOVETYPE_ID=27)or (MOVESETS.MOVETYPE_ID=57) or (MOVESETS.MOVETYPE_ID=28))}';
comment on column MOVEPERIODS.preferencetypes_id
  is 'Тип льготы ID   {FIELD:10,15,450,14 LABEL:10,3,70,14,"Тип льготы" OPTION:(MOVESETS.MOVETYPE_ID=10)}';
comment on column MOVEPERIODS.preference_value
  is 'Величина льготы ID  {FIELD:470,17,100,14 LABEL:470,3,470,14,"Величина льготы" OPTION:(MOVESETS.MOVETYPE_ID=10)}';
comment on column MOVEPERIODS.not_recalc_obl
  is 'Не пересчитывать обязательство {FIELD:90,30,200,10 OPTION:((MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=1) or (MOVESETS.MOVETYPE_ID=22) or (MOVESETS.MOVETYPE_ID=21) or (MOVESETS.MOVETYPE_ID=20) or (MOVESETS.MOVETYPE_ID=27) or (MOVESETS.MOVETYPE_ID=23) or (MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=5) or (MOVESETS.MOVETYPE_ID=9) or (MOVESETS.MOVETYPE_ID=19) or (MOVESETS.MOVETYPE_ID=18) or (MOVESETS.MOVETYPE_ID=3) or (MOVESETS.MOVETYPE_ID=37))}';
comment on column MOVEPERIODS.modify_kfx
  is 'почему тут надо бы перенести в мувайтемс';
comment on column MOVEPERIODS.two_percent
  is 'Вести рассчет по 2% от кад.стоимости {FIELD:90,70,200,10 OPTION:( (MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=9))}';
comment on column MOVEPERIODS.date_of_charging
  is 'Число начисления для приватизации{FIELD:90,105,80,14 LABEL:180,105,70,14,"Число месяца начисления по приватизации"}';
comment on column MOVEPERIODS.zeroseven
  is 'Вести рассчет по 0.7р от площади {FIELD:90,85,200,10 OPTION:( (MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=9))}';
comment on column MOVEPERIODS.changed_ccost
  is 'Изменение кадастр.стоимости {FIELD:90,130,200,10 OPTION:( (MOVESETS.MOVETYPE_ID=4) or (MOVESETS.MOVETYPE_ID=9))}';
comment on column MOVEPERIODS.last_date_of_charging
  is 'Последний день (игнорирует число месяца) {FIELD:90,70,300,10 OPTION:(MOVESETS.MOVETYPE_ID=7)}';
-- Create/Recreate indexes 
/*
create index IDX_MPR_CHANGEDBY_WRITEDATE on MOVEPERIODS (CHANGEDBY, WRITEDATE)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MPR_DOCSET_ID on MOVEPERIODS (DOCSET_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MPR_END_DATE on MOVEPERIODS (ENDDATE)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MPR_MOVESET_ID on MOVEPERIODS (MOVESET_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MPR_PREV_MOVEPERIOD_ID on MOVEPERIODS (PREV_MOVEPERIOD_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MPR_SINCE_DATE on MOVEPERIODS (SINCEDATE)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index SYS_C006966 on MOVEPERIODS (ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
*/
-- Create/Recreate primary, unique and foreign key constraints 
alter table MOVEPERIODS
  add constraint PK_MOVEPERIODS primary key (ID);
--alter table MOVEPERIODS
--  add constraint FK_DOCSETS_ID foreign key (DOCSET_ID)
--  references DOCSETS (ID)
--  deferrable;
--alter table MOVEPERIODS
--  add constraint FK_MOVEPERIODS_MOVESET_ID foreign key (MOVESET_ID)
--  references MOVESETS (ID);
--alter table MOVEPERIODS
--  add constraint FK_MOVEPERIODS_PERIODTYPES foreign key (PERIODTYPES_ID)
--  references PERIODTYPES (ID);
--alter table MOVEPERIODS
--  add constraint FK_MOVEPERIODS_PREFERENCETYP1 foreign key (PREFERENCETYPES_ID)
--  references PREFERENCETYPES (ID);
--alter table MOVEPERIODS
--  add constraint FK_MOVEPERIODS_PREV_MOVEPERIOD foreign key (PREV_MOVEPERIOD_ID)
--  references MOVEPERIODS (ID)
--  deferrable;
-- Create/Recreate check constraints 
alter table MOVEPERIODS
  add constraint CS_NOT_RECALC_OBL
  check (not_recalc_obl IN ('Y','N'));
alter table MOVEPERIODS
  add constraint CS_TEST_CH_CCOST
  check (CHANGED_CCOST IN('Y','N'));
alter table MOVEPERIODS
  add constraint CS_TEST_DATE_CHARGING
  check (DATE_OF_CHARGING>0 and DATE_OF_CHARGING<=30);
alter table MOVEPERIODS
  add constraint CS_TEST_LAST_DAY
  check (LAST_DATE_OF_CHARGING  IN('Y','N'));
alter table MOVEPERIODS
  add constraint CS_TEST_ZEROSEVEN
  check (ZEROSEVEN IN('Y','N'));
alter table MOVEPERIODS
  add constraint CS_TEST_2PERCENT
  check (TWO_PERCENT IN('Y','N'));
-- Grant/Revoke object privileges 
--grant select on MOVEPERIODS to DEP_ADDRESS;
--grant select on MOVEPERIODS to LETTER;
--grant select on MOVEPERIODS to LOADER;
--grant select on MOVEPERIODS to SM_ALLUSERS;
--grant select on MOVEPERIODS to SM_ALLUSERS_RESTRICT;
--grant select, update on MOVEPERIODS to SM_CANDISCOUNT;
--grant select, insert, update, delete on MOVEPERIODS to SM_CANMOVE;
--grant select on MOVEPERIODS to SM_NOCHARGES;
--grant select on MOVEPERIODS to SM_READONLY;
--grant delete on MOVEPERIODS to SM_REMOVEMOVESET;
--grant select on MOVEPERIODS to SM_TEST;
