-- WEEK 1 Breakout

-- How big is your data?
SELECT count(*) FROM raw_clinic.visits;

-- What period does it cover?
SELECT min(visit_date) AS earliest,
       max(visit_date) AS latest
FROM raw_clinic.visits;

-- How many different values does visit_type have?
SELECT visit_type, count(*) AS rows
FROM raw_clinic.visits
GROUP BY visit_type
ORDER BY rows DESC;

--How much is missing?
SELECT count(*)                          AS total,
       count(visit_type)                AS have_a_value,
       count(*) - count(visit_type)     AS missing
FROM raw_clinic.visits;

--Is every row unique?
SELECT count(*)                      AS rows,
       count(DISTINCT visit_id)       AS unique_ids,
       count(*) - count(DISTINCT visit_id) AS extras
FROM raw_clinic.visits;

-- Stretch — join two tables
SELECT departments.department_name,
       count(*) AS rows
FROM raw_clinic.visits
JOIN raw_clinic.departments
  ON visits.department_id = departments.department_id
GROUP BY departments.department_name
ORDER BY rows DESC;

--Is every wait time possible for a real patient?
SELECT min(wait_minutes) AS lowest, max(wait_minutes) AS highest
FROM raw_clinic.visits;












