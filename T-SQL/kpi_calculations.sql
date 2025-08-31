-- ==============================================
-- 05_kpi_calculations_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Core KPI queries
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_features', N'V') IS NULL
BEGIN
  RAISERROR('View dbo.er_features not found. Run 03_feature_engineering_mssql.sql first.', 16, 1);
  RETURN;
END

-- Overall KPIs
SELECT
  COUNT(*)                                            AS total_visits,
  CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time,
  MIN(patient_waittime)                               AS min_wait,
  MAX(patient_waittime)                               AS max_wait,
  CAST(100.0 * SUM(CASE WHEN patient_satisfaction_score IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0) AS decimal(5,2)) AS satisfaction_response_rate_pct
FROM dbo.er_features;

-- Admission vs Non-admission
SELECT admitted,
       COUNT(*) AS visits,
       CAST(AVG(CAST(patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time
FROM dbo.er_features
GROUP BY admitted
ORDER BY admitted;

-- Department performance (n >= 50)
WITH dept_counts AS (
  SELECT department_referral, COUNT(*) AS n
  FROM dbo.er_features
  GROUP BY department_referral
)
SELECT e.department_referral,
       COUNT(*) AS visits,
       CAST(AVG(CAST(e.patient_waittime AS decimal(18,4))) AS decimal(18,2)) AS avg_wait_time,
       CAST(AVG(CAST(e.patient_satisfaction_score AS decimal(18,4))) AS decimal(18,2)) AS avg_satisfaction
FROM dbo.er_features e
JOIN dept_counts d ON e.department_referral = d.department_referral
WHERE d.n >= 50
GROUP BY e.department_referral
ORDER BY avg_wait_time DESC;
