USE [C34_BI];
GO
-- PASO A: ver lotes. Guardar LoteId para los siguientes pasos.
SELECT LoteId,Empresa,Ejercicio,FechaCargaUTC,BronzeListo,SilverListo
FROM bronze.Lote ORDER BY LoteId;

-- Todas las tablas deben conciliar, incluidas las vacías.
SELECT *,ActivasOrigen-FilasSilver-FilasRechazadas AS Diferencia
FROM control.CargaTabla ORDER BY LoteId,Tabla;

-- Una fila esperada en AGENTES de 2020: registro físico 2020, campo L_AGEN.
SELECT b.LoteId,b.Tabla,b.RegistroOrigen,r.Motivo
FROM control.Rechazo r JOIN bronze.Registro b ON b.BronzeId=r.BronzeId;
GO
-- PASO B: ejecutar MANUALMENTE tras revisar los resultados del paso A.
-- Reemplazar 1 por el LoteId real. La llamada está comentada deliberadamente.
-- EXEC control.PublicarGold @LoteId=1;
GO
-- PASO C: ejecutar después de publicar. No hay filas en Gold antes de publicar.
SELECT * FROM control.Publicacion;
SELECT EmpresaKey,Ejercicio,COUNT_BIG(*) AS Cabeceras
FROM gold.FactAsiento GROUP BY EmpresaKey,Ejercicio;
SELECT EmpresaKey,Ejercicio,COUNT_BIG(*) AS Lineas
FROM gold.FactMovimientoContable GROUP BY EmpresaKey,Ejercicio;
SELECT EmpresaKey,Ejercicio,CodigoOperacion,COUNT_BIG(*) AS Cabeceras
FROM gold.FactAsiento GROUP BY EmpresaKey,Ejercicio,CodigoOperacion;
-- Copia 2020 actual: 1528 cabeceras, 7346 líneas, ventas 1211, compras 217.

-- Conciliación de importes por lote y código de moneda, sin mezclar monedas.
-- Se comparan SUMs del mismo campo; no certifica su interpretación funcional.
;WITH s AS (
 SELECT d._LoteId AS LoteId,d.K_MONE,SUM(d.S_DEBE) AS Debe,SUM(d.S_HABE) AS Haber
 FROM silver.DET_VOUCH d JOIN control.Publicacion p ON p.LoteId=d._LoteId
 GROUP BY d._LoteId,d.K_MONE
),g AS (
 SELECT f.LoteId,m.CodigoMoneda,SUM(f.DebeOrigen) AS Debe,SUM(f.HaberOrigen) AS Haber
 FROM gold.FactMovimientoContable f JOIN gold.DimMoneda m ON m.MonedaKey=f.MonedaKey
 GROUP BY f.LoteId,m.CodigoMoneda
)
SELECT s.LoteId,s.K_MONE,s.Debe AS DebeSilver,g.Debe AS DebeGold,
       s.Haber AS HaberSilver,g.Haber AS HaberGold,
       s.Debe-g.Debe AS DiferenciaDebe,s.Haber-g.Haber AS DiferenciaHaber
FROM s FULL JOIN g ON g.LoteId=s.LoteId AND g.CodigoMoneda=s.K_MONE;
GO
