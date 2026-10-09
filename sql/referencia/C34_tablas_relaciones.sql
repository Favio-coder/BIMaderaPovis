-- C34: estructura de 110 DBF. No contiene datos ni crea una base de datos.
-- Elegir una base de datos vacía/de desarrollo en SSMS antes de ejecutar.
-- Sección 1: tablas. Sección 2: relaciones opcionales. Sección 3: propuestas pendientes.
-- Los campos originales admiten NULL para la carga inicial. _NullFlags se conserva como binario.
-- Hay incidencias de origen: consultar el MD antes de preparar una carga de datos.
-- Textos BIN2 para evitar fusionar códigos por mayúsculas o acentos.
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO
BEGIN TRY
BEGIN TRANSACTION;
IF SCHEMA_ID(N'c34') IS NULL EXEC(N'CREATE SCHEMA [c34]');
IF OBJECT_ID(N'c34.AFPS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.AFPS; no se sobrescribe.', 1;
-- AFPS: 5 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[AFPS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_AFPS] PRIMARY KEY,
    [C_AFP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AFP] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.AGENTES', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.AGENTES; no se sobrescribe.', 1;
-- AGENTES: 2069 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[AGENTES] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_AGENTES] PRIMARY KEY,
    [C_AGEN] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AGEN] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [L_RESP] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DIRE] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [L_GIRO] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_TELE] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CELU] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TIPA] decimal(1,0) NULL,
    [L_OBSE] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [EMAIL] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [S_LIMI] decimal(15,2) NULL,
    [F_APRO] date NULL,
    [F_LIMI] date NULL,
    [Q_FLET] decimal(1,0) NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL,
    [K_AGEN] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_APAT] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AMAT] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOM1] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOM2] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_ESTA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_UBIG] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [L_COND] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.AGENTRESP', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.AGENTRESP; no se sobrescribe.', 1;
-- AGENTRESP: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[AGENTRESP] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_AGENTRESP] PRIMARY KEY,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_RESP] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DIRE] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [N_TELE] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.AGRECRED', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.AGRECRED; no se sobrescribe.', 1;
-- AGRECRED: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[AGRECRED] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_AGRECRED] PRIMARY KEY,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CRED] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DESD] date NULL,
    [F_HAST] date NULL,
    [Q_ESTA] decimal(1,0) NULL,
    [N_DIAS] decimal(2,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.AGRESPRO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.AGRESPRO; no se sobrescribe.', 1;
-- AGRESPRO: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[AGRESPRO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_AGRESPRO] PRIMARY KEY,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CRED] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ORDE] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_CANT] decimal(11,4) NULL,
    [S_PUNIT] decimal(11,4) NULL,
    [S_TOTA] decimal(11,4) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.ALMACEN', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ALMACEN; no se sobrescribe.', 1;
-- ALMACEN: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ALMACEN] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ALMACEN] PRIMARY KEY,
    [C_ALMA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ALMA] nvarchar(40) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CODE] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.ALMCOMB', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ALMCOMB; no se sobrescribe.', 1;
-- ALMCOMB: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ALMCOMB] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ALMCOMB] PRIMARY KEY,
    [F_REGS] date NULL,
    [C_TANQ] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [S_STOK] decimal(15,4) NULL
);
IF OBJECT_ID(N'c34.ALMCOMBCA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ALMCOMBCA; no se sobrescribe.', 1;
-- ALMCOMBCA: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ALMCOMBCA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ALMCOMBCA] PRIMARY KEY,
    [C_TANQ] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TANQ] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [S_CAPA] decimal(15,4) NULL,
    [S_CAMA] decimal(15,4) NULL,
    [S_MARG] decimal(15,4) NULL
);
IF OBJECT_ID(N'c34.ASIDEST', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ASIDEST; no se sobrescribe.', 1;
-- ASIDEST: 586 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ASIDEST] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ASIDEST] PRIMARY KEY,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_DEBE] decimal(20,7) NULL,
    [S_HABE] decimal(20,7) NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.ASOCIADO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ASOCIADO; no se sobrescribe.', 1;
-- ASOCIADO: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ASOCIADO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ASOCIADO] PRIMARY KEY,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_APAT] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AMAT] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOMB] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DIRE] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DNI] nvarchar(8) COLLATE Latin1_General_100_BIN2 NULL,
    [N_TELE] nvarchar(40) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COL1] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COL2] nvarchar(8) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COL3] nvarchar(8) COLLATE Latin1_General_100_BIN2 NULL,
    [MAIL] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [F_INGR] date NULL,
    [F_NACI] date NULL,
    [F_ULTP] date NULL,
    [L_FOTO] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ESTC] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DERH] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SEXO] decimal(1,0) NULL,
    [EMAIL] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [K_PERS] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_UNIV] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_HABI] decimal(1,0) NULL,
    [N_GRAD] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CONC] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CONC1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SERV] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_MEDI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] date NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.BANCOS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.BANCOS; no se sobrescribe.', 1;
-- BANCOS: 33 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[BANCOS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_BANCOS] PRIMARY KEY,
    [C_BANC] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_BANC] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.BIENES', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.BIENES; no se sobrescribe.', 1;
-- BIENES: 17 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[BIENES] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_BIENES] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_BIEN] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [L_BIEN] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [F_ADQU] date NULL,
    [S_LIBR] decimal(15,2) NULL,
    [S_RESI] decimal(15,2) NULL,
    [S_DEPA] decimal(15,2) NULL,
    [Q_ESTA] decimal(1,0) NULL,
    [F_BAJA] date NULL,
    [L_UBIC] nvarchar(40) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAA] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAG] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [N_MES] decimal(4,0) NULL,
    [S_PORC] decimal(6,2) NULL,
    [N_MESD] decimal(4,0) NULL,
    [L_MARC] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MODE] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_SERI] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [K_METD] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_AUTM] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [S_INIC] decimal(11,2) NULL,
    [S_ADQA] decimal(11,2) NULL,
    [S_MEJO] decimal(11,2) NULL,
    [S_RETI] decimal(11,2) NULL,
    [S_BAJA] decimal(11,2) NULL,
    [S_OTRA] decimal(11,2) NULL,
    [S_HIST] decimal(11,2) NULL,
    [S_INFL] decimal(11,2) NULL,
    [S_AJUS] decimal(11,2) NULL,
    [F_INIC] date NULL,
    [S_DEPR] decimal(11,2) NULL,
    [S_DEPB] decimal(11,2) NULL,
    [S_DEPO] decimal(11,2) NULL,
    [S_DEPAH] decimal(11,2) NULL,
    [S_AJUSID] decimal(11,2) NULL,
    [S_DEPAAI] decimal(11,2) NULL,
    [C_COSTB] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_TAB19] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TAB18] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPOME] decimal(11,2) NULL,
    [K_MONEC] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPCC] decimal(7,4) NULL,
    [S_TIPC31] decimal(7,4) NULL,
    [S_AJUSDIF] decimal(11,2) NULL,
    [S_MONAC] decimal(11,2) NULL,
    [Q_ARRF] decimal(1,0) NULL,
    [F_ARRE] date NULL,
    [F_INIARRE] date NULL,
    [N_CUOTARRE] decimal(5,0) NULL,
    [S_TOTARRE] decimal(11,2) NULL,
    [N_CONARR] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(2) NULL
);
IF OBJECT_ID(N'c34.CAJA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CAJA; no se sobrescribe.', 1;
-- CAJA: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CAJA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CAJA] PRIMARY KEY,
    [N_REGI] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CONC] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [F_OPER] date NULL,
    [F_COMP] date NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(11,2) NULL,
    [L_OBSE] nvarchar(90) COLLATE Latin1_General_100_BIN2 NULL,
    [C_VEND] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ISLA] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TURN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.CALCREI', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CALCREI; no se sobrescribe.', 1;
-- CALCREI: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CALCREI] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CALCREI] PRIMARY KEY,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CREI] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.CARGOS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CARGOS; no se sobrescribe.', 1;
-- CARGOS: 3 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CARGOS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CARGOS] PRIMARY KEY,
    [C_CARG] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CARG] nvarchar(60) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.CENTCOST', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CENTCOST; no se sobrescribe.', 1;
-- CENTCOST: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CENTCOST] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CENTCOST] PRIMARY KEY,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_COST] nvarchar(90) COLLATE Latin1_General_100_BIN2 NULL,
    [L_REFE] nvarchar(90) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.CODADUANA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CODADUANA; no se sobrescribe.', 1;
-- CODADUANA: 30 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CODADUANA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CODADUANA] PRIMARY KEY,
    [C_ADUA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ADUA] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.CONCEPTO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CONCEPTO; no se sobrescribe.', 1;
-- CONCEPTO: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CONCEPTO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CONCEPTO] PRIMARY KEY,
    [C_CONC] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CONC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEBE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HABE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [K_GAST] decimal(1,0) NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(11,2) NULL,
    [C_PPTO] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_META] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_PERI] decimal(1,0) NULL,
    [Q_CAMB] decimal(1,0) NULL,
    [Q_INAF] decimal(1,0) NULL
);
IF OBJECT_ID(N'c34.CONCPAGOS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CONCPAGOS; no se sobrescribe.', 1;
-- CONCPAGOS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CONCPAGOS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CONCPAGOS] PRIMARY KEY,
    [C_CONC] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CONC] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEN] nvarchar(14) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(11,2) NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.CONDUCTOR', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CONDUCTOR; no se sobrescribe.', 1;
-- CONDUCTOR: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CONDUCTOR] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CONDUCTOR] PRIMARY KEY,
    [C_TRAN] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TRAN] nvarchar(40) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DIRE] nvarchar(40) COLLATE Latin1_General_100_BIN2 NULL,
    [N_PLAC] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_LICC] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MARC] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_REMO] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CONS] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CODI] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.CTACTE', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CTACTE; no se sobrescribe.', 1;
-- CTACTE: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CTACTE] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CTACTE] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DEUD] nvarchar(23) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TOTA] decimal(15,2) NULL,
    [S_AMOR] decimal(15,2) NULL,
    [S_NOTC] decimal(15,2) NULL,
    [S_NOTD] decimal(15,2) NULL,
    [F_PROC] date NULL,
    [F_DETR] date NULL,
    [K_PAGO] decimal(1,0) NULL,
    [K_CTA] decimal(1,0) NULL,
    [CANCELADO] bit NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP] date NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [S_INIC] decimal(15,2) NULL,
    [S_DSCT] decimal(15,2) NULL,
    [C_GARA] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [TIPC] decimal(11,3) NULL,
    [C_COMP1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP1] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER1] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_GENL] bit NULL,
    [Q_MARC] bit NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.CTAPDT', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.CTAPDT; no se sobrescribe.', 1;
