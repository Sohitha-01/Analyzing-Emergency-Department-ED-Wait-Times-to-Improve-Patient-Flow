DROP VIEW IF EXISTS agg_time_department;

CREATE VIEW agg_time_department AS
SELECT
  admission_year,
  admission_month,
  admission_weekday,
  admission_hour,
  department_referral,
  COUNT(*)                         AS total_visits,
  SUM(admitted)                    AS total_admitted,
  ROUND(AVG(patient_waittime),2)   AS avg_wait_time,
  ROUND(AVG(patient_satisfaction_score),2) AS avg_satisfaction
FROM er_features
GROUP BY admission_year, admission_month, admission_weekday, admission_hour, department_referral;
