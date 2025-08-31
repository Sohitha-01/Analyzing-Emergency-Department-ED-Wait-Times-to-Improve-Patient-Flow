SELECT department_referral,
       COUNT(*) AS visits,
       ROUND(AVG(patient_waittime),2) AS avg_wait
FROM er_features
GROUP BY department_referral
HAVING AVG(patient_waittime) > 45
ORDER BY avg_wait DESC;

-- Top 5 busiest hours by visits
SELECT admission_hour,
       COUNT(*) AS visits,
       ROUND(AVG(patient_waittime),2) AS avg_wait
FROM er_features
GROUP BY admission_hour
ORDER BY visits DESC
LIMIT 5;

-- Satisfaction below threshold (avg < 5, at least 30 responses)
SELECT department_referral,
       COUNT(*) AS responses,
       ROUND(AVG(patient_satisfaction_score),2) AS avg_satisfaction
FROM er_features
WHERE patient_satisfaction_score IS NOT NULL
GROUP BY department_referral
HAVING COUNT(*) >= 30 AND AVG(patient_satisfaction_score) < 5
ORDER BY avg_satisfaction ASC;