-- CTAPDT: 1284 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[CTAPDT] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CTAPDT] PRIMARY KEY,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.DATPERS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DATPERS; no se sobrescribe.', 1;
-- DATPERS: 15 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DATPERS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DATPERS] PRIMARY KEY,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_APAT] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AMAT] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOMB] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SERV] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_UBIC] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [K_COND] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CATE] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEDI] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_BPAG] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_BPAG] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_BCTS] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_BCTS] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] decimal(1,0) NULL,
    [C_AUTG] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AFP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USPP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [F_AFIL] date NULL,
    [F_INGR] date NULL,
    [F_NACI] date NULL,
    [F_INIC] date NULL,
    [F_FINC] date NULL,
    [C_CARG] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CUBI] nvarchar(40) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ESPE] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROF] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DOMI] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SEXO] decimal(1,0) NULL,
    [N_TELE] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [FOTO] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [FIRMA] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_POLI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_ESVI] decimal(1,0) NULL,
    [Q_SCTR] decimal(1,0) NULL,
    [C_SITU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [S_BASI] decimal(11,2) NULL,
    [C_SEGU] decimal(1,0) NULL
);
IF OBJECT_ID(N'c34.DATPERSITEMS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DATPERSITEMS; no se sobrescribe.', 1;
-- DATPERSITEMS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DATPERSITEMS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DATPERSITEMS] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PLAN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DIAS] decimal(6,2) NULL,
    [S_JORN] decimal(11,2) NULL,
    [C_ITEM] nvarchar(5) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PORC] decimal(6,2) NULL,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEBE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HABE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_ITEM] decimal(11,2) NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.DEPBIEN', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DEPBIEN; no se sobrescribe.', 1;
-- DEPBIEN: 204 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DEPBIEN] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DEPBIEN] PRIMARY KEY,
    [C_BIEN] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [S_DEPR] decimal(15,2) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DESPROD1', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DESPROD1; no se sobrescribe.', 1;
-- DESPROD1: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DESPROD1] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESPROD1] PRIMARY KEY,
    [C_DES1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DES1] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DESPROD2', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DESPROD2; no se sobrescribe.', 1;
-- DESPROD2: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DESPROD2] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESPROD2] PRIMARY KEY,
    [C_DES2] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DES2] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DESPROD3', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DESPROD3; no se sobrescribe.', 1;
-- DESPROD3: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DESPROD3] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESPROD3] PRIMARY KEY,
    [C_DES3] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DES3] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DESPROD4', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DESPROD4; no se sobrescribe.', 1;
-- DESPROD4: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DESPROD4] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESPROD4] PRIMARY KEY,
    [C_DES4] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DES4] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DESPROD5', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DESPROD5; no se sobrescribe.', 1;
-- DESPROD5: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DESPROD5] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESPROD5] PRIMARY KEY,
    [C_DES5] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DES5] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DESTINO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DESTINO; no se sobrescribe.', 1;
-- DESTINO: 494 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DESTINO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESTINO] PRIMARY KEY,
    [C_CUPR] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CU01] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CU02] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PORC] decimal(6,2) NULL,
    [K_PLAN] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_ACTU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DET_VOUCH', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DET_VOUCH; no se sobrescribe.', 1;
-- DET_VOUCH: 7346 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DET_VOUCH] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DET_VOUCH] PRIMARY KEY,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PPTO] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_AFEC] decimal(20,7) NULL,
    [S_EXON] decimal(20,7) NULL,
    [S_DEBE] decimal(20,7) NULL,
    [S_HABE] decimal(20,7) NULL,
    [L_GLOS] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CHEQ] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_BENE] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_BANC] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [L_RAZS] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AUTO] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL,
    [C_COMP0] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI0] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP0] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP0] date NULL,
    [F_VENC0] date NULL,
    [Q_CONCB] decimal(1,0) NULL,
    [C_META] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [K_INGR] decimal(1,0) NULL,
    [C_TIPA] decimal(1,0) NULL,
    [K_TIPP] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ITEM] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MOVI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SITU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [F_CONC] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(2) NULL
);
IF OBJECT_ID(N'c34.DETCTACTE', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DETCTACTE; no se sobrescribe.', 1;
-- DETCTACTE: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DETCTACTE] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DETCTACTE] PRIMARY KEY,
    [N_DEUD] nvarchar(23) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ORDE] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_LETR] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(15,2) NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(9,4) NULL,
    [F_PAGO] date NULL,
    [F_VENC] date NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_CANC] bit NULL,
    [L_OBSE] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUENC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_INTE] decimal(11,2) NULL,
    [S_DSCT] decimal(11,2) NULL,
    [C_COMPC] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.DETTRANSAC', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DETTRANSAC; no se sobrescribe.', 1;
-- DETTRANSAC: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DETTRANSAC] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DETTRANSAC] PRIMARY KEY,
    [C_COMO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CONC] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(11,2) NULL,
    [PERIODO] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CUOT] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,4) NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER1] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSEM] nvarchar(35) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.DEUDAS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.DEUDAS; no se sobrescribe.', 1;
-- DEUDAS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[DEUDAS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DEUDAS] PRIMARY KEY,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DEUD] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(11,2) NULL,
    [S_DEUD] decimal(11,2) NULL,
    [C_CONC] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,4) NULL,
    [FECHA] date NULL,
    [N_CUOT] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [P_INTE] decimal(10,6) NULL,
    [PERIODO] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [CANCELADO] bit NULL,
    [OBSERVAC] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [ANULADO] bit NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [L_OBSEM] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.ENTITEM', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ENTITEM; no se sobrescribe.', 1;
-- ENTITEM: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ENTITEM] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ENTITEM] PRIMARY KEY,
    [ID_ENTR] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDI] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TALL] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CONV] decimal(11,5) NULL,
    [S_CANTEMP] decimal(15,5) NULL,
    [S_VENTEMP] decimal(15,7) NULL,
    [S_CANT] decimal(15,4) NULL,
    [S_VENT] decimal(15,7) NULL,
    [S_VENTEXON] decimal(15,7) NULL,
    [S_IVAP] decimal(15,7) NULL,
    [S_PBON] decimal(11,2) NULL,
    [IGVE] decimal(20,7) NULL,
    [BIMPE] decimal(20,7) NULL,
    [EXONE] decimal(20,7) NULL,
    [C_INDI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PORD] decimal(6,0) NULL,
    [S_DESC] decimal(13,2) NULL,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_META] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [K_INGR] decimal(1,0) NULL,
    [C_PPTO] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_FLET] decimal(1,0) NULL,
    [ENTR_ID] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PRFL] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [MED_E] decimal(3,0) NULL,
    [MED_A] decimal(3,0) NULL,
    [MED_L] decimal(3,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.ENTRADAS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ENTRADAS; no se sobrescribe.', 1;
-- ENTRADAS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ENTRADAS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ENTRADAS] PRIMARY KEY,
    [ID_ENTR] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [D_ANUL] bit NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP] date NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [K_PAGO] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_EXONE] decimal(20,7) NULL,
    [S_BIMP] decimal(20,7) NULL,
    [S_IGV] decimal(20,7) NULL,
    [S_IVAP] decimal(20,7) NULL,
    [S_TOTA] decimal(20,7) NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AGEN] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DIRE] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [C_GUIA] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERG] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_GUIA] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TRAN] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ALMA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ALM1] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [COMPREF] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [SERIREF] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [NUMREF] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL,
    [P_IGV] decimal(6,2) NULL,
    [P_IVAP] decimal(6,2) NULL,
    [K_TIPP] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CHEQ] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TIPO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [C_DUAA] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_TRNSF] decimal(1,0) NULL,
    [F_PAGO] date NULL,
    [Q_EXON] decimal(1,0) NULL,
    [C_EXON] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [SWE] decimal(1,0) NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.FACTORES', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FACTORES; no se sobrescribe.', 1;
-- FACTORES: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FACTORES] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FACTORES] PRIMARY KEY,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MES] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [S_FACT] decimal(7,4) NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.FBALANCE', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FBALANCE; no se sobrescribe.', 1;
-- FBALANCE: 190 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FBALANCE] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FBALANCE] PRIMARY KEY,
    [C_ITEM] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ITEM] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [FORMULA] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEF] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [SIGNO] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_TIPO] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FESF', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FESF; no se sobrescribe.', 1;
-- FESF: 84 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FESF] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FESF] PRIMARY KEY,
    [K_TIPO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ITEM] nvarchar(200) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ITEM] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_NEGR] decimal(1,0) NULL,
    [L_TITU] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOTA] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOT1] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_TOTG] decimal(1,0) NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.FORMATO3_13', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_13; no se sobrescribe.', 1;
-- FORMATO3_13: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_13] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_13] PRIMARY KEY,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AGEN] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DESC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [F_EMIS] date NULL,
    [S_IMPO] decimal(11,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FORMATO3_14', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_14; no se sobrescribe.', 1;
-- FORMATO3_14: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_14] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_14] PRIMARY KEY,
    [C_DOCU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AGEN] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(11,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FORMATO3_15', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_15; no se sobrescribe.', 1;
-- FORMATO3_15: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_15] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_15] PRIMARY KEY,
    [L_CONC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [SALDO] decimal(11,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [ADICION] decimal(11,2) NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [DEDUCCION] decimal(11,2) NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.FORMATO3_16', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_16; no se sobrescribe.', 1;
-- FORMATO3_16: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_16] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_16] PRIMARY KEY,
    [F_FORM] date NULL,
    [S_CAPI] decimal(12,2) NULL,
    [S_NOMI] decimal(12,2) NULL,
    [N_ACC1] decimal(7,0) NULL,
    [N_ACC2] decimal(7,0) NULL,
    [N_SOCI] decimal(7,0) NULL,
    [N_ITEM] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AGEN] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [K_ACCI] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ACCI] decimal(11,2) NULL,
    [P_PART] decimal(6,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FORMATO3_19', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_19; no se sobrescribe.', 1;
-- FORMATO3_19: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_19] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_19] PRIMARY KEY,
    [N_ITEM] decimal(2,0) NULL,
    [C_ITEM] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ITEM] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IM01] decimal(12,2) NULL,
    [S_IM02] decimal(12,2) NULL,
    [S_IM03] decimal(12,2) NULL,
    [S_IM04] decimal(12,2) NULL,
    [S_IM05] decimal(12,2) NULL,
    [S_IM06] decimal(12,2) NULL,
    [S_IM07] decimal(12,2) NULL,
    [S_IM08] decimal(12,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FORMATO3_8', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_8; no se sobrescribe.', 1;
-- FORMATO3_8: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_8] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_8] PRIMARY KEY,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_AGEN] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DESC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [S_VALNOM] decimal(11,2) NULL,
    [S_CANT] decimal(11,2) NULL,
    [S_COST] decimal(11,2) NULL,
    [S_PROV] decimal(11,2) NULL,
    [S_TOTAL] decimal(11,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FORMATO3_9', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO3_9; no se sobrescribe.', 1;
-- FORMATO3_9: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO3_9] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO3_9] PRIMARY KEY,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [F_OPER] date NULL,
    [L_DESC] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [K_INTA] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [S_VALCONT] decimal(11,2) NULL,
    [S_AMOR] decimal(11,2) NULL,
    [S_NETO] decimal(11,2) NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.FORMATO7_2', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO7_2; no se sobrescribe.', 1;
