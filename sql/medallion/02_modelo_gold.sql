-- GOLD inicial de contabilidad, compras y ventas. Vistas: sin duplicar físicamente Silver.
-- Las medidas monetarias conservan el significado de origen; conciliación funcional pendiente.
USE [C34_BI];
GO
CREATE OR ALTER VIEW gold.DimEmpresa AS
SELECT DISTINCT Empresa AS EmpresaKey FROM control.Publicacion;
GO
CREATE OR ALTER VIEW gold.DimPeriodo AS
SELECT DISTINCT p.Ejercicio*100+m.Mes AS PeriodoKey,p.Ejercicio,m.Mes AS Periodo,
       CASE m.Mes WHEN 0 THEN N'Apertura' WHEN 13 THEN N'Cierre'
            ELSE CONCAT(N'Mes ',m.Mes) END AS Descripcion,
       CONVERT(bit,CASE WHEN m.Mes IN (0,13) THEN 1 ELSE 0 END) AS EsEspecial
FROM control.Publicacion p
CROSS JOIN (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13)) m(Mes);
GO
CREATE OR ALTER VIEW gold.DimCuenta AS
SELECT s._BronzeId AS CuentaKey,p.Empresa,s._LoteId AS LoteId,p.Ejercicio,
       s.C_CUEN AS CodigoCuenta,s.L_CUEN AS NombreCuenta,s.N_NIVE AS Nivel
FROM silver.SC_PLAN s JOIN control.Publicacion p ON p.LoteId=s._LoteId;
GO
CREATE OR ALTER VIEW gold.DimOperacion AS
SELECT s._BronzeId AS OperacionKey,p.Empresa,s._LoteId AS LoteId,p.Ejercicio,
       s.C_OPER AS CodigoOperacion,s.L_OPER AS NombreOperacion
FROM silver.OPERACION s JOIN control.Publicacion p ON p.LoteId=s._LoteId;
GO
CREATE OR ALTER VIEW gold.DimMoneda AS
SELECT s._BronzeId AS MonedaKey,p.Empresa,s._LoteId AS LoteId,p.Ejercicio,
       s.C_MONE AS CodigoMoneda,s.L_MONE AS NombreMoneda,s.L_SIMB AS Simbolo
FROM silver.MONEDA s JOIN control.Publicacion p ON p.LoteId=s._LoteId;
GO
CREATE OR ALTER VIEW gold.FactAsiento AS
-- Grano: una cabecera contable de VOUCHER de un lote publicado.
SELECT v._BronzeId AS AsientoKey,p.Empresa AS EmpresaKey,v._LoteId AS LoteId,
       CONVERT(int,CONVERT(char(8),v.F_OPER,112)) AS FechaKey,
       p.Ejercicio*100+CONVERT(int,v.C_MES) AS PeriodoKey,
       o._BronzeId AS OperacionKey,p.Ejercicio,v.C_OPER AS CodigoOperacion,
       v.C_MES AS PeriodoContable,v.N_OPER AS NumeroOperacion,
       v.C_COMP AS TipoComprobante,v.N_SERI AS SerieComprobante,v.N_COMP AS NumeroComprobante,
       v.F_COMP AS FechaComprobante,v.N_RUC AS DocumentoTercero,
       v.S_TOTA AS TotalOrigen,v.S_BIMP AS BaseImponibleOrigen,v.S_IGV AS IGVOrigen,
       CONVERT(bit,CASE WHEN v.C_MES IN (N'00',N'13') THEN 1 ELSE 0 END) AS EsPeriodoEspecial,
       CONVERT(int,1) AS CantidadAsientos
FROM silver.VOUCHER v
JOIN control.Publicacion p ON p.LoteId=v._LoteId
JOIN silver.OPERACION o ON o._LoteId=v._LoteId AND o.C_OPER=v.C_OPER;
GO
CREATE OR ALTER VIEW gold.FactMovimientoContable AS
-- Grano: una línea física de DET_VOUCH. No repite S_TOTA de la cabecera.
SELECT d._BronzeId AS MovimientoKey,v._BronzeId AS AsientoKey,
       p.Empresa AS EmpresaKey,d._LoteId AS LoteId,
       CONVERT(int,CONVERT(char(8),v.F_OPER,112)) AS FechaKey,
       p.Ejercicio*100+CONVERT(int,d.C_MES) AS PeriodoKey,
       o._BronzeId AS OperacionKey,c._BronzeId AS CuentaKey,m._BronzeId AS MonedaKey,
       p.Ejercicio,d.C_OPER AS CodigoOperacion,d.C_MES AS PeriodoContable,
       d.N_OPER AS NumeroOperacion,d.N_ITEM AS NumeroLinea,d.N_RUC AS DocumentoTercero,
       d.S_DEBE AS DebeOrigen,d.S_HABE AS HaberOrigen,d.S_TIPC AS TipoCambioRegistrado,
       CONVERT(bit,CASE WHEN d.C_MES IN (N'00',N'13') THEN 1 ELSE 0 END) AS EsPeriodoEspecial,
       CONVERT(int,1) AS CantidadLineas
