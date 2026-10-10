**Week 4 breakout — build the date table**

**Group 2a**  ·  Clinic visits  ·  30 minutes

| Group | group2a |
| :---- | :---- |
| **Date** | 7th October, 2026 |
| **Who is here** | Regina Robertson, Bright Osei, Richard Antwi Adjei, Margaret Rose Isliker|
| **Who is sharing their screen** | Regina Robertson |
| **Who is reporting back** | Regina Robertson |

| How this one works Unlike weeks 1 and 3, not everyone can do this at once — Power BI is Windows only and some of you will be pairing. One person shares their screen and drives. Everybody else watches, argues, and writes the answers down. |
| :---- |

**Before you start**

The person driving should already have Power BI open with the four \_clean tables loaded from the group2a schema. If nobody has got that far, spend the first ten minutes on it together — that is a perfectly good use of the session.

**Are the tables loaded? Which ones, and how many rows each?**

Yes, all four `_clean` tables from the group2a schema are loaded:

| Table | Rows |
|---|---|
| visits_clean | 25,000 |
| patients_clean | 901 (900 patients plus the Unknown record) |
| doctors_clean | 40 |
| departments_clean | 8 |


**Part A — Agree your grain**

| 1 | One sentence, out loud | 4 min |
| :---: | :---- | ----: |

Everything in the model follows from this. If the group cannot agree on it in four minutes, that is the most useful thing you will discover today.

**One row of visits\_clean is one:**  Patient visit — one visit by one patient to one department, with a date, a doctor, a visit type, a wait time and a fee. 


Then split the other three tables. Which are dimensions, and what does one row of each represent?

**Dimensions, and what one row of each is:**

- **departments_clean:** one department of the clinic (8 rows).
- **patients_clean:** one patient (900 real patients, plus one Unknown record that the 62 orphan visits point to).
- **doctors_clean:** one doctor (40 rows).
- **Date table (built in Power BI):** one calendar day.
  
**Part B — Build the date table together**

| 2 | Find your real date range first | 4 min |
| :---: | :---- | ----: |

Your calendar has to cover every date in your fact table. If it is shorter, rows silently fall outside it and vanish from every time-based chart. Check before you build.

-- run this in DBeaver, not Power BI 

SELECT min(visit\_date) AS earliest, 

max(visit\_date) AS latest FROM group2a.visits\_clean;

**Earliest and latest:**  1 January 2024 and 30 December 2025

| **3** | **Create it** | 8 min |

Modeling \> New table, then paste this. Adjust the two dates so the calendar starts on or before your earliest and ends on or after your latest.

dim_date =

ADDCOLUMNS(

    CALENDAR(DATE(2024,1,1), DATE(2025,12,31)),
    
    "Year",        YEAR([Date]),
    
    "Month",       FORMAT([Date], "MMMM"),
    
    "MonthNumber", MONTH([Date]),
    
    "Quarter",     "Q" & QUARTER([Date]),
    
    "DayOfWeek",   FORMAT([Date], "dddd")
    
)
  

**How many rows did it create? Does that match the number of days in your range?**  731 rows.  Yes, that matches: 2024 is a leap year with 366 days and 2025 has 365 days, so 366 + 365 = 731. The calendar runs from 1 January 2024 to 31 December 2025, which starts on or before our earliest visit and ends on or after our latest (30 December 2025), so no visit falls outside it. 

| **4** | **Mark it — the step everyone skips** | 3 min |

Right-click dim\_date in the Fields pane \> Mark as date table \> choose the Date column.

Skipping this produces no error. Your time intelligence just quietly returns wrong numbers, and you find out in week 6\.

**Done? Who did it?**

Yes. `DateTable` was marked as a date table using the `Date` column. Done by Regina Robertson.
| :---- |

While you are there: File \> Options and settings \> Options \> Data Load and untick Auto date/time for new files.

**Auto date/time switched off?**

Yes. We unticked Auto date/time under File > Options and settings > Options > Data Load (Current File).

**Part C — Your first relationship**

| 5 | Join the date table to your fact table | 6 min |
| :---: | :---- | ----: |

Switch to Model view — the third icon down the left edge. Drag dim\_date\[Date\] onto visits\_clean\[visit\_date\].

Then double-click the line you just created and check three things.

**Cardinality — does it say one to many, with the 1 on dim_date?**

Yes. One to many, with the "one" side on `DateTable[Date]` and the "many" side on `visits_clean[visit_date]`. When viewed from `visits_clean`, Power BI labels the same relationship "many to one".

**Cross-filter direction — is it Single?**

Yes, Single, filtering from `DateTable` to `visits_clean`.

**Is the line solid, or dashed?**

Solid, so the relationship is active.

If it refused to create the relationship at all, your fact date column is probably still text — it did not parse in week 3\. Write that down as something to fix.

**Did it work? If not, what did it say?**

Yes, it worked. The relationship was created and saved with no warnings. This also confirms that `visit_date` in `visits_clean` is a real date type and not text, so the week 3 date parsing held up.


**Part D — Talk about the rest**

No clicking for these. Ten minutes. You are planning the three relationships you will build after this session.


**Which column joins each dimension to visits_clean?**

Dimension \> column \> fact column, one line each:

departments_clean > department_id > visits_clean.department_id

patients_clean > patient_id > visits_clean.patient_id

doctors_clean > doctor_id > visits_clean.doctor_id (inactive: an active path already runs through departments_clean)

DateTable > Date > visits_clean.visit_date


**If Power BI offers many-to-many on any of them, what does that tell you?**

It means the key on the dimension side is not unique, so there is a duplicate we have not caught. A dimension key must have exactly one row per ID for the relationship to be one to many. We saw a version of this in week 3, when `patients_clean` had 904 rows because the Unknown record had been added four times and that would have broken the one-to-many relationship. The fix is to remove the duplicates from the dimension, not to accept many-to-many.

**Which columns will you rename, and to what? Your stakeholder should never see wait_minutes.**

| Original | New name |
|---|---|
| `wait_minutes` | Wait Time (Minutes) |
| `visit_type` | Visit Type |
| `department_name` | Department Name |
| `consultation_fee` | Consultation Fee |
| `visit_date` | Visit Date |
| `patient_name` | Patient Name |
| `doctor_name` | Doctor Name |

We will also hide the raw ID columns (`visit_id`, `patient_id`, `doctor_id`, `department_id`), since they only exist to make the relationships work.

**Report back to the class**

Ninety seconds. Someone who has not spoken yet.

**1. Our grain, in one sentence:** One row of `visits_clean` is one patient visit.

**2. Did the date relationship work first time?**
Yes. `DateTable[Date]` to `visits_clean[visit_date]` is one to many, Single direction and active.

**3. One thing we are stuck on:**
Power BI created a direct relationship between `visits_clean` and `doctors_clean` automatically, but it is inactive. Activating it gives an "ambiguous paths" warning, because an active path to `doctors_clean` already exists through `departments_clean`. We are leaving it inactive, because our question does not need doctor-level analysis, but we want to check that this is the right call.

| Before you leave the breakout Save the .pbix. Commit it to dashboard/ even though it is half finished — a file on one laptop is a file nobody else can pick up. Still no visuals. Not one. |
| :---- |