-- FORMATO7_2: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO7_2] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO7_2] PRIMARY KEY,
    [COL01] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [COL02] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [COL03] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [COL04] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [COL05] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [COL06] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [COL07] decimal(11,2) NULL,
    [COL08] decimal(11,2) NULL,
    [COL09] decimal(11,2) NULL,
    [COL10] decimal(11,2) NULL,
    [COL11] decimal(11,2) NULL,
    [COL12] decimal(11,2) NULL,
    [COL13] decimal(11,2) NULL,
    [COL14] decimal(11,2) NULL,
    [COL15] decimal(11,2) NULL,
    [COL16] decimal(11,4) NULL,
    [COL17] decimal(11,2) NULL,
    [COL18] date NULL,
    [COL19] date NULL,
    [COL20] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [COL21] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [COL22] decimal(6,2) NULL,
    [COL23] decimal(11,2) NULL,
    [COL24] decimal(11,2) NULL,
    [COL25] decimal(11,2) NULL,
    [COL26] decimal(11,2) NULL,
    [COL27] decimal(11,2) NULL,
    [COL28] decimal(11,2) NULL,
    [COL29] decimal(11,2) NULL,
    [COL30] decimal(11,2) NULL,
    [COL31] decimal(11,4) NULL,
    [COL32] decimal(11,2) NULL
);
IF OBJECT_ID(N'c34.FORMATO7_3', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO7_3; no se sobrescribe.', 1;
-- FORMATO7_3: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO7_3] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO7_3] PRIMARY KEY,
    [COL01] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [COL02] date NULL,
    [COL03] decimal(11,2) NULL,
    [COL04] decimal(11,4) NULL,
    [COL05] decimal(11,2) NULL,
    [COL06] decimal(11,4) NULL,
    [COL07] decimal(11,2) NULL,
    [COL08] decimal(11,2) NULL,
    [COL09] decimal(11,2) NULL,
    [COL10] decimal(11,2) NULL,
    [COL11] decimal(11,2) NULL,
    [COL12] decimal(11,2) NULL
);
IF OBJECT_ID(N'c34.FORMATO7_4', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATO7_4; no se sobrescribe.', 1;
-- FORMATO7_4: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATO7_4] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATO7_4] PRIMARY KEY,
    [F_CONT] date NULL,
    [N_CONT] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [F_INIC] date NULL,
    [N_CUOTP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [S_CONT] decimal(13,2) NULL
);
IF OBJECT_ID(N'c34.FORMATOS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.FORMATOS; no se sobrescribe.', 1;
-- FORMATOS: 56 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[FORMATOS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_FORMATOS] PRIMARY KEY,
    [C_FORM] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ITEM] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ITEM] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IM01] decimal(15,2) NULL,
    [S_IM02] decimal(15,2) NULL,
    [S_IM03] decimal(15,2) NULL,
    [S_IM04] decimal(15,2) NULL,
    [S_IM05] decimal(15,2) NULL,
    [S_IM06] decimal(15,2) NULL,
    [S_IM07] decimal(15,2) NULL,
    [S_IM08] decimal(15,2) NULL,
    [S_IM09] decimal(15,2) NULL,
    [S_IM10] decimal(15,2) NULL,
    [S_TOTA] decimal(15,2) NULL
);
IF OBJECT_ID(N'c34.GENPVPROD', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.GENPVPROD; no se sobrescribe.', 1;
-- GENPVPROD: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[GENPVPROD] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GENPVPROD] PRIMARY KEY,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [MS] decimal(1,0) NULL,
    [PL] decimal(15,4) NULL,
    [D1] decimal(6,2) NULL,
    [D2] decimal(6,2) NULL,
    [D3] decimal(6,2) NULL,
    [D4] decimal(6,2) NULL,
    [D5] decimal(6,2) NULL,
    [I1] decimal(6,2) NULL,
    [I2] decimal(6,2) NULL,
    [I3] decimal(6,2) NULL,
    [I4] decimal(6,2) NULL,
    [I5] decimal(6,2) NULL,
    [IGV] decimal(6,2) NULL,
    [PERCEP] decimal(6,2) NULL,
    [FLETE] decimal(6,2) NULL,
    [PC] decimal(15,4) NULL,
    [PV] decimal(15,2) NULL,
    [TC] decimal(11,4) NULL,
    [PCS] decimal(11,2) NULL,
    [PVS] decimal(11,2) NULL,
    [UTILIDAD] decimal(6,2) NULL,
    [MARGEN] decimal(6,2) NULL,
    [L_OBSE] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.IMPOAFPS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.IMPOAFPS; no se sobrescribe.', 1;
-- IMPOAFPS: 132 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[IMPOAFPS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_IMPOAFPS] PRIMARY KEY,
    [C_MMAA] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AFP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [S_APOR] decimal(5,2) NULL,
    [S_SEGI] decimal(5,2) NULL,
    [S_COMF] decimal(5,2) NULL,
    [S_COMP] decimal(5,2) NULL,
    [S_AFP] decimal(10,2) NULL,
    [S_REMA] decimal(10,2) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.ISLAS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ISLAS; no se sobrescribe.', 1;
-- ISLAS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ISLAS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ISLAS] PRIMARY KEY,
    [C_ISLA] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ISLA] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_RESP] nvarchar(60) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.ITEMINGEGR', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.ITEMINGEGR; no se sobrescribe.', 1;
-- ITEMINGEGR: 21 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[ITEMINGEGR] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ITEMINGEGR] PRIMARY KEY,
    [C_ITEM] nvarchar(5) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ITEM] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PORC] decimal(6,2) NULL,
    [K_CALC] decimal(1,0) NULL,
    [C_DEBE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HABE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AFP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_DIRE] decimal(1,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.LETRAS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.LETRAS; no se sobrescribe.', 1;
-- LETRAS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[LETRAS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LETRAS] PRIMARY KEY,
    [N_DEUD] nvarchar(23) COLLATE Latin1_General_100_BIN2 NULL,
    [N_LETR] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(15,2) NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(9,4) NULL,
    [F_VENC] date NULL,
    [Q_CANC] decimal(1,0) NULL,
    [N_SERIL] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMPL] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.LIBREG', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.LIBREG; no se sobrescribe.', 1;
-- LIBREG: 31 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[LIBREG] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LIBREG] PRIMARY KEY,
    [C_LIBR] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_LIBR] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.LISTCOMPA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.LISTCOMPA; no se sobrescribe.', 1;
-- LISTCOMPA: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[LISTCOMPA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LISTCOMPA] PRIMARY KEY,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [F_OPER] date NULL,
    [Q_RETE] decimal(1,0) NULL,
    [Q_EXPO] decimal(1,0) NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(13,2) NULL,
    [S_EXO1] decimal(13,2) NULL,
    [C_CUE2] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMP2] decimal(13,2) NULL,
    [S_EXO2] decimal(13,2) NULL,
    [C_CUE3] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMP3] decimal(13,2) NULL,
    [S_EXO3] decimal(13,2) NULL,
    [C_CUE4] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMP4] decimal(13,2) NULL,
    [S_EXO4] decimal(13,2) NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ACOMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP] date NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [S_EFEC] decimal(15,2) NULL,
    [S_CRED] decimal(15,2) NULL,
    [S_CHEQ] decimal(15,2) NULL,
    [N_CHEQ] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_BENE] nvarchar(35) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [F_PAGO] date NULL,
    [S_BIMP] decimal(15,2) NULL,
    [S_EXON] decimal(15,2) NULL,
    [S_IGV] decimal(15,2) NULL,
    [S_OTRO] decimal(15,2) NULL,
    [S_TOTA] decimal(15,2) NULL,
    [L_GLOS] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMP1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP1] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP1] date NULL,
    [S_COMP1] decimal(15,2) NULL,
    [S_PERC] decimal(15,2) NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.LYRDET', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.LYRDET; no se sobrescribe.', 1;
-- LYRDET: 32 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[LYRDET] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LYRDET] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_LIBR] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [S_BIMP] decimal(11,2) NULL,
    [S_INAF] decimal(11,2) NULL,
    [S_EXON] decimal(11,2) NULL,
    [S_OTRO] decimal(11,2) NULL,
    [S_IGV] decimal(11,2) NULL,
    [S_TOTA] decimal(11,2) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.LYRELECT', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.LYRELECT; no se sobrescribe.', 1;
-- LYRELECT: 55 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[LYRELECT] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LYRELECT] PRIMARY KEY,
    [N_LIBR] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DESC] nvarchar(240) COLLATE Latin1_General_100_BIN2 NULL,
    [C_LIBR] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.MATASIE', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.MATASIE; no se sobrescribe.', 1;
-- MATASIE: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[MATASIE] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_MATASIE] PRIMARY KEY,
    [C_MATR] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MATR] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_MOST] decimal(1,0) NULL
);
IF OBJECT_ID(N'c34.MATASIEDET', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.MATASIEDET; no se sobrescribe.', 1;
-- MATASIEDET: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[MATASIEDET] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_MATASIEDET] PRIMARY KEY,
    [C_MATR] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [ITEM] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEBE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HABE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [K_ITEM] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.MEDICION', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.MEDICION; no se sobrescribe.', 1;
-- MEDICION: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[MEDICION] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_MEDICION] PRIMARY KEY,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [PERIODO] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [N_INIC] decimal(20,5) NULL,
    [N_FINA] decimal(20,5) NULL,
    [N_DIFE] decimal(20,5) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUAM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGIM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.MEDIPROD', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.MEDIPROD; no se sobrescribe.', 1;
