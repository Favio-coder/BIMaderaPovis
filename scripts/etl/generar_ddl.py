"""Genera DDL local desde el perfil existente. No conecta a SQL Server."""
from pathlib import Path
import json
from pprint import pformat

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]
SQL=ROOT/'sql'/'medallion'
P=json.loads((ROOT/'local'/'reportes'/'perfil.json').read_text(encoding='utf-8'))


def q(s):
    return '['+s.replace(']',']]')+']'


def main():
    SQL.mkdir(parents=True, exist_ok=True)
    lines=['USE [C34_BI];','GO','SET XACT_ABORT ON;','GO',
           'BEGIN TRY','BEGIN TRANSACTION;',
           "IF SCHEMA_ID(N'control') IS NULL EXEC(N'CREATE SCHEMA [control]');",
           "IF SCHEMA_ID(N'bronze') IS NULL EXEC(N'CREATE SCHEMA [bronze]');",
           "IF SCHEMA_ID(N'silver') IS NULL EXEC(N'CREATE SCHEMA [silver]');",
           "IF SCHEMA_ID(N'gold') IS NULL EXEC(N'CREATE SCHEMA [gold]');",
           "IF OBJECT_ID(N'bronze.Lote') IS NOT NULL THROW 51000,N'Las capas ya existen. No se sobrescriben.',1;",
           '''CREATE TABLE bronze.Lote (
  LoteId bigint IDENTITY PRIMARY KEY,
  Empresa nvarchar(80) COLLATE Latin1_General_100_BIN2 NOT NULL,
  Ejercicio smallint NOT NULL CHECK (Ejercicio BETWEEN 1900 AND 2100),
  OrigenHash char(64) NOT NULL,
  PaqueteHash char(64) NOT NULL,
  FechaCargaUTC datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
  OrigenZip varbinary(max) NOT NULL,
  ManifestJson nvarchar(max) NOT NULL CHECK (ISJSON(ManifestJson)=1),
  BronzeListo bit NOT NULL DEFAULT 0,
  SilverListo bit NOT NULL DEFAULT 0,
  CONSTRAINT UQ_Lote UNIQUE(Empresa,Ejercicio,OrigenHash)
);
CREATE TABLE bronze.Registro (
  BronzeId bigint IDENTITY PRIMARY KEY,
  LoteId bigint NOT NULL REFERENCES bronze.Lote(LoteId),
  Tabla nvarchar(128) COLLATE Latin1_General_100_BIN2 NOT NULL,
  RegistroOrigen int NOT NULL,
  Eliminado bit NOT NULL,
  RegistroRaw varbinary(max) NOT NULL,
  DatosJson nvarchar(max) NULL CHECK(DatosJson IS NULL OR ISJSON(DatosJson)=1),
  ErroresJson nvarchar(max) NOT NULL CHECK(ISJSON(ErroresJson)=1),
  CONSTRAINT UQ_Registro UNIQUE(LoteId,Tabla,RegistroOrigen)
);
CREATE TABLE control.CargaTabla (
  LoteId bigint NOT NULL REFERENCES bronze.Lote(LoteId),
  Tabla nvarchar(128) NOT NULL,
  ActivasOrigen int NOT NULL,
  EliminadasOrigen int NOT NULL,
  FilasSilver int NOT NULL,
  FilasRechazadas int NOT NULL,
  PRIMARY KEY(LoteId,Tabla),
  CHECK(ActivasOrigen=FilasSilver+FilasRechazadas)
);
CREATE TABLE control.Rechazo (
  BronzeId bigint NOT NULL PRIMARY KEY REFERENCES bronze.Registro(BronzeId),
  Motivo nvarchar(max) NOT NULL,
  FechaUTC datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE TABLE control.Publicacion (
  Empresa nvarchar(80) COLLATE Latin1_General_100_BIN2 NOT NULL,
  Ejercicio smallint NOT NULL,
  LoteId bigint NOT NULL UNIQUE REFERENCES bronze.Lote(LoteId),
  FechaUTC datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
  PRIMARY KEY(Empresa,Ejercicio)
);
CREATE TABLE control.HistorialPublicacion (
  HistorialId bigint IDENTITY PRIMARY KEY,
  Empresa nvarchar(80) NOT NULL,
  Ejercicio smallint NOT NULL,
  LoteAnterior bigint NULL REFERENCES bronze.Lote(LoteId),
  LoteNuevo bigint NOT NULL REFERENCES bronze.Lote(LoteId),
  FechaUTC datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE TABLE gold.DimFecha (
  FechaKey int NOT NULL PRIMARY KEY,
  Fecha date NOT NULL UNIQUE,
  Anio smallint NOT NULL,
  Mes tinyint NOT NULL,
  Dia tinyint NOT NULL,
  Trimestre tinyint NOT NULL
);''']
    schema={}
    for t in P['tablas']:
        name=t['nombre']
        schema[name]=[{k:f[k] for k in ('nombre','tipo','longitud','decimales','nullable_fox','binario','sql')} for f in t['campos']]
        columns=[f'  [_BronzeId] bigint NOT NULL CONSTRAINT {q("PK_S_"+name)} PRIMARY KEY REFERENCES bronze.Registro(BronzeId)',
                 '  [_LoteId] bigint NOT NULL REFERENCES bronze.Lote(LoteId)',
                 '  [_RegistroOrigen] int NOT NULL']
        for f in t['campos']:
            typ=f['sql']+(' COLLATE Latin1_General_100_BIN2' if f['sql'].startswith('nvarchar') else '')
            columns.append('  '+q(f['nombre'])+' '+typ+' NULL')
        columns.append(f'  CONSTRAINT {q("UQ_S_ROW_"+name)} UNIQUE([_LoteId],[_RegistroOrigen])')
        lines += [f'CREATE TABLE silver.{q(name)} (',',\n'.join(columns),');']
    lines += ['COMMIT;','END TRY','BEGIN CATCH','IF @@TRANCOUNT>0 ROLLBACK;','THROW;','END CATCH;','GO']
    (SQL/'01_crear_capas.sql').write_text('\n'.join(lines)+'\n',encoding='utf-8-sig')
    compatible=[r for r in P['relaciones'] if r['estado']=='COMPATIBLE_EN_DATOS']
    public_relations=[{k:r[k] for k in ('hija','campos_hija','padre','campos_padre')} for r in compatible]
    contract={'tablas':schema,'relaciones':public_relations}
    (BASE/'esquema.py').write_text('"""Contrato de estructura generado: sin registros, estadísticas ni credenciales."""\n\nESQUEMA = '+pformat(contract,width=120,sort_dicts=False)+'\n',encoding='utf-8')
    lines=['USE [C34_BI];','GO','SET XACT_ABORT ON;',
           '-- OPCIONAL. Ejecutar después de cargar Silver y confirmar la semántica.',
           '-- 34 candidatas compatibles con los datos de 2020; no declaradas por FoxPro.',
           '-- Incluyen LoteId para no mezclar empresas, años ni versiones del origen.',
           '-- Las futuras cargas respetan su orden de dependencias; una infracción revierte Silver.',
           'DECLARE @Aplicar bit=0;','IF @Aplicar=1','BEGIN','BEGIN TRY','BEGIN TRANSACTION;']
    for i,(table,cols) in enumerate(sorted({(r['padre'],tuple(r['campos_padre'])) for r in compatible}),1):
        name='UQ_S_BUS_'+str(i)
        lines += [f"IF NOT EXISTS(SELECT 1 FROM sys.key_constraints WHERE parent_object_id=OBJECT_ID(N'silver.{table}') AND name=N'{name}')",
                  f'ALTER TABLE silver.{q(table)} ADD CONSTRAINT {q(name)} UNIQUE ([_LoteId],'+','.join(map(q,cols))+');']
    for i,r in enumerate(compatible,1):
        name='FK_S_BUS_'+str(i)
        lines += [f"IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE parent_object_id=OBJECT_ID(N'silver.{r['hija']}') AND name=N'{name}')",
            f"ALTER TABLE silver.{q(r['hija'])} WITH CHECK ADD CONSTRAINT {q(name)} FOREIGN KEY ([_LoteId],"+','.join(map(q,r['campos_hija']))+
            f") REFERENCES silver.{q(r['padre'])} ([_LoteId],"+','.join(map(q,r['campos_padre']))+');']
    lines+=['COMMIT;','END TRY','BEGIN CATCH','IF @@TRANCOUNT>0 ROLLBACK;','THROW;','END CATCH;','END;','GO']
    (SQL/'03_relaciones_silver_opcionales.sql').write_text('\n'.join(lines)+'\n',encoding='utf-8-sig')
    print('DDL local generado: 110 tablas Silver y 34 relaciones opcionales.')


if __name__=='__main__':
    main()
