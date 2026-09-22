# Week 1 breakout — answer sheet

**Group 2a · Clinic visits · 30 minutes**

| | |
|---|---|
| **Group** | group2a |
| **Date** | 14th September, 2026 |
| **Who is here** | Regina Robertson, Winston Benneh, Betty Esi Sam, Margaret Isliker |
| **Who typed the queries** | Margaret Isliker |
| **Who is reporting back** | Regina Robertson |

**Your question:** Which departments have the longest patient wait times, and how does that vary by visit type and over time?

## How to use this sheet

Type your answers straight into the blanks below. Save it, then commit it to your repository as `breakout-week1.md`.

Take turns running the queries. Whoever is least confident with SQL does question 1. Rotate after each one. Nobody should leave having only watched.

*Keep the SQL primer open beside you.*

---

## Part A — Six questions

### 1. How big is your data? (2 min)

```sql
SELECT count(*) FROM raw_clinic.visits;
```

*You should get 25,100. If you do not, stop and fix the connection first.*

**Row count:** 25,100

### 2. What period does it cover? (4 min)

```sql
SELECT min(visit_date) AS earliest,
       max(visit_date) AS latest
FROM raw_clinic.visits;
```

*Read the answer carefully before moving on. Does it make sense?*

**Earliest and latest:** 01/01/2024 and 31-Oct-2025

**Does that look right? If not, what do you think is going on?**
No, the date formats differ probably because the column is stored as text with inconsistent formatting.

### 3. How many different values does visit_type have? (6 min)

```sql
SELECT visit_type, count(*) AS rows
FROM raw_clinic.visits
GROUP BY visit_type
ORDER BY rows DESC;
```

**How many rows came back?** 13 rows

**How many real categories do you think there actually are, and why the difference?**
There are 3 actual categories. The difference occurs because inconsistent capitalization and extra spaces cause the same category to appear as multiple distinct values, along with one row where visit_type is missing or blank.

### 4. How much is missing? (4 min)

```sql
SELECT count(*)                      AS total,
       count(visit_type)             AS have_a_value,
       count(*) - count(visit_type)  AS missing
FROM raw_clinic.visits;
```

*`count(*)` counts every row. `count(column)` skips the NULLs.*

**Total / have a value / missing:** 25,100 / 23,592 / 1,508

### 5. Is every row unique? (4 min)

```sql
SELECT count(*)                          AS rows,
       count(DISTINCT visit_id)          AS unique_ids,
       count(*) - count(DISTINCT visit_id) AS extras
FROM raw_clinic.visits;
```

**How many extra rows?** 100

### 6. Stretch — join two tables (8 min)

Your fact table stores IDs, not names. To group by `department_name` you have to join to the departments table.

```sql
SELECT departments.department_name,
       count(*) AS rows
FROM raw_clinic.visits
JOIN raw_clinic.departments
  ON visits.department_id = departments.department_id
GROUP BY departments.department_name
ORDER BY rows DESC;
```

**Top three:** Maternity, Emergency and General Medicine

**Bottom one — and does that surprise anyone?** Pediatrics. No.

---

## Part B — Talk about it

No SQL for these. Ten minutes. What you write here goes straight into your `scope.md`.

**Is every wait time possible for a real patient?**

```sql
SELECT min(wait_minutes) AS lowest, max(wait_minutes) AS highest
FROM raw_clinic.visits;
```

**What we found, and what we think should be done about it:**
The minimum wait time is -209 minutes, while the maximum is 209 minutes.

The -209-minute wait time is not logically possible, since a patient cannot have a negative waiting time. This indicates a likely data entry or data quality issue that should be investigated and corrected.

The maximum wait time of 209 minutes is possible, although it represents approximately 3 hours and 29 minutes, which is unusually long and may also warrant further investigation to determine whether it is accurate.

What should be done: We have to review the records with negative and unusually high wait times. Negative values should be corrected if the original values can be verified; otherwise, they should be treated as invalid or missing data.

**If you built a dashboard on this data today, without fixing anything, name one number on it that would be wrong.**

The -209-minute wait time would be an incorrect number on the dashboard because a real patient cannot have a negative waiting time. The presence of negative wait-time values indicates a data quality issue. Therefore, the affected records should be investigated and corrected before the data is used to build the dashboard.

**Your question asks about wait_minutes. Which of your four tables do you actually need to answer it? Do you need all four?**

We need the visits and the departments tables. The visits table contains the required information, such as wait_minutes, visit_type and visit_date, while the departments table is needed to convert department_id into the department name.

**Name one thing you now know you will have to fix before week 4.**

The negative wait minutes values will need to be fixed because a patient cannot have a negative waiting time.

---

## Part C — Report back to the class

Pick one person who has not spoken yet. Ninety seconds, three things.

**1. One number we found:**
-209

**2. One thing that looks wrong with the data:**
The labels or the captions and the unidentified category look incorrect or unclear in the data and may need to be reviewed and corrected.

**3. One question we want answered before week 2:**
Why is there negative wait time?

---

**Before you leave the breakout:** Save your queries in DBeaver with Ctrl+S and commit them to your `sql/` folder. These are the first real queries of your project — do not lose them. Data-quality findings can be shared openly with group2b. Your analysis stays yours.