-- MEDIPROD: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[MEDIPROD] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_MEDIPROD] PRIMARY KEY,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDI] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PRE1] decimal(15,4) NULL,
    [S_PRE2] decimal(15,4) NULL,
    [S_PRE3] decimal(15,4) NULL,
    [S_PRE4] decimal(15,4) NULL,
    [S_PRE5] decimal(15,4) NULL,
    [S_PESO] decimal(13,4) NULL,
    [S_POR1] decimal(8,4) NULL,
    [S_POR2] decimal(8,4) NULL,
    [S_POR3] decimal(8,4) NULL,
    [S_POR4] decimal(8,4) NULL,
    [S_POR5] decimal(8,4) NULL,
    [N_FACT] decimal(13,7) NULL,
    [C_BARR] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.METAPPTO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.METAPPTO; no se sobrescribe.', 1;
-- METAPPTO: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[METAPPTO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_METAPPTO] PRIMARY KEY,
    [C_META] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_META] nvarchar(200) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.MONEDA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.MONEDA; no se sobrescribe.', 1;
-- MONEDA: 3 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[MONEDA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_MONEDA] PRIMARY KEY,
    [C_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MONE] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_SIMB] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ABRV] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.MVTOCTA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.MVTOCTA; no se sobrescribe.', 1;
-- MVTOCTA: 4 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[MVTOCTA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_MVTOCTA] PRIMARY KEY,
    [K_MOVI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MOVI] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ABRV] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.NIVPLAN', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.NIVPLAN; no se sobrescribe.', 1;
-- NIVPLAN: 6 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[NIVPLAN] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_NIVPLAN] PRIMARY KEY,
    [N_NIVE] decimal(1,0) NULL,
    [L_NIVE] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.OPERACION', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.OPERACION; no se sobrescribe.', 1;
-- OPERACION: 14 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[OPERACION] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_OPERACION] PRIMARY KEY,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OPER] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [K_OPER] decimal(1,0) NULL,
    [Q_BLOC] decimal(1,0) NULL,
    [Q_DETA] decimal(1,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_TL08] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.PPTO_DET', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.PPTO_DET; no se sobrescribe.', 1;
-- PPTO_DET: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[PPTO_DET] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PPTO_DET] PRIMARY KEY,
    [C_PPTO] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MMAA] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PPTO] decimal(15,2) NULL,
    [S_EJEC] decimal(15,2) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [L_MMAA] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.PRESPTO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.PRESPTO; no se sobrescribe.', 1;
-- PRESPTO: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[PRESPTO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRESPTO] PRIMARY KEY,
    [C_META] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PPTO] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PPTO] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [N_NIVE] decimal(1,0) NULL,
    [K_INGR] decimal(1,0) NULL,
    [S_IM01] decimal(13,2) NULL,
    [S_IM02] decimal(13,2) NULL,
    [S_IM03] decimal(13,2) NULL,
    [S_IM04] decimal(13,2) NULL,
    [S_IM05] decimal(13,2) NULL,
    [S_IM06] decimal(13,2) NULL,
    [S_IM07] decimal(13,2) NULL,
    [S_IM08] decimal(13,2) NULL,
    [S_IM09] decimal(13,2) NULL,
    [S_IM10] decimal(13,2) NULL,
    [S_IM11] decimal(13,2) NULL,
    [S_IM12] decimal(13,2) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.PRESTADET', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.PRESTADET; no se sobrescribe.', 1;
-- PRESTADET: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[PRESTADET] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRESTADET] PRIMARY KEY,
    [ID_PRES] nvarchar(5) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [S_DEUD] decimal(11,2) NULL,
    [S_AMOR] decimal(11,2) NULL,
    [S_IMP1] decimal(11,2) NULL,
    [S_IMP2] decimal(11,2) NULL,
    [S_IMP3] decimal(11,2) NULL,
    [S_IMP4] decimal(11,2) NULL,
    [S_IMP5] decimal(11,2) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.PRESTAMO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.PRESTAMO; no se sobrescribe.', 1;
-- PRESTAMO: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[PRESTAMO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRESTAMO] PRIMARY KEY,
    [ID_PRES] nvarchar(5) COLLATE Latin1_General_100_BIN2 NULL,
    [F_PRES] date NULL,
    [N_PRES] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,4) NULL,
    [S_TOTA] decimal(11,2) NULL,
    [N_CUOT] decimal(4,0) NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEBE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HABE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_IMP1] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEB1] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HAB1] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_IMP2] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEB2] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HAB2] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_IMP3] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEB3] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HAB3] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_IMP4] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEB4] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HAB4] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_IMP5] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DEB5] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_HAB5] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPERK] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPERK] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPERO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPERO] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUM] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGM] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.PRODSTOCK', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.PRODSTOCK; no se sobrescribe.', 1;
-- PRODSTOCK: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[PRODSTOCK] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRODSTOCK] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ALMA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [N_STOK] decimal(15,4) NULL
);
IF OBJECT_ID(N'c34.PRODUCTO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.PRODUCTO; no se sobrescribe.', 1;
-- PRODUCTO: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[PRODUCTO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRODUCTO] PRIMARY KEY,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PROD] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ABRP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DES1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DES2] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DES3] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DES4] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DES5] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [K_PROD] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_EXIS] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_MOST] decimal(1,0) NULL,
    [Q_MOSV] decimal(1,0) NULL,
    [L_COLO] decimal(10,0) NULL,
    [N_NIVE] decimal(1,0) NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_IGV] decimal(1,0) NULL,
    [S_TIPC] decimal(11,3) NULL,
    [S_VENT] decimal(15,4) NULL,
    [N_STOK] decimal(15,4) NULL,
    [C_TALL] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [N_LOTE] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_INVE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAV] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CTAM] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_POR1] decimal(8,4) NULL,
    [S_POR2] decimal(8,4) NULL,
    [S_POR3] decimal(8,4) NULL,
    [S_POR4] decimal(8,4) NULL,
    [S_POR5] decimal(8,4) NULL,
    [Q_IGNC] decimal(1,0) NULL,
    [Q_SIND] decimal(1,0) NULL,
    [F_ACTP] date NULL,
    [Q_AUTP] decimal(1,0) NULL,
    [STOCKMIN] decimal(11,2) NULL,
    [C_CODS] nvarchar(16) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_IVAP] decimal(1,0) NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL,
    [Q_IVP] decimal(1,0) NULL
);
IF OBJECT_ID(N'c34.REGACCES', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.REGACCES; no se sobrescribe.', 1;
-- REGACCES: 26 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[REGACCES] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_REGACCES] PRIMARY KEY,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MODU] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.REGCHEQS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.REGCHEQS; no se sobrescribe.', 1;
-- REGCHEQS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[REGCHEQS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_REGCHEQS] PRIMARY KEY,
    [N_CTA] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MOVI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CHEQ] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_NOMB] nvarchar(60) COLLATE Latin1_General_100_BIN2 NULL,
    [F_EMIS] date NULL,
    [S_GIRO] decimal(15,2) NULL,
    [S_TIPC] decimal(11,4) NULL,
    [F_OPER] date NULL,
    [K_SITU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ITEM] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.REGCRON', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.REGCRON; no se sobrescribe.', 1;
-- REGCRON: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[REGCRON] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_REGCRON] PRIMARY KEY,
    [ID_REGC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [F_REGC] date NULL,
    [C_TURN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ISLA] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_SURT] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PUNI] decimal(11,4) NULL,
    [N_REGI] decimal(15,3) NULL,
    [N_REGF] decimal(15,3) NULL,
    [N_REGD] decimal(15,3) NULL,
    [S_EFECRECI] decimal(11,2) NULL,
    [S_DIFE] decimal(11,2) NULL
);
IF OBJECT_ID(N'c34.REGDATOS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.REGDATOS; no se sobrescribe.', 1;
-- REGDATOS: 117 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[REGDATOS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_REGDATOS] PRIMARY KEY,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [DATO] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [DATPC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [TIPREG] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.RENDCAJA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.RENDCAJA; no se sobrescribe.', 1;
-- RENDCAJA: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[RENDCAJA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_RENDCAJA] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [F_OPER] date NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP] date NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(15,2) NULL,
    [S_BIMP] decimal(11,2) NULL,
    [S_IGV] decimal(11,2) NULL,
    [S_EXON] decimal(15,2) NULL,
    [L_OBSE] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER1] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MET1] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [K_ING1] decimal(1,0) NULL,
    [C_PPT1] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COS1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.SALDCTA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SALDCTA; no se sobrescribe.', 1;
