SELECT
  department_referral,
  COUNT(*) AS visits,
  ROUND(AVG(patient_waittime),2) AS avg_wait_time,
  ROUND(AVG(patient_satisfaction_score),2) AS avg_satisfaction
FROM er_features
GROUP BY department_referral
ORDER BY avg_wait_time DESC;
