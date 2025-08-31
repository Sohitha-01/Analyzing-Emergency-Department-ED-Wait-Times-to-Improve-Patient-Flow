-- Overall KPIs
SELECT
  COUNT(*)                                   AS total_visits,
  ROUND(AVG(patient_waittime),2)             AS avg_wait_time,
  MIN(patient_waittime)                      AS min_wait,
  MAX(patient_waittime)                      AS max_wait,
  ROUND(CAST(SUM(CASE WHEN patient_satisfaction_score IS NOT NULL THEN 1 ELSE 0 END) AS REAL)
        / CAST(COUNT(*) AS REAL) * 100.0, 2) AS satisfaction_response_rate_pct
FROM er_features;

-- Admission vs Non-admission
SELECT admitted,
       COUNT(*) AS visits,
       ROUND(AVG(patient_waittime),2) AS avg_wait_time
FROM er_features
GROUP BY admitted
ORDER BY admitted;

-- Department performance (n >= 50)
WITH dept_counts AS (
  SELECT department_referral, COUNT(*) AS n
  FROM er_features
  GROUP BY department_referral
)
SELECT e.department_referral,
       COUNT(*) AS visits,
       ROUND(AVG(e.patient_waittime),2) AS avg_wait_time,
       ROUND(AVG(e.patient_satisfaction_score),2) AS avg_satisfaction
FROM er_features e
JOIN dept_counts d USING (department_referral)
WHERE d.n >= 50
GROUP BY e.department_referral
ORDER BY avg_wait_time DESC;