-- SALDCTA: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SALDCTA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SALDCTA] PRIMARY KEY,
    [N_CTA] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [F_SALD] date NULL,
    [S_DEBE] decimal(15,2) NULL,
    [S_HABE] decimal(15,2) NULL,
    [S_TIPC] decimal(11,4) NULL
);
IF OBJECT_ID(N'c34.SALIDAS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SALIDAS; no se sobrescribe.', 1;
-- SALIDAS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SALIDAS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SALIDAS] PRIMARY KEY,
    [D_ANUL] bit NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP] date NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [K_PAGO] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_EXONS] decimal(20,7) NULL,
    [S_BIMP] decimal(20,7) NULL,
    [S_IGV] decimal(20,7) NULL,
    [S_IVAP] decimal(20,7) NULL,
    [S_TOTA] decimal(20,7) NULL,
    [S_DSCT] decimal(20,7) NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RESP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CRED] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERG] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_GUIA] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TRAN] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MOTG] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CALLP] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_UBIP] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DEPAP] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PROVP] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DISTP] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DEPAG] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PROVG] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DISTG] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CALLG] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_UBIG] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ALMA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ALM1] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [C_VEND] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL,
    [L_DETA] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ANOT] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ISLA] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TURN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_SURT] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MANG] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [K_PAGE] decimal(1,0) NULL,
    [F_VENCI] date NULL,
    [Q_CANJ] bit NULL,
    [C_COMP1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP1] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [COMPREF] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [SERIREF] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [NUMREF] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [AD_SOLI] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [AD_DNI] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [AD_PLAC] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_ENTR] decimal(1,0) NULL,
    [P_IGV] decimal(6,2) NULL,
    [P_IVAP] decimal(6,2) NULL,
    [K_TIPP] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SUBT] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CHEQ] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [DCTOANEX] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TIPO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_TRNSF] decimal(1,0) NULL
);
IF OBJECT_ID(N'c34.SALITEM', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SALITEM; no se sobrescribe.', 1;
-- SALITEM: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SALITEM] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SALITEM] PRIMARY KEY,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DETA] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDI] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TALL] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [S_CANTEMP] decimal(15,4) NULL,
    [N_CONV] decimal(11,5) NULL,
    [S_VENTEMP] decimal(20,7) NULL,
    [S_CANT] decimal(15,4) NULL,
    [S_COMP] decimal(15,4) NULL,
    [S_VENT] decimal(20,7) NULL,
    [S_PBON] decimal(11,2) NULL,
    [IGVS] decimal(20,7) NULL,
    [IVAP] decimal(20,7) NULL,
    [BIMPS] decimal(20,7) NULL,
    [EXONS] decimal(20,7) NULL,
    [C_INDI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_PORD] decimal(6,0) NULL,
    [S_DESC] decimal(13,2) NULL,
    [C_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [CODALT] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [S_COMI] decimal(15,2) NULL,
    [S_PESO] decimal(15,4) NULL,
    [S_CANE] decimal(15,4) NULL,
    [MED_E] decimal(3,0) NULL,
    [MED_A] decimal(3,0) NULL,
    [MED_L] decimal(3,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.SC_PLAN', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SC_PLAN; no se sobrescribe.', 1;
-- SC_PLAN: 5189 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SC_PLAN] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SC_PLAN] PRIMARY KEY,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CUEN] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TCUE] decimal(1,0) NULL,
    [C_ANAC] decimal(1,0) NULL,
    [N_NIVE] decimal(1,0) NULL,
    [Q_COST] decimal(1,0) NULL,
    [K_PPTO] bit NULL,
    [C_ITEM] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ITEM1] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [K_PLAN] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_ACTU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_ANAL] decimal(1,0) NULL,
    [N_CUEN] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [C_BANC] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_EEFF] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DETA] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.SISPROP', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SISPROP; no se sobrescribe.', 1;
-- SISPROP: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SISPROP] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SISPROP] PRIMARY KEY,
    [S_IGV] decimal(6,2) NULL,
    [L_MONE] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MONE] nvarchar(5) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAHPLANI] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [RMV] decimal(14,2) NULL,
    [ASIGFAM] decimal(6,2) NULL,
    [CTAIGV] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAPROP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAEFEC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTACRED_V] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTACRED_C] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTACHEQUE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAGANPER] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [ITEMRESEJE] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [UIT] decimal(12,2) NULL,
    [VENTASDAOT] decimal(15,2) NULL,
    [NROUITDAOT] decimal(6,2) NULL,
    [RENTA4] decimal(6,2) NULL,
    [RENTA4AFEC] decimal(15,2) NULL,
    [CTARENTA4] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTARENTA] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [OPERPLANI] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [OPERDEPBIE] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [OPERCIERRE] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [COMPAMORT] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [IMPLOGO] decimal(1,0) NULL,
    [INCUNIDAD] decimal(1,0) NULL,
    [SISAÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [SISMES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [SISFECHA] date NULL,
    [F_OPER] date NULL,
    [F_COMP] date NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_RUC] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CUEN] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [S_TIPC] decimal(11,3) NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_ALMA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [ERROR] decimal(1,0) NULL,
    [BACKUP] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [SF_COMP] date NULL,
    [SC_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [SN_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [SL_RUC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [SK_MONE] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [SS_TIPC] decimal(11,3) NULL,
    [SN_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [SN_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [SC_COST] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [SL_COST] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [IMPFACBOL] decimal(1,0) NULL,
    [DESPROD1] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [DESPROD2] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [DESPROD3] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [DESPROD4] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [DESPROD5] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [GENDESPROD] decimal(1,0) NULL,
    [S_POR1] decimal(5,2) NULL,
    [S_POR2] decimal(5,2) NULL,
    [S_POR3] decimal(5,2) NULL,
    [S_POR4] decimal(5,2) NULL,
    [S_POR5] decimal(5,2) NULL,
    [ITFC_DEBE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [ITFC_HABE] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [ITFS_TASA] decimal(15,6) NULL,
    [ORDENREG] decimal(1,0) NULL,
    [GRABPRECIO] decimal(1,0) NULL,
    [C_VEND] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DEUD] decimal(10,0) NULL,
    [COMPINGRES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [COMPEGRES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [DIASVENC] decimal(2,0) NULL,
    [ACTIVUSUA] decimal(1,0) NULL,
    [OPERCAJA] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [PERCEP] decimal(5,2) NULL,
    [CTAPERCEP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [RETEN] decimal(5,2) NULL,
    [CTARETEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [DETRAC] decimal(5,2) NULL,
    [CTADETRAC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTADETRAV] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_PERCEP] int NULL,
    [Q_RETEN] int NULL,
    [Q_DETRAC] int NULL,
    [Q_CAJA] decimal(1,0) NULL,
    [Q_GRIFO] decimal(1,0) NULL,
    [Q_STOK] decimal(1,0) NULL,
    [C_ANULCOMP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CAMBPREVEN] decimal(1,0) NULL,
    [BLOQPREVEN] decimal(1,0) NULL,
    [R_FECHORA] decimal(1,0) NULL,
    [R_CIUDAD] decimal(1,0) NULL,
    [R_USUARIO] decimal(1,0) NULL,
    [R_SLOGAN] decimal(1,0) NULL,
    [REGEFEC] decimal(1,0) NULL,
    [BLOQSTOKV] decimal(1,0) NULL,
    [VERIMPRES] decimal(1,0) NULL,
    [PREGIMPR] decimal(1,0) NULL,
    [VERCREDITO] decimal(1,0) NULL,
    [RUCTRANSF] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [NDECIMPU] decimal(1,0) NULL,
    [IMPCOMPRA] decimal(1,0) NULL,
    [NUMAUTCOMP] decimal(1,0) NULL,
    [DOCREF] decimal(1,0) NULL,
    [METKARD] decimal(1,0) NULL,
    [Q_FECVEN] decimal(1,0) NULL,
    [Q_GENPRE] decimal(1,0) NULL,
    [Q_MULTCANC] decimal(1,0) NULL,
    [COMPADELP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [PREVENDEFA] decimal(1,0) NULL,
    [S_IGV1] decimal(6,2) NULL,
    [F_IGV1] date NULL,
    [S_FLET] decimal(11,2) NULL,
    [OPERPECOSA] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_OBSDETPR] decimal(1,0) NULL,
    [ITEMFE_ING] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [ITEMFE_EGR] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [OPERMERMA] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [ELIGIMP_V] decimal(1,0) NULL,
    [Q_CONVCANT] decimal(1,0) NULL,
    [CTADSCTVTA] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTADSCTCPR] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_DSCPOR_V] decimal(1,0) NULL,
    [Q_DSCPOR_C] decimal(1,0) NULL,
    [K_PLAN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_REGVENTP] decimal(1,0) NULL,
    [Q_REGCOMP] decimal(1,0) NULL,
    [TASAPROP] decimal(6,2) NULL,
    [QV_DSCTO] decimal(1,0) NULL,
    [QV_COSTO] decimal(1,0) NULL,
    [QV_PREBONI] decimal(1,0) NULL,
    [Q_TCVENTAS] decimal(1,0) NULL,
    [Q_TCCOMPRA] decimal(1,0) NULL,
    [Q_NUMCORR] decimal(1,0) NULL,
    [Q_PUNITEXO] decimal(1,0) NULL,
    [Q_REGNCSIN] decimal(1,0) NULL,
    [S_IVAP] decimal(6,2) NULL,
    [CTAIVAP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_TABLA30] decimal(1,0) NULL,
    [Q_REGESP] decimal(1,0) NULL,
    [ICBPER_V] decimal(5,2) NULL,
    [ICBPERCTAV] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [ICBPERCTAC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [COMPRCND] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAIGV_C] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAVENT] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTACOMP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTARXH] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [CTAIGV_CNO] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(2) NULL
);
IF OBJECT_ID(N'c34.SITUACION', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SITUACION; no se sobrescribe.', 1;
-- SITUACION: 4 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SITUACION] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SITUACION] PRIMARY KEY,
    [C_SITU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_SITU] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.SITUMVTOCTA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SITUMVTOCTA; no se sobrescribe.', 1;
-- SITUMVTOCTA: 3 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SITUMVTOCTA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SITUMVTOCTA] PRIMARY KEY,
    [K_SITU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_SITU] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.SURTIDOR', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.SURTIDOR; no se sobrescribe.', 1;
-- SURTIDOR: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[SURTIDOR] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_SURTIDOR] PRIMARY KEY,
    [C_ISLA] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_SURT] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_SURT] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [C_PROD] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TANQ] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TABLA08', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TABLA08; no se sobrescribe.', 1;
-- TABLA08: 31 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TABLA08] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TABLA08] PRIMARY KEY,
    [C_TL08] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TL08] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.TABLA19S', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TABLA19S; no se sobrescribe.', 1;
-- TABLA19S: 44 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TABLA19S] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TABLA19S] PRIMARY KEY,
    [L_TL19S] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TL19S] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(1) NULL
);
IF OBJECT_ID(N'c34.TABLA30', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TABLA30; no se sobrescribe.', 1;
-- TABLA30: 5 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TABLA30] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TABLA30] PRIMARY KEY,
    [C_TL30] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TL30] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TALLAS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TALLAS; no se sobrescribe.', 1;
-- TALLAS: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TALLAS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TALLAS] PRIMARY KEY,
    [C_TALL] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TALL] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ABRE] nvarchar(5) COLLATE Latin1_General_100_BIN2 NULL,
    [N_FACT] decimal(11,5) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TARIFAGUA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TARIFAGUA; no se sobrescribe.', 1;
-- TARIFAGUA: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TARIFAGUA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TARIFAGUA] PRIMARY KEY,
    [C_TARI] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [MINIMO] decimal(15,3) NULL,
    [S_ADIC] decimal(11,2) NULL
);
IF OBJECT_ID(N'c34.TIPCAMBIO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPCAMBIO; no se sobrescribe.', 1;
-- TIPCAMBIO: 361 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPCAMBIO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPCAMBIO] PRIMARY KEY,
    [F_ACTU] date NULL,
    [S_COMP] decimal(9,3) NULL,
    [S_VENT] decimal(9,3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TIPCLICAJ', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPCLICAJ; no se sobrescribe.', 1;
-- TIPCLICAJ: 5 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPCLICAJ] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPCLICAJ] PRIMARY KEY,
    [K_CLIC] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_CLIC] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TIPCOMPROB', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPCOMPROB; no se sobrescribe.', 1;
