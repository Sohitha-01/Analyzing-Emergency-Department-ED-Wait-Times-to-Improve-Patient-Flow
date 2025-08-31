-- ==============================================
-- 04_aggregate_time_category_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Aggregations by time and department
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_features', N'V') IS NULL
BEGIN
  RAISERROR('View dbo.er_features not found. Run 03_feature_engineering_mssql.sql first.', 16, 1);
  RETURN;
END

IF OBJECT_ID(N'dbo.agg_time_department', N'V') IS NOT NULL
  DROP VIEW dbo.agg_time_department;
GO

CREATE VIEW dbo.agg_time_department AS
SELECT
  admission_year,
  admission_month,
  admission_weekday,
  admission_hour,
  department_referral,
  COUNT(*)                           AS total_visits,
  SUM(CASE WHEN admitted = 1 THEN 1 ELSE 0 END) AS total_admitted,
  CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time,
  CAST(AVG(CAST(patient_satisfaction_score AS decimal(18,4))) AS decimal(18,2)) AS avg_satisfaction
FROM dbo.er_features
GROUP BY admission_year, admission_month, admission_weekday, admission_hour, department_referral;
GO
