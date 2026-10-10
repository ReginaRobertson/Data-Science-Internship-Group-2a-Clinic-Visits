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

| \-- run this in DBeaver, not Power BI SELECT min(visit\_date) AS earliest,        max(visit\_date) AS latest FROM group2a.visits\_clean; |  |  |

**Earliest and latest:**  1 January 2024 and 30 December 2025

| **3** | **Create it** | 8 min |

Modeling \> New table, then paste this. Adjust the two dates so the calendar starts on or before your earliest and ends on or after your latest.

| dim\_date \= ADDCOLUMNS(     CALENDAR(DATE(2024,1,1), DATE(2025,12,31)),     "Year",        YEAR(\[Date\]),     "Month",       FORMAT(\[Date\], "MMMM"),     "MonthNumber", MONTH(\[Date\]),     "Quarter",     "Q" & QUARTER(\[Date\]),     "DayOfWeek",   FORMAT(\[Date\], "dddd") ) |  |  |

**How many rows did it create? Does that match the number of days in your range?**  731 rows.  Yes, that matches: 2024 is a leap year with 366 days, and 2025 has 365 days, so 366 + 365 = 731. The calendar runs from 1 January 2024 to 31 December 2025, which starts on or before our earliest visit and ends on or after our latest (30 December 2025), so no visit falls outside it. 

| **4** | **Mark it — the step everyone skips** | 3 min |

Right-click dim\_date in the Fields pane \> Mark as date table \> choose the Date column.

Skipping this produces no error. Your time intelligence just quietly returns wrong numbers, and you find out in week 6\.

**Done? Who did it?**

Yes. `DateTable` was marked as a date table using the `Date` column. Done by Regina Robertson.
| :---- |

While you are there: File \> Options and settings \> Options \> Data Load, and untick Auto date/time for new files.

| Auto date/time switched off?  |
| :---- |

**Part C — Your first relationship**

| 5 | Join the date table to your fact table | 6 min |
| :---: | :---- | ----: |

Switch to Model view — the third icon down the left edge. Drag dim\_date\[Date\] onto visits\_clean\[visit\_date\].

Then double-click the line you just created and check three things.

| Cardinality — does it say one to many, with the 1 on dim\_date?  |
| :---- |
| **Cross-filter direction — is it Single?**  |
| **Is the line solid, or dashed?**  |

If it refused to create the relationship at all, your fact date column is probably still text — it did not parse in week 3\. Write that down as something to fix.

| Did it work? If not, what did it say?  |
| :---- |

**Part D — Talk about the rest**

No clicking for these. Ten minutes. You are planning the three relationships you will build after this session.

**Which column joins each dimension to visits\_clean?**

| Dimension \> column \> fact column, one line each:  |
| :---- |

**If Power BI offers many-to-many on any of them, what does that tell you?**

|   |
| :---- |

**Which columns will you rename, and to what? Your stakeholder should never see wait\_minutes.**

|   |
| :---- |

**Report back to the class**

Ninety seconds. Someone who has not spoken yet.

| 1\. Our grain, in one sentence:  |
| :---- |
| **2\. Did the date relationship work first time?**  |
| **3\. One thing we are stuck on:**  |

| Before you leave the breakout Save the .pbix. Commit it to dashboard/ even though it is half finished — a file on one laptop is a file nobody else can pick up. Still no visuals. Not one. |
| :---- |