-- TIPCOMPROB: 35 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPCOMPROB] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPCOMPROB] PRIMARY KEY,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_COMP] nvarchar(150) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_AFEC] bit NULL,
    [Q_AFEV] bit NULL,
    [Q_NEGA] bit NULL,
    [Q_CIGV] decimal(1,0) NULL,
    [Q_VIGV] decimal(1,0) NULL,
    [Q_IMPR] bit NULL,
    [Q_ASIE] bit NULL,
    [Q_MOVA] bit NULL,
    [Q_INVE] bit NULL,
    [Q_COTI] bit NULL,
    [Q_RAPI] bit NULL,
    [Q_PECOSA] decimal(1,0) NULL,
    [Q_MERMA] decimal(1,0) NULL,
    [L_FILE] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_FILE1] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_FILE2] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PRG] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_IMPR] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [N_LINE] decimal(3,0) NULL,
    [N_COLU] decimal(3,0) NULL,
    [Q_TICK] decimal(1,0) NULL,
    [Q_CANJ] bit NULL,
    [Q_CRED] decimal(1,0) NULL,
    [Q_PERC] decimal(1,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TIPDCTOS', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPDCTOS; no se sobrescribe.', 1;
-- TIPDCTOS: 6 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPDCTOS] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPDCTOS] PRIMARY KEY,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DOCU] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [N_LONG] decimal(2,0) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TIPEXPROD', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPEXPROD; no se sobrescribe.', 1;
-- TIPEXPROD: 6 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPEXPROD] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPEXPROD] PRIMARY KEY,
    [K_EXIS] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_EXIS] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TIPINTAN', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPINTAN; no se sobrescribe.', 1;
-- TIPINTAN: 3 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPINTAN] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPINTAN] PRIMARY KEY,
    [C_TIPI] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TIPI] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TIPMEDPAGO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPMEDPAGO; no se sobrescribe.', 1;
-- TIPMEDPAGO: 20 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPMEDPAGO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPMEDPAGO] PRIMARY KEY,
    [K_MEDP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MEDP] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TIPOPER', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPOPER; no se sobrescribe.', 1;
-- TIPOPER: 17 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPOPER] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPOPER] PRIMARY KEY,
    [C_TIPO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TIPO] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TIPOUNID', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPOUNID; no se sobrescribe.', 1;
-- TIPOUNID: 20 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPOUNID] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPOUNID] PRIMARY KEY,
    [K_MEDI] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [L_MEDI] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_ABRE] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_SUNA] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TIPPAGO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPPAGO; no se sobrescribe.', 1;
-- TIPPAGO: 3 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPPAGO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPPAGO] PRIMARY KEY,
    [K_TIPP] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SUBT] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_TIPP] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEC] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEV] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TIPPLA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPPLA; no se sobrescribe.', 1;
-- TIPPLA: 4 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPPLA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPPLA] PRIMARY KEY,
    [C_PLAN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PLAN] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.TIPSERV', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TIPSERV; no se sobrescribe.', 1;
-- TIPSERV: 27 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TIPSERV] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TIPSERV] PRIMARY KEY,
    [K_SERV] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_SERV] nvarchar(80) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.TRANSAC', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.TRANSAC; no se sobrescribe.', 1;
-- TRANSAC: 0 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[TRANSAC] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_TRANSAC] PRIMARY KEY,
    [C_COMO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [F_OPER] date NULL,
    [L_ANUL] bit NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(max) COLLATE Latin1_General_100_BIN2 NULL,
    [K_OPER] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_PAGO] decimal(1,0) NULL,
    [N_CHEQ] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_BANC] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [S_BIMP] decimal(11,2) NULL,
    [S_IGV] decimal(11,2) NULL,
    [S_TOTA] decimal(11,2) NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.UBICA', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.UBICA; no se sobrescribe.', 1;
-- UBICA: 10 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[UBICA] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_UBICA] PRIMARY KEY,
    [C_UBIC] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_UBIC] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.UBIGEO', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.UBIGEO; no se sobrescribe.', 1;