FROM silver.DET_VOUCH d
JOIN control.Publicacion p ON p.LoteId=d._LoteId
JOIN silver.VOUCHER v ON v._LoteId=d._LoteId AND v.C_AÑO=d.C_AÑO
 AND v.C_MES=d.C_MES AND v.C_OPER=d.C_OPER AND v.N_OPER=d.N_OPER
JOIN silver.OPERACION o ON o._LoteId=d._LoteId AND o.C_OPER=d.C_OPER
JOIN silver.SC_PLAN c ON c._LoteId=d._LoteId AND c.C_CUEN=d.C_CUEN
JOIN silver.MONEDA m ON m._LoteId=d._LoteId AND m.C_MONE=d.K_MONE;
GO
CREATE OR ALTER VIEW gold.VentasRegistradas AS
SELECT * FROM gold.FactAsiento WHERE CodigoOperacion=N'01';
GO
CREATE OR ALTER VIEW gold.ComprasRegistradas AS
SELECT * FROM gold.FactAsiento WHERE CodigoOperacion=N'02';
GO
CREATE OR ALTER VIEW gold.ResumenOperacionesMensual AS
-- Conteos de asientos, no de facturas comerciales únicas. Sin sumas monetarias no validadas.
SELECT EmpresaKey,Ejercicio,PeriodoKey,OperacionKey,COUNT_BIG(*) AS CantidadAsientos
FROM gold.FactAsiento WHERE EsPeriodoEspecial=0
GROUP BY EmpresaKey,Ejercicio,PeriodoKey,OperacionKey;
GO
CREATE OR ALTER PROCEDURE control.PublicarGold
    @LoteId bigint,
    @ReemplazarPublicacion bit=0
