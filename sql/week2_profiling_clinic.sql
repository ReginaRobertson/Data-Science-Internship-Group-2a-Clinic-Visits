-- =====================================================================
--  WEEK 2 - PROFILING QUERY PACK
--  Domain: Clinic
--  Schema: raw_clinic
--
--  Your question this term:
--    Which departments have the longest patient wait times, and how does that vary by visit type and over time?
--
--  HOW TO USE THIS FILE
--  Work through it top to bottom. Run each query, look at the result,
--  and write down what you find. By the end you should be able to
--  answer: what is in this data, and what is wrong with it?
--
--  Do not skip to the interesting queries at the bottom. The whole
--  point of week 2 is finding the problems BEFORE you build on them.
--
--  Write your findings in a file called data_quality_notes.md and
--  commit it. Week 3 depends on it.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. WHAT IS HERE?
--    Always start by finding out what tables you have and how big.
-- ---------------------------------------------------------------------

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'raw_clinic'
ORDER BY table_name;

-- Row counts, one per table.
SELECT 'visits' AS table_name, count(*) AS rows FROM raw_clinic.visits
UNION ALL
SELECT 'patients' AS table_name, count(*) AS rows FROM raw_clinic.patients
UNION ALL
SELECT 'doctors' AS table_name, count(*) AS rows FROM raw_clinic.doctors
UNION ALL
SELECT 'departments' AS table_name, count(*) AS rows FROM raw_clinic.departments
ORDER BY table_name;


-- ---------------------------------------------------------------------
-- 2. LOOK AT THE DATA
--    Never analyse a table you have not actually looked at.
-- ---------------------------------------------------------------------

SELECT * FROM raw_clinic.visits LIMIT 20;
SELECT * FROM raw_clinic.patients LIMIT 10;
SELECT * FROM raw_clinic.doctors LIMIT 10;
SELECT * FROM raw_clinic.departments LIMIT 10;

-- Column names and declared types.
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'raw_clinic'
ORDER BY table_name, ordinal_position;

-- NOTE: the date columns are stored as TEXT, not DATE. That is not a
-- mistake in the setup - the source data has mixed formats and would
-- not load as dates. Converting them is your job in week 3.


-- ---------------------------------------------------------------------
-- 3. MISSING VALUES
--    Which columns have gaps, and how big are they?
-- ---------------------------------------------------------------------

SELECT
    count(*)                                        AS total_rows,
    count(*) FILTER (WHERE visit_date IS NULL)            AS missing_visit_date,
    count(*) FILTER (WHERE visit_type IS NULL)            AS missing_visit_type,
    count(*) FILTER (WHERE consultation_fee IS NULL)      AS missing_consultation_fee,
    count(*) FILTER (WHERE patient_id IS NULL)            AS missing_patient_id,
    count(*) FILTER (WHERE doctor_id IS NULL)             AS missing_doctor_id,
    count(*) FILTER (WHERE department_id IS NULL)         AS missing_department_id
FROM raw_clinic.visits;

-- Ask yourself: is a NULL here a data-entry failure, or does it mean
-- something real? The answer changes how you handle it.


-- ---------------------------------------------------------------------
-- 4. DUPLICATES
--    Exact duplicate rows are usually a loading or export error.
-- ---------------------------------------------------------------------

-- Is the primary key actually unique?
SELECT count(*) AS total_rows,
       count(DISTINCT visit_id) AS distinct_ids,
       count(*) - count(DISTINCT visit_id) AS extra_rows
FROM raw_clinic.visits;

-- Show the offending rows so you can see what they look like.
SELECT visit_id, count(*) AS times_repeated
FROM raw_clinic.visits
GROUP BY visit_id
HAVING count(*) > 1
ORDER BY times_repeated DESC, visit_id
LIMIT 20;


-- ---------------------------------------------------------------------
-- 5. INCONSISTENT CATEGORIES
--    The same value written several different ways will split your
--    totals in Power BI. This is the classic silent error.
-- ---------------------------------------------------------------------

SELECT visit_type, count(*) AS rows
FROM raw_clinic.visits
GROUP BY visit_type
ORDER BY visit_type;

-- Now compare with the cleaned-up version. How many real categories
-- are there actually?
SELECT upper(trim(visit_type)) AS cleaned, count(*) AS rows
FROM raw_clinic.visits
GROUP BY cleaned
ORDER BY rows DESC;

-- Check the other text columns the same way before you assume they
-- are fine.


-- ---------------------------------------------------------------------
-- 6. DATE FORMATS
--    The date column is text and does not use one format.
-- ---------------------------------------------------------------------

-- Group by shape to see which formats are present.
SELECT
    CASE
        WHEN visit_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN 'YYYY-MM-DD'
        WHEN visit_date ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN 'DD/MM/YYYY'
        WHEN visit_date ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' THEN 'YYYY/MM/DD'
        WHEN visit_date ~ '^[0-9]{2}-[A-Za-z]{3}-[0-9]{4}$' THEN 'DD-Mon-YYYY'
        ELSE 'OTHER - investigate'
    END AS date_format,
    count(*) AS rows
