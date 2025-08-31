-- ==============================================
-- 08_monitoring_queries_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Monitoring / alert-style queries
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_features', N'V') IS NULL
BEGIN
  RAISERROR('View dbo.er_features not found. Run 03_feature_engineering_mssql.sql first.', 16, 1);
  RETURN;
END

-- Departments with high average waits (> 45 minutes)
SELECT department_referral,
       COUNT(*) AS visits,
       CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait
FROM dbo.er_features
GROUP BY department_referral
HAVING AVG(CAST(patient_waittime AS decimal(18,4))) > 45
ORDER BY avg_wait DESC;

-- Top 5 busiest hours by visits
SELECT TOP (5) admission_hour,
       COUNT(*) AS visits,
       CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait
FROM dbo.er_features
GROUP BY admission_hour
ORDER BY visits DESC, admission_hour ASC;

-- Satisfaction below threshold (avg < 5, min 30 responses)
SELECT department_referral,
       COUNT(*) AS responses,
       CAST(AVG(CAST(patient_satisfaction_score AS decimal(18,4))) AS decimal(18,2)) AS avg_satisfaction
FROM dbo.er_features
WHERE patient_satisfaction_score IS NOT NULL
GROUP BY department_referral
HAVING COUNT(*) >= 30 AND AVG(CAST(patient_satisfaction_score AS decimal(18,4))) < 5
ORDER BY avg_satisfaction ASC;