-- UBIGEO: 1840 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[UBIGEO] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_UBIGEO] PRIMARY KEY,
    [C_UBIG] nvarchar(6) COLLATE Latin1_General_100_BIN2 NULL,
    [L_UBIG] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DEPA] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL,
    [L_PROV] nvarchar(30) COLLATE Latin1_General_100_BIN2 NULL
);
IF OBJECT_ID(N'c34.VENDEDOR', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.VENDEDOR; no se sobrescribe.', 1;
-- VENDEDOR: 1 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[VENDEDOR] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_VENDEDOR] PRIMARY KEY,
    [C_VEND] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [L_VEND] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [L_DIRE] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [N_TELE] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [N_CELU] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_DOCU] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [L_OBSE] nvarchar(100) COLLATE Latin1_General_100_BIN2 NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL
);
IF OBJECT_ID(N'c34.VOUCHER', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.VOUCHER; no se sobrescribe.', 1;
-- VOUCHER: 1528 registros activos, 0 eliminados en DBF.
CREATE TABLE [c34].[VOUCHER] (
    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT [PK_VOUCHER] PRIMARY KEY,
    [C_OPER] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MES] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [C_AÑO] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_OPER] nvarchar(7) COLLATE Latin1_General_100_BIN2 NULL,
    [F_OPER] date NULL,
    [Q_RETE] decimal(1,0) NULL,
    [Q_EXPO] decimal(1,0) NULL,
    [C_CUEN] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MATR] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [S_IMPO] decimal(20,7) NULL,
    [C_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [N_ACOMP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP] date NULL,
    [C_DOCU] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_RUC] nvarchar(11) COLLATE Latin1_General_100_BIN2 NULL,
    [S_EFEC] decimal(20,7) NULL,
    [S_CRED] decimal(20,7) NULL,
    [S_CHEQ] decimal(20,7) NULL,
    [N_CHEQ] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [L_BENE] nvarchar(35) COLLATE Latin1_General_100_BIN2 NULL,
    [F_VENC] date NULL,
    [F_PAGO] date NULL,
    [S_BIMP] decimal(20,7) NULL,
    [S_EXON] decimal(20,7) NULL,
    [S_IGV] decimal(20,7) NULL,
    [S_IVAP] decimal(20,7) NULL,
    [S_OTRO] decimal(20,7) NULL,
    [S_TOTA] decimal(20,7) NULL,
    [S_DSCT] decimal(20,7) NULL,
    [N_COLU] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [L_GLOS] nvarchar(90) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMP1] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERI1] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMP1] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [F_COMP1] date NULL,
    [S_COMP1] decimal(20,7) NULL,
    [S_PERC] decimal(20,7) NULL,
    [Q_PERC] decimal(1,0) NULL,
    [F_PERC] date NULL,
    [C_COMPP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERIP] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_COMPP] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [S_RETEN] decimal(20,7) NULL,
    [Q_RETEN] decimal(1,0) NULL,
    [S_DETR] decimal(20,7) NULL,
    [Q_DETR] decimal(1,0) NULL,
    [N_DETR] nvarchar(25) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DETR] date NULL,
    [C_ISLA] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TURN] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [F_DIGI] datetime2(3) NULL,
    [C_USUA] nvarchar(15) COLLATE Latin1_General_100_BIN2 NULL,
    [F_IMPOR] datetime2(3) NULL,
    [F_EXPOR] datetime2(3) NULL,
    [Q_TIPG] decimal(1,0) NULL,
    [K_TIPP] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_SUBT] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_MEDP] nvarchar(3) COLLATE Latin1_General_100_BIN2 NULL,
    [C_CUEP] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [K_PAGO] decimal(1,0) NULL,
    [L_GRAF] nvarchar(50) COLLATE Latin1_General_100_BIN2 NULL,
    [P_IGV] decimal(6,2) NULL,
    [P_IVAP] decimal(6,2) NULL,
    [C_DUAA] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SUJE] nvarchar(20) COLLATE Latin1_General_100_BIN2 NULL,
    [F_PAGI] date NULL,
    [S_PROP] decimal(11,2) NULL,
    [C_TL30] nvarchar(1) COLLATE Latin1_General_100_BIN2 NULL,
    [K_COMP] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [ESTSUNAT] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [C_TL35] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [S_ICBPER] decimal(9,2) NULL,
    [C_TL25] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [Q_NUBE] decimal(1,0) NULL,
    [C_TL19S] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [F_RETE] date NULL,
    [N_COMPR] nvarchar(10) COLLATE Latin1_General_100_BIN2 NULL,
    [N_SERIR] nvarchar(4) COLLATE Latin1_General_100_BIN2 NULL,
    [C_COMPR] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [S_INAF] decimal(20,7) NULL,
    [S_ADVAL] decimal(11,2) NULL,
    [C_CUENAV] nvarchar(12) COLLATE Latin1_General_100_BIN2 NULL,
    [C_MESIGVNO] nvarchar(2) COLLATE Latin1_General_100_BIN2 NULL,
    [_NullFlags] varbinary(2) NULL
);
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
THROW;
END CATCH;
GO
-- SECCIÓN 2. Ejecutar aparte, después de cargar y revisar la semántica.
-- Cambiar a 1 solo para aplicar las relaciones compatibles con la copia analizada.
-- Las restricciones vuelven a comprobar los datos actuales con WITH CHECK.
DECLARE @AplicarRelaciones bit = 0;
IF @AplicarRelaciones = 1
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
ALTER TABLE [c34].[AFPS] ADD CONSTRAINT [UQ_C34_1] UNIQUE ([C_AFP]);
ALTER TABLE [c34].[ALMACEN] ADD CONSTRAINT [UQ_C34_2] UNIQUE ([C_ALMA]);
ALTER TABLE [c34].[BIENES] ADD CONSTRAINT [UQ_C34_3] UNIQUE ([C_BIEN]);
ALTER TABLE [c34].[CTACTE] ADD CONSTRAINT [UQ_C34_4] UNIQUE ([N_DEUD]);
ALTER TABLE [c34].[MONEDA] ADD CONSTRAINT [UQ_C34_5] UNIQUE ([C_MONE]);
ALTER TABLE [c34].[OPERACION] ADD CONSTRAINT [UQ_C34_6] UNIQUE ([C_OPER]);
ALTER TABLE [c34].[PRODUCTO] ADD CONSTRAINT [UQ_C34_7] UNIQUE ([C_PROD]);
ALTER TABLE [c34].[SC_PLAN] ADD CONSTRAINT [UQ_C34_8] UNIQUE ([C_CUEN]);
ALTER TABLE [c34].[SITUACION] ADD CONSTRAINT [UQ_C34_9] UNIQUE ([C_SITU]);
ALTER TABLE [c34].[TIPCOMPROB] ADD CONSTRAINT [UQ_C34_10] UNIQUE ([C_COMP]);
ALTER TABLE [c34].[TIPDCTOS] ADD CONSTRAINT [UQ_C34_11] UNIQUE ([C_DOCU]);
ALTER TABLE [c34].[TIPEXPROD] ADD CONSTRAINT [UQ_C34_12] UNIQUE ([K_EXIS]);
ALTER TABLE [c34].[TIPOUNID] ADD CONSTRAINT [UQ_C34_13] UNIQUE ([K_MEDI]);
ALTER TABLE [c34].[VENDEDOR] ADD CONSTRAINT [UQ_C34_14] UNIQUE ([C_VEND]);
ALTER TABLE [c34].[VOUCHER] ADD CONSTRAINT [UQ_C34_15] UNIQUE ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- DATPERS -> AFPS: 15 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_C34_1] FOREIGN KEY ([C_AFP]) REFERENCES [c34].[AFPS] ([C_AFP]);
-- IMPOAFPS -> AFPS: 132 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[IMPOAFPS] WITH CHECK ADD CONSTRAINT [FK_C34_2] FOREIGN KEY ([C_AFP]) REFERENCES [c34].[AFPS] ([C_AFP]);
-- SISPROP -> ALMACEN: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[SISPROP] WITH CHECK ADD CONSTRAINT [FK_C34_3] FOREIGN KEY ([C_ALMA]) REFERENCES [c34].[ALMACEN] ([C_ALMA]);
-- DEPBIEN -> BIENES: 204 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DEPBIEN] WITH CHECK ADD CONSTRAINT [FK_C34_4] FOREIGN KEY ([C_BIEN]) REFERENCES [c34].[BIENES] ([C_BIEN]);
-- DETCTACTE -> CTACTE: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DETCTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_5] FOREIGN KEY ([N_DEUD]) REFERENCES [c34].[CTACTE] ([N_DEUD]);
-- ASIDEST -> MONEDA: 586 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[ASIDEST] WITH CHECK ADD CONSTRAINT [FK_C34_6] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- CTACTE -> MONEDA: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_7] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- DETCTACTE -> MONEDA: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DETCTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_8] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- DET_VOUCH -> MONEDA: 7346 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_C34_9] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SISPROP -> MONEDA: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[SISPROP] WITH CHECK ADD CONSTRAINT [FK_C34_10] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- ASIDEST -> OPERACION: 586 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[ASIDEST] WITH CHECK ADD CONSTRAINT [FK_C34_11] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- CTACTE -> OPERACION: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_12] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- DETCTACTE -> OPERACION: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DETCTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_13] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- DET_VOUCH -> OPERACION: 7346 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_C34_14] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- VOUCHER -> OPERACION: 1528 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_C34_15] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- MEDIPROD -> PRODUCTO: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[MEDIPROD] WITH CHECK ADD CONSTRAINT [FK_C34_16] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- ASIDEST -> SC_PLAN: 586 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[ASIDEST] WITH CHECK ADD CONSTRAINT [FK_C34_17] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- CTACTE -> SC_PLAN: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_18] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- DET_VOUCH -> SC_PLAN: 7346 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_C34_19] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- PRODUCTO -> SC_PLAN: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_C34_20] FOREIGN KEY ([C_CTAC]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- PRODUCTO -> SC_PLAN: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_C34_21] FOREIGN KEY ([C_CTAV]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SISPROP -> SC_PLAN: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[SISPROP] WITH CHECK ADD CONSTRAINT [FK_C34_22] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- DATPERS -> SITUACION: 15 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_C34_23] FOREIGN KEY ([C_SITU]) REFERENCES [c34].[SITUACION] ([C_SITU]);
-- CTACTE -> TIPCOMPROB: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_24] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SISPROP -> TIPCOMPROB: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[SISPROP] WITH CHECK ADD CONSTRAINT [FK_C34_25] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- CTACTE -> TIPDCTOS: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_26] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- DATPERS -> TIPDCTOS: 15 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_C34_27] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- VENDEDOR -> TIPDCTOS: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[VENDEDOR] WITH CHECK ADD CONSTRAINT [FK_C34_28] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- PRODUCTO -> TIPEXPROD: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_C34_29] FOREIGN KEY ([K_EXIS]) REFERENCES [c34].[TIPEXPROD] ([K_EXIS]);
-- MEDIPROD -> TIPOUNID: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[MEDIPROD] WITH CHECK ADD CONSTRAINT [FK_C34_30] FOREIGN KEY ([K_MEDI]) REFERENCES [c34].[TIPOUNID] ([K_MEDI]);
-- SISPROP -> VENDEDOR: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[SISPROP] WITH CHECK ADD CONSTRAINT [FK_C34_31] FOREIGN KEY ([C_VEND]) REFERENCES [c34].[VENDEDOR] ([C_VEND]);
-- ASIDEST -> VOUCHER: 586 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[ASIDEST] WITH CHECK ADD CONSTRAINT [FK_C34_32] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- CTACTE -> VOUCHER: 1 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_C34_33] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- DET_VOUCH -> VOUCHER: 7346 filas comprobadas, 0 huérfanas.
ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_C34_34] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
THROW;
END CATCH;
END;
GO
-- SECCIÓN 3. Candidatas NO ejecutables hasta resolver las observaciones.
-- Además de la FK se necesita una clave UNIQUE válida en las columnas del padre.
-- Los vacíos de texto no equivalen a NULL. No convertirlos sin una regla de negocio.
-- REVISAR_VACIOS: evaluadas=5, vacías=16, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ITEMINGEGR] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_3] FOREIGN KEY ([C_AFP]) REFERENCES [c34].[AFPS] ([C_AFP]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=1, vacías=0, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[CTACTE] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_4] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=7011, vacías=335, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_5] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_6] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_7] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[PRESTAMO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_8] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_9] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=1429, vacías=99, huérfanas=0, duplicadas padre=39, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_10] FOREIGN KEY ([N_RUC]) REFERENCES [c34].[AGENTES] ([N_RUC]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[AGRESPRO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_11] FOREIGN KEY ([N_RUC], [N_ITEM], [N_CRED]) REFERENCES [c34].[AGRECRED] ([N_RUC], [N_ITEM], [N_CRED]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_12] FOREIGN KEY ([C_ALMA]) REFERENCES [c34].[ALMACEN] ([C_ALMA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODSTOCK] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_13] FOREIGN KEY ([C_ALMA]) REFERENCES [c34].[ALMACEN] ([C_ALMA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_14] FOREIGN KEY ([C_ALMA]) REFERENCES [c34].[ALMACEN] ([C_ALMA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ALMCOMB] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_16] FOREIGN KEY ([C_TANQ]) REFERENCES [c34].[ALMCOMBCA] ([C_TANQ]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SURTIDOR] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_17] FOREIGN KEY ([C_TANQ]) REFERENCES [c34].[ALMCOMBCA] ([C_TANQ]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DEUDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_18] FOREIGN KEY ([C_DOCU], [N_DOCU]) REFERENCES [c34].[ASOCIADO] ([C_DOCU], [N_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[MEDICION] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_19] FOREIGN KEY ([C_DOCU], [N_DOCU]) REFERENCES [c34].[ASOCIADO] ([C_DOCU], [N_DOCU]);
-- REVISAR_VACIOS: evaluadas=1, vacías=5188, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SC_PLAN] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_20] FOREIGN KEY ([C_BANC]) REFERENCES [c34].[BANCOS] ([C_BANC]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[TRANSAC] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_21] FOREIGN KEY ([C_BANC]) REFERENCES [c34].[BANCOS] ([C_BANC]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=15, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_23] FOREIGN KEY ([C_CARG]) REFERENCES [c34].[CARGOS] ([C_CARG]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_24] FOREIGN KEY ([C_COST]) REFERENCES [c34].[CENTCOST] ([C_COST]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=7346, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_25] FOREIGN KEY ([C_COST]) REFERENCES [c34].[CENTCOST] ([C_COST]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_26] FOREIGN KEY ([C_COST]) REFERENCES [c34].[CENTCOST] ([C_COST]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_27] FOREIGN KEY ([C_COST]) REFERENCES [c34].[CENTCOST] ([C_COST]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_28] FOREIGN KEY ([C_COST]) REFERENCES [c34].[CENTCOST] ([C_COST]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_29] FOREIGN KEY ([C_COST]) REFERENCES [c34].[CENTCOST] ([C_COST]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_30] FOREIGN KEY ([C_TRAN]) REFERENCES [c34].[CONDUCTOR] ([C_TRAN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_31] FOREIGN KEY ([C_TRAN]) REFERENCES [c34].[CONDUCTOR] ([C_TRAN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_33] FOREIGN KEY ([C_DOCU], [N_DOCU]) REFERENCES [c34].[DATPERS] ([C_DOCU], [N_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_34] FOREIGN KEY ([C_DES1]) REFERENCES [c34].[DESPROD1] ([C_DES1]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_35] FOREIGN KEY ([C_DES2]) REFERENCES [c34].[DESPROD2] ([C_DES2]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_36] FOREIGN KEY ([C_DES3]) REFERENCES [c34].[DESPROD3] ([C_DES3]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_37] FOREIGN KEY ([C_DES4]) REFERENCES [c34].[DESPROD4] ([C_DES4]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_38] FOREIGN KEY ([C_DES5]) REFERENCES [c34].[DESPROD5] ([C_DES5]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LETRAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_39] FOREIGN KEY ([N_DEUD]) REFERENCES [c34].[DEUDAS] ([N_DEUD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_40] FOREIGN KEY ([ID_ENTR]) REFERENCES [c34].[ENTRADAS] ([ID_ENTR]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_41] FOREIGN KEY ([C_ISLA]) REFERENCES [c34].[ISLAS] ([C_ISLA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[REGCRON] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_42] FOREIGN KEY ([C_ISLA]) REFERENCES [c34].[ISLAS] ([C_ISLA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_43] FOREIGN KEY ([C_ISLA]) REFERENCES [c34].[ISLAS] ([C_ISLA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SURTIDOR] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_44] FOREIGN KEY ([C_ISLA]) REFERENCES [c34].[ISLAS] ([C_ISLA]);
-- HUERFANOS: evaluadas=1453, vacías=75, huérfanas=1453, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_45] FOREIGN KEY ([C_ISLA]) REFERENCES [c34].[ISLAS] ([C_ISLA]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[MATASIEDET] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_46] FOREIGN KEY ([C_MATR]) REFERENCES [c34].[MATASIE] ([C_MATR]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1528, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_47] FOREIGN KEY ([C_MATR]) REFERENCES [c34].[MATASIE] ([C_MATR]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCEPTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_48] FOREIGN KEY ([C_META]) REFERENCES [c34].[METAPPTO] ([C_META]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=7346, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_49] FOREIGN KEY ([C_META]) REFERENCES [c34].[METAPPTO] ([C_META]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_50] FOREIGN KEY ([C_META]) REFERENCES [c34].[METAPPTO] ([C_META]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRESPTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_51] FOREIGN KEY ([C_META]) REFERENCES [c34].[METAPPTO] ([C_META]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=17, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[BIENES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_53] FOREIGN KEY ([K_MONEC]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCEPTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_54] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCPAGOS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_55] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=15, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_57] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DETTRANSAC] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_59] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DEUDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_61] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_62] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LETRAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_63] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRESTAMO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_64] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_65] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[RENDCAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_66] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_67] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- REVISAR_VACIOS: evaluadas=1, vacías=5188, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SC_PLAN] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_68] FOREIGN KEY ([K_MONE]) REFERENCES [c34].[MONEDA] ([C_MONE]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=7346, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_70] FOREIGN KEY ([K_MOVI]) REFERENCES [c34].[MVTOCTA] ([K_MOVI]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[REGCHEQS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_71] FOREIGN KEY ([K_MOVI]) REFERENCES [c34].[MVTOCTA] ([K_MOVI]);
-- REVISAR_VACIOS: evaluadas=13, vacías=4, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[BIENES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_73] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCEPTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_74] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_76] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- REVISAR_VACIOS: evaluadas=72, vacías=132, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DEPBIEN] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_77] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DETTRANSAC] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_79] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_81] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_82] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_13] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_83] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_14] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_84] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_15] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_85] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_16] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_86] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_19] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_87] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_8] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_88] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_9] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_89] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_90] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[REGCHEQS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_91] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[RENDCAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_92] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_93] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_94] FOREIGN KEY ([C_OPER]) REFERENCES [c34].[OPERACION] ([C_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PPTO_DET] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_96] FOREIGN KEY ([C_PPTO]) REFERENCES [c34].[PRESPTO] ([C_PPTO]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRESTADET] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_97] FOREIGN KEY ([ID_PRES]) REFERENCES [c34].[PRESTAMO] ([ID_PRES]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[AGRESPRO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_98] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_99] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[GENPVPROD] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_100] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODSTOCK] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_102] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[REGCRON] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_103] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_104] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SURTIDOR] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_105] FOREIGN KEY ([C_PROD]) REFERENCES [c34].[PRODUCTO] ([C_PROD]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_106] FOREIGN KEY ([C_COMP], [N_SERI], [N_COMP]) REFERENCES [c34].[SALIDAS] ([C_COMP], [N_SERI], [N_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=2069, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[AGENTES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_107] FOREIGN KEY ([C_CTAC]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CALCREI] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_109] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCEPTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_110] FOREIGN KEY ([C_DEBE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCEPTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_111] FOREIGN KEY ([C_HABE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CONCPAGOS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_112] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- HUERFANOS: evaluadas=1284, vacías=0, huérfanas=21, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CTAPDT] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_114] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_115] FOREIGN KEY ([C_DEBE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_116] FOREIGN KEY ([C_HABE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_118] FOREIGN KEY ([C_CUEP]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FACTORES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_119] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_13] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_120] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_15] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_121] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_8] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_122] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_9] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_123] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- HUERFANOS: evaluadas=8, vacías=13, huérfanas=2, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ITEMINGEGR] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_124] FOREIGN KEY ([C_DEBE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- HUERFANOS: evaluadas=14, vacías=7, huérfanas=5, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ITEMINGEGR] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_125] FOREIGN KEY ([C_HABE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_126] FOREIGN KEY ([C_CUE2]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_127] FOREIGN KEY ([C_CUE3]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_128] FOREIGN KEY ([C_CUE4]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_129] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[MATASIEDET] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_130] FOREIGN KEY ([C_DEBE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[MATASIEDET] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_131] FOREIGN KEY ([C_HABE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRESTAMO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_132] FOREIGN KEY ([C_DEBE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRESTAMO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_133] FOREIGN KEY ([C_HABE]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_135] FOREIGN KEY ([C_CTAM]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[RENDCAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_137] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_138] FOREIGN KEY ([C_CUEP]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- REVISAR_VACIOS: evaluadas=1428, vacías=100, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_140] FOREIGN KEY ([C_CUEN]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- REVISAR_VACIOS: evaluadas=1429, vacías=99, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_141] FOREIGN KEY ([C_CUEP]) REFERENCES [c34].[SC_PLAN] ([C_CUEN]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=7346, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_143] FOREIGN KEY ([K_SITU]) REFERENCES [c34].[SITUMVTOCTA] ([K_SITU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[REGCHEQS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_144] FOREIGN KEY ([K_SITU]) REFERENCES [c34].[SITUMVTOCTA] ([K_SITU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=14, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[OPERACION] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_145] FOREIGN KEY ([C_TL08]) REFERENCES [c34].[TABLA08] ([C_TL08]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1528, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_146] FOREIGN KEY ([C_TL19S]) REFERENCES [c34].[TABLA19S] ([C_TL19S]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1528, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_147] FOREIGN KEY ([C_TL30]) REFERENCES [c34].[TABLA30] ([C_TL30]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_148] FOREIGN KEY ([C_TALL]) REFERENCES [c34].[TALLAS] ([C_TALL]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRODUCTO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_149] FOREIGN KEY ([C_TALL]) REFERENCES [c34].[TALLAS] ([C_TALL]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_150] FOREIGN KEY ([C_TALL]) REFERENCES [c34].[TALLAS] ([C_TALL]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_151] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_153] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_154] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_15] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_155] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_156] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[RENDCAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_157] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_158] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_159] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[TRANSAC] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_161] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- REVISAR_VACIOS: evaluadas=1429, vacías=99, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_162] FOREIGN KEY ([C_COMP]) REFERENCES [c34].[TIPCOMPROB] ([C_COMP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=2069, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[AGENTES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_163] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ASOCIADO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_164] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_167] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DEUDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_168] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_169] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_13] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_170] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_14] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_171] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_16] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_172] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[FORMATO3_8] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_173] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[MEDICION] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_174] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[PRESTAMO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_175] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_176] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[TRANSAC] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_177] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- REVISAR_VACIOS: evaluadas=677, vacías=851, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_179] FOREIGN KEY ([C_DOCU]) REFERENCES [c34].[TIPDCTOS] ([C_DOCU]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=7346, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DET_VOUCH] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_181] FOREIGN KEY ([K_MEDP]) REFERENCES [c34].[TIPMEDPAGO] ([K_MEDP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_182] FOREIGN KEY ([K_MEDP]) REFERENCES [c34].[TIPMEDPAGO] ([K_MEDP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_183] FOREIGN KEY ([K_MEDP]) REFERENCES [c34].[TIPMEDPAGO] ([K_MEDP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=3, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[TIPPAGO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_184] FOREIGN KEY ([K_MEDP]) REFERENCES [c34].[TIPMEDPAGO] ([K_MEDP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=1528, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[VOUCHER] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_185] FOREIGN KEY ([K_MEDP]) REFERENCES [c34].[TIPMEDPAGO] ([K_MEDP]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_186] FOREIGN KEY ([C_TIPO]) REFERENCES [c34].[TIPOPER] ([C_TIPO]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_187] FOREIGN KEY ([C_TIPO]) REFERENCES [c34].[TIPOPER] ([C_TIPO]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_188] FOREIGN KEY ([K_MEDI]) REFERENCES [c34].[TIPOUNID] ([K_MEDI]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALITEM] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_190] FOREIGN KEY ([K_MEDI]) REFERENCES [c34].[TIPOUNID] ([K_MEDI]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERSITEMS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_191] FOREIGN KEY ([C_PLAN]) REFERENCES [c34].[TIPPLA] ([C_PLAN]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=4, vacías padre=0.
-- ALTER TABLE [c34].[ASOCIADO] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_192] FOREIGN KEY ([K_SERV]) REFERENCES [c34].[TIPSERV] ([K_SERV]);
-- CLAVE_PADRE_NO_VALIDA: evaluadas=0, vacías=15, huérfanas=0, duplicadas padre=4, vacías padre=0.
-- ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_193] FOREIGN KEY ([K_SERV]) REFERENCES [c34].[TIPSERV] ([K_SERV]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DETTRANSAC] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_194] FOREIGN KEY ([C_COMO], [N_SERO], [N_OPER]) REFERENCES [c34].[TRANSAC] ([C_COMO], [N_SERO], [N_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=15, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[DATPERS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_195] FOREIGN KEY ([C_UBIC]) REFERENCES [c34].[UBICA] ([C_UBIC]);
-- HUERFANOS: evaluadas=137, vacías=1932, huérfanas=54, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[AGENTES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_196] FOREIGN KEY ([C_UBIG]) REFERENCES [c34].[UBIGEO] ([C_UBIG]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_197] FOREIGN KEY ([C_UBIG]) REFERENCES [c34].[UBIGEO] ([C_UBIG]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[CAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_198] FOREIGN KEY ([C_VEND]) REFERENCES [c34].[VENDEDOR] ([C_VEND]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_199] FOREIGN KEY ([C_VEND]) REFERENCES [c34].[VENDEDOR] ([C_VEND]);
-- HUERFANOS: evaluadas=13, vacías=4, huérfanas=10, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[BIENES] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_202] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[ENTRADAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_205] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[LISTCOMPA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_206] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[RENDCAJA] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_207] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
-- SIN_EVIDENCIA: evaluadas=0, vacías=0, huérfanas=0, duplicadas padre=0, vacías padre=0.
-- ALTER TABLE [c34].[SALIDAS] WITH CHECK ADD CONSTRAINT [FK_PROPUESTA_208] FOREIGN KEY ([C_AÑO], [C_MES], [C_OPER], [N_OPER]) REFERENCES [c34].[VOUCHER] ([C_AÑO], [C_MES], [C_OPER], [N_OPER]);
