-- Ejecutar manualmente en SSMS. No ejecutado por el asistente.
USE [master];
GO
SELECT SERVERPROPERTY('ProductVersion') AS VersionMotor,
       SERVERPROPERTY('Edition') AS Edicion,
       SERVERPROPERTY('ServerName') AS Servidor;
-- SQL Server 2022 corresponde a versión de motor 16.x. SSMS 22 es otro producto.
GO
IF DB_ID(N'C34_BI') IS NULL
    EXEC(N'CREATE DATABASE [C34_BI]');
GO
USE [C34_BI];
GO
-- Este paquete está orientado a SQL Server 2022 (compatibilidad 160).
-- No altera la compatibilidad de una base que ya exista.
SELECT name, compatibility_level FROM sys.databases WHERE name = DB_NAME();
GO
