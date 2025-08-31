DROP VIEW IF EXISTS er_features;

CREATE VIEW er_features AS
SELECT
  *,
  CASE
    WHEN patient_age IS NULL THEN NULL
    WHEN patient_age < 18 THEN 'Child'
    WHEN patient_age BETWEEN 18 AND 39 THEN 'Adult'
    WHEN patient_age BETWEEN 40 AND 64 THEN 'Middle-Aged'
    ELSE 'Senior'
  END AS age_group
FROM er_clean;