FROM raw_clinic.visits
GROUP BY date_format
ORDER BY rows DESC;

-- Careful: 03/04/2025 is ambiguous. Is it 3 April or 4 March?
-- Decide, write your decision down, and apply it consistently.


-- ---------------------------------------------------------------------
-- 7. IMPOSSIBLE VALUES
--    Values that are technically valid numbers but cannot be real.
-- ---------------------------------------------------------------------

SELECT count(*) AS negative_wait_times
FROM raw_clinic.visits
WHERE wait_minutes < 0;

SELECT *
FROM raw_clinic.visits
WHERE wait_minutes < 0
LIMIT 15;

-- Also check the range of every numeric column. Anything at the
-- extremes worth questioning?
SELECT
    min(consultation_fee) AS min_consultation_fee,
    max(consultation_fee) AS max_consultation_fee,
    round(avg(consultation_fee), 2) AS avg_consultation_fee
FROM raw_clinic.visits;


-- ---------------------------------------------------------------------
-- 8. BROKEN RELATIONSHIPS
--    Fact rows pointing at dimension records that do not exist.
--    These will silently disappear from your Power BI model.
-- ---------------------------------------------------------------------

-- patient_id without a matching row in patients
SELECT count(*) AS orphan_patient_id
FROM raw_clinic.visits f
LEFT JOIN raw_clinic.patients d ON f.patient_id = d.patient_id
WHERE d.patient_id IS NULL;

-- doctor_id without a matching row in doctors
SELECT count(*) AS orphan_doctor_id
FROM raw_clinic.visits f
LEFT JOIN raw_clinic.doctors d ON f.doctor_id = d.doctor_id
WHERE d.doctor_id IS NULL;

-- department_id without a matching row in departments
SELECT count(*) AS orphan_department_id
FROM raw_clinic.visits f
LEFT JOIN raw_clinic.departments d ON f.department_id = d.department_id
WHERE d.department_id IS NULL;

-- If you find orphans: do you drop those rows, or keep them with an
-- "Unknown" placeholder? Both are defensible. Document which you chose.


-- ---------------------------------------------------------------------
-- 9. TIME COVERAGE
--    Does the data actually cover the period you think it does?
-- ---------------------------------------------------------------------

SELECT
    min(visit_date) AS earliest_text,
    max(visit_date) AS latest_text
FROM raw_clinic.visits;

-- That result is misleading, because text sorts alphabetically, not
-- chronologically. Work out why, then check the real range once you
-- have parsed the dates in week 3. This is a good thing to note down.


-- ---------------------------------------------------------------------
-- 10. YOUR FIRST REAL ANALYSIS
--     Only meaningful once you know what is broken above.
-- ---------------------------------------------------------------------

-- Volume and value by department_name.
SELECT
    d.department_name,
    count(*)                       AS rows,
    round(sum(f.consultation_fee), 2)      AS total_consultation_fee,
    round(avg(f.consultation_fee), 2)      AS avg_consultation_fee
FROM raw_clinic.visits f
JOIN raw_clinic.departments d ON f.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_consultation_fee DESC;

-- The same thing by month. substring() is a temporary shortcut that
-- only works for the rows already in YYYY-MM-DD form - which is
-- exactly why week 3 exists.
SELECT
    substring(visit_date FROM 1 FOR 7) AS month,
    count(*)                           AS rows,
    round(sum(consultation_fee), 2)            AS total_consultation_fee
FROM raw_clinic.visits
WHERE visit_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
GROUP BY month
ORDER BY month;

-- How many rows did that WHERE clause silently throw away?
-- Check. Then think about what that would have done to a dashboard.


-- ---------------------------------------------------------------------
-- 11. THE FULL JOIN
--     Everything connected. This is roughly the shape your fact table
--     will take in week 4.
-- ---------------------------------------------------------------------

SELECT
    f.visit_id,
    f.visit_date,
    f.consultation_fee,
    patients.*,
    doctors.*,
    departments.*
FROM raw_clinic.visits f
JOIN raw_clinic.patients AS patients ON f.patient_id = patients.patient_id
JOIN raw_clinic.doctors AS doctors ON f.doctor_id = doctors.doctor_id
JOIN raw_clinic.departments AS departments ON f.department_id = departments.department_id
LIMIT 25;


-- =====================================================================
--  BEFORE YOU FINISH WEEK 2
--
--  Your data_quality_notes.md should answer:
--    1. How many rows in each table?
--    2. Which columns have missing values, and how many?
--    3. How many duplicate rows, and in which table?
--    4. How many real categories are hiding behind the messy ones?
--    5. Which date formats are present?
--    6. How many impossible values, and what will you do about them?
--    7. How many orphan keys, and what will you do about them?
--
--  Commit it. Week 3 starts from this file, not from memory.
-- =====================================================================
