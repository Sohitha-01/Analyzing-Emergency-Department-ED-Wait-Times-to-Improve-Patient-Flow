-- ==============================================
-- 03_feature_engineering_mssql.sql  (Microsoft SQL Server / T-SQL)
-- Creates a view dbo.er_features with engineered columns
-- ==============================================

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.er_clean', N'U') IS NULL
BEGIN
  RAISERROR('Table dbo.er_clean not found. Run 01_data_cleaning_mssql_autodetect_v2.sql first.', 16, 1);
  RETURN;
END

IF OBJECT_ID(N'dbo.er_features', N'V') IS NOT NULL
  DROP VIEW dbo.er_features;
GO

CREATE VIEW dbo.er_features AS
SELECT
  *,
  CASE
    WHEN patient_age IS NULL THEN NULL
    WHEN patient_age < 18 THEN 'Child'
    WHEN patient_age BETWEEN 18 AND 39 THEN 'Adult'
    WHEN patient_age BETWEEN 40 AND 64 THEN 'Middle-Aged'
    ELSE 'Senior'
  END AS age_group
FROM dbo.er_clean;
GO
