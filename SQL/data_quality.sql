-- Row count
SELECT COUNT(*) AS total_rows FROM er_clean;

-- Missing/invalid counts
SELECT
  SUM(CASE WHEN patient_admission_datetime_text IS NULL OR patient_admission_datetime_text = '' THEN 1 ELSE 0 END) AS missing_admission_datetime,
  SUM(CASE WHEN patient_age IS NULL OR patient_age < 0 OR patient_age > 110 THEN 1 ELSE 0 END) AS bad_age,
  SUM(CASE WHEN patient_waittime IS NULL OR patient_waittime < 0 OR patient_waittime > 720 THEN 1 ELSE 0 END) AS bad_waittime,
  SUM(CASE WHEN patient_satisfaction_score IS NULL THEN 1 ELSE 0 END) AS missing_satisfaction
FROM er_clean;

-- Category distributions
SELECT department_referral, COUNT(*) AS count_per_dept
FROM er_clean
GROUP BY department_referral
ORDER BY count_per_dept DESC;

-- Weekday distribution
SELECT admission_weekday, COUNT(*) AS visits
FROM er_clean
GROUP BY admission_weekday
ORDER BY
  CASE admission_weekday
    WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2 WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5 WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7 ELSE 8 END;
