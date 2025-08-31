-- ==============================================
-- 02_data_quality_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Validates dbo.er_clean
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_clean', N'U') IS NULL
BEGIN
  RAISERROR('Table dbo.er_clean not found. Run 01_data_cleaning_mssql_autodetect_v2.sql first.', 16, 1);
  RETURN;
END

-- Row count
SELECT COUNT(*) AS total_rows FROM dbo.er_clean;

-- Missing / invalid
SELECT
  SUM(CASE WHEN patient_admission_datetime IS NULL THEN 1 ELSE 0 END) AS missing_admission_datetime,
  SUM(CASE WHEN patient_age IS NULL OR patient_age < 0 OR patient_age > 110 THEN 1 ELSE 0 END) AS bad_age,
  SUM(CASE WHEN patient_waittime IS NULL OR patient_waittime < 0 OR patient_waittime > 720 THEN 1 ELSE 0 END) AS bad_waittime,
  SUM(CASE WHEN patient_satisfaction_score IS NULL THEN 1 ELSE 0 END) AS missing_satisfaction
FROM dbo.er_clean;

-- Department counts
SELECT department_referral, COUNT(*) AS count_per_dept
FROM dbo.er_clean
GROUP BY department_referral
ORDER BY count_per_dept DESC;

-- Weekday distribution (ordered Mon..Sun)
SELECT admission_weekday, COUNT(*) AS visits
FROM dbo.er_clean
GROUP BY admission_weekday
ORDER BY
  CASE admission_weekday
    WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2 WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5 WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7 ELSE 8 END;
