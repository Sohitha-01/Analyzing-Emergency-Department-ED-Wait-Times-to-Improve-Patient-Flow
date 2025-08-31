-- ==============================================
-- 06_trend_analysis_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Trend views for BI
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_features', N'V') IS NULL
BEGIN
  RAISERROR('View dbo.er_features not found. Run 03_feature_engineering_mssql.sql first.', 16, 1);
  RETURN;
END

IF OBJECT_ID(N'dbo.trend_monthly', N'V') IS NOT NULL DROP VIEW dbo.trend_monthly;
GO
CREATE VIEW dbo.trend_monthly AS
SELECT
  admission_year,
  admission_month,
  COUNT(*) AS visits,
  CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time
FROM dbo.er_features
GROUP BY admission_year, admission_month;
GO

IF OBJECT_ID(N'dbo.trend_weekday', N'V') IS NOT NULL DROP VIEW dbo.trend_weekday;
GO
CREATE VIEW dbo.trend_weekday AS
SELECT
  admission_weekday,
  COUNT(*) AS visits,
  CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time
FROM dbo.er_features
GROUP BY admission_weekday;
GO

IF OBJECT_ID(N'dbo.trend_hourly', N'V') IS NOT NULL DROP VIEW dbo.trend_hourly;
GO
CREATE VIEW dbo.trend_hourly AS
SELECT
  admission_hour,
  COUNT(*) AS visits,
  CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time
FROM dbo.er_features
GROUP BY admission_hour;
GO
