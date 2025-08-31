-- ==============================================
-- 07_category_performance_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Department (category) performance
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_features', N'V') IS NULL
BEGIN
  RAISERROR('View dbo.er_features not found. Run 03_feature_engineering_mssql.sql first.', 16, 1);
  RETURN;
END

SELECT
  department_referral,
  COUNT(*) AS visits,
  CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time,
  CAST(AVG(CAST(patient_satisfaction_score AS decimal(18,4))) AS decimal(18,2)) AS avg_satisfaction
FROM dbo.er_features
GROUP BY department_referral
ORDER BY avg_wait_time DESC;