AS
BEGIN
 SET NOCOUNT ON;
 SET XACT_ABORT ON;
 DECLARE @Empresa nvarchar(80),@Ejercicio smallint,@Anterior bigint,@LockResult int;
 SELECT @Empresa=Empresa,@Ejercicio=Ejercicio FROM bronze.Lote
 WHERE LoteId=@LoteId AND BronzeListo=1 AND SilverListo=1;
 IF @Empresa IS NULL THROW 51200,N'El lote no terminó Bronze/Silver.',1;
 BEGIN TRY
 BEGIN TRANSACTION;
 DECLARE @Recurso nvarchar(255)=CONCAT(N'C34:Publicacion:',@Empresa,N':',@Ejercicio);
 EXEC @LockResult=sys.sp_getapplock @Resource=@Recurso,@LockMode='Exclusive',@LockOwner='Transaction',@LockTimeout=0;
 IF @LockResult<0 THROW 51201,N'Existe otra publicación en curso.',1;
 SELECT @Anterior=LoteId FROM control.Publicacion WHERE Empresa=@Empresa AND Ejercicio=@Ejercicio;
 IF @Anterior=@LoteId BEGIN COMMIT; RETURN; END;
 IF @Anterior IS NOT NULL AND @ReemplazarPublicacion=0
   THROW 51202,N'Ya hay un lote publicado para empresa/año. Revisar antes de usar @ReemplazarPublicacion=1.',1;
 IF EXISTS(SELECT 1 FROM control.CargaTabla WHERE LoteId=@LoteId AND Tabla IN
   (N'VOUCHER',N'DET_VOUCH',N'SC_PLAN',N'OPERACION',N'MONEDA') AND FilasRechazadas>0)
   THROW 51203,N'Hay rechazos en tablas necesarias para Gold.',1;
 IF NOT EXISTS(SELECT 1 FROM silver.VOUCHER WHERE _LoteId=@LoteId)
   OR NOT EXISTS(SELECT 1 FROM silver.DET_VOUCH WHERE _LoteId=@LoteId)
   THROW 51204,N'El modelo inicial Gold requiere cabeceras y detalles contables.',1;
 IF EXISTS(SELECT 1 FROM silver.VOUCHER WHERE _LoteId=@LoteId AND
   (C_AÑO IS NULL OR TRY_CONVERT(int,C_AÑO) IS NULL OR TRY_CONVERT(int,C_AÑO)<>@Ejercicio
    OR C_MES IS NULL OR LEN(C_MES)<>2 OR C_MES LIKE N'%[^0-9]%'
    OR TRY_CONVERT(int,C_MES) NOT BETWEEN 0 AND 13
    OR F_OPER IS NULL OR YEAR(F_OPER)<>@Ejercicio OR NULLIF(C_OPER,N'') IS NULL OR NULLIF(N_OPER,N'') IS NULL))
   THROW 51205,N'Año, fecha o clave contable inválida. El lote debe representar un solo ejercicio.',1;
 IF EXISTS(SELECT 1 FROM silver.VOUCHER WHERE _LoteId=@LoteId
   GROUP BY C_AÑO,C_MES,C_OPER,N_OPER HAVING COUNT(*)>1)
   THROW 51206,N'Clave de cabecera duplicada.',1;
 IF EXISTS(SELECT 1 FROM silver.SC_PLAN WHERE _LoteId=@LoteId GROUP BY C_CUEN HAVING COUNT(*)>1)
   OR EXISTS(SELECT 1 FROM silver.OPERACION WHERE _LoteId=@LoteId GROUP BY C_OPER HAVING COUNT(*)>1)
   OR EXISTS(SELECT 1 FROM silver.MONEDA WHERE _LoteId=@LoteId GROUP BY C_MONE HAVING COUNT(*)>1)
   THROW 51207,N'Códigos duplicados en las dimensiones; Gold podría multiplicar filas.',1;
 IF EXISTS(SELECT 1 FROM silver.VOUCHER v LEFT JOIN silver.OPERACION o
   ON o._LoteId=v._LoteId AND o.C_OPER=v.C_OPER
   WHERE v._LoteId=@LoteId AND o._BronzeId IS NULL)
   THROW 51208,N'Cabeceras con operación sin catálogo.',1;
 IF EXISTS(SELECT 1 FROM silver.DET_VOUCH d
   LEFT JOIN silver.VOUCHER v ON v._LoteId=d._LoteId AND v.C_AÑO=d.C_AÑO
     AND v.C_MES=d.C_MES AND v.C_OPER=d.C_OPER AND v.N_OPER=d.N_OPER
   LEFT JOIN silver.SC_PLAN c ON c._LoteId=d._LoteId AND c.C_CUEN=d.C_CUEN
   LEFT JOIN silver.MONEDA m ON m._LoteId=d._LoteId AND m.C_MONE=d.K_MONE
   WHERE d._LoteId=@LoteId AND (v._BronzeId IS NULL OR c._BronzeId IS NULL OR m._BronzeId IS NULL))
   THROW 51209,N'Detalles sin cabecera, cuenta o moneda válida.',1;
 IF EXISTS(SELECT 1 FROM silver.OPERACION WHERE _LoteId=@LoteId AND
   ((C_OPER=N'01' AND (L_OPER IS NULL OR UPPER(RTRIM(L_OPER))<>N'VENTAS')) OR
    (C_OPER=N'02' AND (L_OPER IS NULL OR UPPER(RTRIM(L_OPER))<>N'COMPRAS'))))
   THROW 51210,N'Cambiaron los códigos de compras/ventas. Revisar las vistas antes de publicar.',1;
 DECLARE @Inicio date=DATEFROMPARTS(@Ejercicio,1,1),@Fin date=DATEFROMPARTS(@Ejercicio,12,31);
 ;WITH dias AS (
  SELECT @Inicio AS Fecha UNION ALL SELECT DATEADD(day,1,Fecha) FROM dias WHERE Fecha<@Fin
 )
 INSERT gold.DimFecha(FechaKey,Fecha,Anio,Mes,Dia,Trimestre)
 SELECT CONVERT(int,CONVERT(char(8),d.Fecha,112)),d.Fecha,YEAR(d.Fecha),MONTH(d.Fecha),DAY(d.Fecha),DATEPART(quarter,d.Fecha)
 FROM dias d WHERE NOT EXISTS(SELECT 1 FROM gold.DimFecha f WITH (UPDLOCK,HOLDLOCK) WHERE f.Fecha=d.Fecha)
 OPTION(MAXRECURSION 366);
 IF @Anterior IS NULL
  INSERT control.Publicacion(Empresa,Ejercicio,LoteId) VALUES(@Empresa,@Ejercicio,@LoteId);
 ELSE
  UPDATE control.Publicacion SET LoteId=@LoteId,FechaUTC=SYSUTCDATETIME()
  WHERE Empresa=@Empresa AND Ejercicio=@Ejercicio;
 INSERT control.HistorialPublicacion(Empresa,Ejercicio,LoteAnterior,LoteNuevo)
 VALUES(@Empresa,@Ejercicio,@Anterior,@LoteId);
 COMMIT;
 END TRY
 BEGIN CATCH
  IF @@TRANCOUNT>0 ROLLBACK;
  THROW;
 END CATCH;
END;
GO
-- Este archivo define el modelo y el procedimiento; NO publica ningún lote automáticamente.
