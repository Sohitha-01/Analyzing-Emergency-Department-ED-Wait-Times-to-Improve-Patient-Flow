DROP VIEW IF EXISTS trend_monthly;
CREATE VIEW trend_monthly AS
SELECT
  admission_year,
  admission_month,
  COUNT(*) AS visits,
  ROUND(AVG(patient_waittime),2) AS avg_wait_time
FROM er_features
GROUP BY admission_year, admission_month
ORDER BY admission_year, admission_month;

DROP VIEW IF EXISTS trend_weekday;
CREATE VIEW trend_weekday AS
SELECT
  admission_weekday,
  COUNT(*) AS visits,
  ROUND(AVG(patient_waittime),2) AS avg_wait_time
FROM er_features
GROUP BY admission_weekday
ORDER BY
  CASE admission_weekday
    WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2 WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5 WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7 ELSE 8 END;

DROP VIEW IF EXISTS trend_hourly;
CREATE VIEW trend_hourly AS
SELECT
  admission_hour,
  COUNT(*) AS visits,
  ROUND(AVG(patient_waittime),2) AS avg_wait_time
FROM er_features
GROUP BY admission_hour
ORDER BY admission_hour;
