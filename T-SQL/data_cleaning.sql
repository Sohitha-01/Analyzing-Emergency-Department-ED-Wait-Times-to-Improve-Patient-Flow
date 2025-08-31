-- ==============================================
-- 01_data_cleaning_mssql_autodetect_v2.sql  (Microsoft SQL Server / T‑SQL)
-- Purpose: Robust cleaning with safe handling of admitted flag values like 't', 'true', '1', etc.
-- Raw table: [dbo].[Hospital ER_Data]
-- Clean table: dbo.er_clean
-- ==============================================

SET NOCOUNT ON;

-- Show actual columns (for debugging)
PRINT 'Columns in [dbo].[Hospital ER_Data]:';
SELECT c.name AS column_name, t.name AS data_type, c.max_length
FROM sys.columns c
JOIN sys.types t ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID(N'[dbo].[Hospital ER_Data]')
ORDER BY c.column_id;

-- Drop & recreate clean table
IF OBJECT_ID(N'dbo.er_clean', N'U') IS NOT NULL DROP TABLE dbo.er_clean;
GO
CREATE TABLE dbo.er_clean (
    patient_admission_datetime        datetime2 NULL,
    admission_year                    int       NULL,
    admission_month                   int       NULL,
    admission_day                     int       NULL,
    admission_hour                    int       NULL,
    admission_weekday                 nvarchar(20) NULL,
    patient_age                       int       NULL,
    patient_gender                    nvarchar(64) NULL,
    patient_race                      nvarchar(128) NULL,
    department_referral               nvarchar(128) NULL,
    admitted                          bit       NULL,
    patient_satisfaction_score        decimal(10,2) NULL,
    patient_waittime                  int       NULL,
    patients_cm                       int       NULL,
    patient_admission_datetime_text   nvarchar(256) NULL
);
GO

DECLARE @obj_id int = OBJECT_ID(N'[dbo].[Hospital ER_Data]');
IF @obj_id IS NULL
BEGIN
    RAISERROR('Table [dbo].[Hospital ER_Data] not found.', 16, 1);
    RETURN;
END

DECLARE @admissionDate sysname, @age sysname, @gender sysname, @race sysname,
        @dept sysname, @admitFlag sysname, @satisfaction sysname, @waittime sysname, @cm sysname;

;WITH cols AS (
    SELECT c.name
    FROM sys.columns c
    WHERE c.object_id = @obj_id
)
SELECT
    @admissionDate = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Admission%Date%' OR name LIKE '%Admission Date%' OR name LIKE '%Admit%Date%' OR name LIKE '%Patient%Admission%' ORDER BY LEN(name)),
    @age           = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Age%' ORDER BY LEN(name)),
    @gender        = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Gender%' OR name LIKE '%Sex%' ORDER BY LEN(name)),
    @race          = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Race%' OR name LIKE '%Ethnic%' ORDER BY LEN(name)),
    @dept          = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Department%Referral%' OR name LIKE '%Department%' OR name LIKE '%Referral%' ORDER BY LEN(name)),
    @admitFlag     = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Admission%Flag%' OR name LIKE '%Admitted%' OR name LIKE '%Admit%Flag%' ORDER BY LEN(name)),
    @satisfaction  = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Satisfaction%' ORDER BY LEN(name)),
    @waittime      = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Waittime%' OR name LIKE '%Wait Time%' OR name LIKE '%Wait_Time%' OR name LIKE '%Wait%' ORDER BY LEN(name)),
    @cm            = (SELECT TOP 1 name FROM cols WHERE name LIKE '%Patients%CM%' OR name LIKE '%CM%' ORDER BY LEN(name));

DECLARE @sel nvarchar(max) = N'';

-- Build robust expression for admitted flag:
DECLARE @admitExpr nvarchar(max) = CASE
    WHEN @admitFlag IS NULL THEN N'0'
    ELSE N'
        CASE
            WHEN TRY_CONVERT(int, ' + QUOTENAME(@admitFlag) + N') = 1 THEN 1
            WHEN LOWER(LTRIM(RTRIM(CONVERT(nvarchar(50),' + QUOTENAME(@admitFlag) + N')))) IN (''1'',''y'',''yes'',''t'',''true'') THEN 1
            ELSE 0
        END'
