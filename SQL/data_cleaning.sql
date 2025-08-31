-- Drop if exists
DROP TABLE IF EXISTS er_clean;

-- Create cleaned table
CREATE TABLE er_clean (
    patient_admission_datetime      DATETIME NULL,
    admission_year                  INT NULL,
    admission_month                 INT NULL,
    admission_day                   INT NULL,
    admission_hour                  INT NULL,
    admission_weekday               VARCHAR(20),
    patient_age                     INT NULL,
    patient_gender                  VARCHAR(64),
    patient_race                    VARCHAR(128),
    department_referral             VARCHAR(128),
    admitted                        TINYINT(1) NULL,
    patient_satisfaction_score      DECIMAL(10,2) NULL,
    patient_waittime                INT NULL,
    patients_cm                     INT NULL,
    patient_admission_datetime_text VARCHAR(255)
);

-- Insert cleaned data
INSERT INTO er_clean (
    patient_admission_datetime,
    admission_year, admission_month, admission_day, admission_hour, admission_weekday,
    patient_age, patient_gender, patient_race, department_referral,
    admitted, patient_satisfaction_score, patient_waittime, patients_cm,
    patient_admission_datetime_text
)
SELECT
    STR_TO_DATE(NULLIF(`Patient Admission Date`, ''), '%Y-%m-%d %H:%i:%s') AS patient_admission_datetime,
    YEAR(STR_TO_DATE(NULLIF(`Patient Admission Date`, ''), '%Y-%m-%d %H:%i:%s'))  AS admission_year,
    MONTH(STR_TO_DATE(NULLIF(`Patient Admission Date`, ''), '%Y-%m-%d %H:%i:%s')) AS admission_month,
    DAY(STR_TO_DATE(NULLIF(`Patient Admission Date`, ''), '%Y-%m-%d %H:%i:%s'))   AS admission_day,
    HOUR(STR_TO_DATE(NULLIF(`Patient Admission Date`, ''), '%Y-%m-%d %H:%i:%s'))  AS admission_hour,
    DAYNAME(STR_TO_DATE(NULLIF(`Patient Admission Date`, ''), '%Y-%m-%d %H:%i:%s')) AS admission_weekday,
    CAST(NULLIF(`Patient Age`, '') AS SIGNED)         AS patient_age,
    UPPER(TRIM(`Patient Gender`))                     AS patient_gender,
    TRIM(`Patient Race`)                              AS patient_race,
    TRIM(`Department Referral`)                       AS department_referral,
    CASE
      WHEN LOWER(TRIM(`Patient Admission Flag`)) IN ('1','y','yes','t','true') THEN 1
      ELSE 0
    END                                               AS admitted,
    CAST(NULLIF(`Patient Satisfaction Score`, '') AS DECIMAL(10,2)) AS patient_satisfaction_score,
    CAST(NULLIF(`Patient Waittime`, '') AS SIGNED)    AS patient_waittime,
    COALESCE(CAST(NULLIF(`Patients CM`, '') AS SIGNED), 0) AS patients_cm,
    `Patient Admission Date`                          AS patient_admission_datetime_text
FROM `Hospital ER_Data`
WHERE `Patient Admission Date` IS NOT NULL;

-- Indexes
CREATE INDEX idx_er_clean_hour ON er_clean (admission_hour);
CREATE INDEX idx_er_clean_wd   ON er_clean (admission_weekday);
CREATE INDEX idx_er_clean_dept ON er_clean (department_referral);
CREATE INDEX idx_er_clean_adm  ON er_clean (admitted);

-- Quick sanity checks
SELECT * FROM er_clean LIMIT 5;
SELECT COUNT(*) AS total_rows FROM er_clean;