END;

SET @sel = N'
;WITH src AS (
    SELECT
        ' + COALESCE(N'TRY_CONVERT(datetime2, NULLIF(' + QUOTENAME(@admissionDate) + N','''' ))', N'CAST(NULL AS datetime2)') + N' AS dt,
        ' + COALESCE(N'TRY_CONVERT(int, ' + QUOTENAME(@age) + N')', N'CAST(NULL AS int)') + N' AS age_int,
        ' + COALESCE(N'UPPER(LTRIM(RTRIM(' + QUOTENAME(@gender) + N')))', N'NULL') + N' AS gender_norm,
        ' + COALESCE(N'LTrim(RTrim(' + QUOTENAME(@race) + N'))', N'NULL') + N' AS race_norm,
        ' + COALESCE(N'NULLIF(LTRIM(RTRIM(' + QUOTENAME(@dept) + N')),'''' )', N'NULL') + N' AS dept_norm,
        ' + @admitExpr + N' AS admitted_int,
        ' + COALESCE(N'TRY_CONVERT(decimal(10,2), ' + QUOTENAME(@satisfaction) + N')', N'CAST(NULL AS decimal(10,2))') + N' AS sat_dec,
        ' + COALESCE(N'TRY_CONVERT(int, ' + QUOTENAME(@waittime) + N')', N'CAST(NULL AS int)') + N' AS wait_int,
        ' + COALESCE(N'ISNULL(TRY_CONVERT(int, ' + QUOTENAME(@cm) + N'),0)', N'0') + N' AS cm_int,
        ' + COALESCE(QUOTENAME(@admissionDate), N'NULL') + N' AS dt_text
    FROM [dbo].[Hospital ER_Data]
    WHERE ' + COALESCE(QUOTENAME(@admissionDate) + N' IS NOT NULL', N'1=1') + N'
)
INSERT INTO dbo.er_clean (
    patient_admission_datetime,
    admission_year, admission_month, admission_day, admission_hour, admission_weekday,
    patient_age, patient_gender, patient_race, department_referral,
    admitted, patient_satisfaction_score, patient_waittime, patients_cm,
    patient_admission_datetime_text
)
SELECT
    s.dt AS patient_admission_datetime,
    CASE WHEN s.dt IS NOT NULL THEN DATEPART(year, s.dt)  END AS admission_year,
    CASE WHEN s.dt IS NOT NULL THEN DATEPART(month, s.dt) END AS admission_month,
    CASE WHEN s.dt IS NOT NULL THEN DATEPART(day, s.dt)   END AS admission_day,
    CASE WHEN s.dt IS NOT NULL THEN DATEPART(hour, s.dt)  END AS admission_hour,
    CASE WHEN s.dt IS NOT NULL THEN DATENAME(weekday, s.dt) END AS admission_weekday,
    s.age_int,
    s.gender_norm,
    s.race_norm,
    s.dept_norm,
    CAST(s.admitted_int AS bit) AS admitted,
    s.sat_dec,
    s.wait_int,
    s.cm_int,
    s.dt_text
FROM src AS s;
';

EXEC sp_executesql @sel;

-- Indexes
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_er_clean_hour' AND object_id = OBJECT_ID('dbo.er_clean'))
    CREATE INDEX IX_er_clean_hour ON dbo.er_clean (admission_hour);
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_er_clean_wd' AND object_id = OBJECT_ID('dbo.er_clean'))
    CREATE INDEX IX_er_clean_wd   ON dbo.er_clean (admission_weekday);
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_er_clean_dept' AND object_id = OBJECT_ID('dbo.er_clean'))
    CREATE INDEX IX_er_clean_dept ON dbo.er_clean (department_referral);
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_er_clean_adm' AND object_id = OBJECT_ID('dbo.er_clean'))
    CREATE INDEX IX_er_clean_adm  ON dbo.er_clean (admitted);

-- Checks
SELECT TOP (5) * FROM dbo.er_clean ORDER BY patient_admission_datetime;
SELECT COUNT(*) AS total_rows FROM dbo.er_clean;
