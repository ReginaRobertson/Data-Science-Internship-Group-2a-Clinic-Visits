**Week 3 — Cleaning decisions**

**Group 2a**  ·  Clinic visits  ·  your week 3 deliverable

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** | Regina Robertson |
| **Who worked on the notebook** | Regina Robertson |
| **Date completed** | 28th September, 2026 |

| What you are producing this week Clean tables in your group2a schema, a notebook that rebuilds them from scratch, and this record of every decision you made and why. |
| :---- |

**Why the decisions matter more than the code**

Your notebook already has the code. What it cannot have is your judgement. Every problem you found in week 2 has two or three defensible fixes, and choosing between them is the actual analyst work.

You will be asked to defend these choices in week 8\. "It seemed fine" is not a defence. "We dropped 60 rows because a negative quantity cannot be a real sale, and 60 out of 30,000 was too few to change any conclusion" is.

| There is no single right answer to most of this. There is a wrong one: doing it silently, so that nobody including you can say later what happened to the data. |
| :---- |

**1\. Your six decisions**

One row per problem from week 2\. What you did, and the reason. Numbers in the middle column — how many rows were affected.

| The problem | How many rows | What we did, and why |
| :---- | :---- | :---- |
| **Duplicate rows** | 100  | We dropped them using drop_duplicates() on visit_id, keeping the first occurrence. This is because exact repeats would double-count visits and inflate any total or average. |
| **Inconsistent categories** |  23,592 (all non-missing rows) | We standardized visit_type using .str.strip().str.title(), which removes extra whitespace and fixes inconsistent capitalization. This is because the same category was being stored in several different ways — for example, "Outpatient", "OUTPATIENT", "outpatient", and " Outpatient " were all treated as separate values, when they represent the same real category. Standardizing them ensures each visit type is counted once, correctly, instead of being split across multiple near-duplicate labels. |
| **Date formats** | 25,000 (all rows after removing duplicates) | We parsed visit_date from text into a real date type with pd.to_datetime(format='mixed', dayfirst=True), so all four raw formats (YYYY-MM-DD, YYYY/MM/DD, DD/MM/YYYY, DD-Mon-YYYY) now share one type. We kept dayfirst=True because slash dates such as 29/07/2024 can only be day/month. Zero rows failed to parse. We checked each format against a strict parse that allows only one reading, and all rows matched (20,566, 1,505, 1,558 and 1,471 of the raw 25,100), so no day and month were swapped. The range is now 1 January 2024 to 30 December 2025. |
| **Impossible values** | 50 rows with negative wait_minutes in the cleaned data | We checked for a pattern before deciding, as planned in week 2. The negatives are spread across all 8 departments (1 to 9 rows each), across nearly every month from 2024 to 2025, and across all three visit types, so nothing points to a systematic cause such as a bad load from one period or one department. With no evidence of what the true values were, we set wait_minutes to NULL for these rows. We did not drop them because their department, visit type and date are still valid. NULL values are skipped by averages and medians, so they don't distort the results. The row count stays at 25,000.|
| **Orphan keys** | 62 visits have a patient_id with no matching row in patients | We kept the rows and pointed them at an "Unknown" patient record (patient_id = -1) that we added to the patients table. Our question is about departments, visit type and wait times, and these visits still have valid values for all three, so dropping them would remove 62 real visits from every total for no benefit. Keeping them means the dashboard shows an honest "Unknown" patient group instead of quietly losing rows. A plain join would have dropped them without any error. We also checked the other two foreign keys, doctor_id and department_id and neither has orphans. The row count stays at 25,000. |
| **Missing values** |visit_type 1500, wait_minutes 50 | The visit_type was filled with 'Unknown'.It's a category we group by. The visits are real and their wait times are valid, so we have kept them and they will show as their own "Unknown" group in Power BI. Dropping them would lose about 6% of the data. (The raw table had 1,508. Eight were in the duplicate rows we removed.) whilst  with the wait_minutes, the 50 negative values were set to NULL under the impossible values. |

**2\. The ambiguous dates**

A date written 03/04/2025 could be 3 April or 4 March. Nothing in the data proves which. Your notebook uses dayfirst=True, which reads it as 3 April.

**Did you keep dayfirst=True, or change it? What made you decide?** 
We kept dayfirst=True. Only the slash format (DD/MM/YYYY) is ambiguous. The year-first formats and DD-Mon-YYYY (month spelled out) can only be read one way. For the slash format the data does give evidence: rows such as 29/07/2024, 27/08/2024 and 26/07/2025 have a first number above 12 and no month is numbered above 12, so the first number must be the day. It would be inconsistent for the remaining slash dates to follow a different rule, so we applied day/month/year to every slash date. We also compared the parsed result against a strict %d/%m/%Y parse, and all 1,558 raw slash rows matched.
| :---- |

| **How many rows would be affected if you had it backwards?**  535 of the 25,000 cleaned rows would get a different date. These are slash dates where both numbers are 12 or less and differ, for example 09/11/2024, which we read as 9 November 2024 but a month-first reading would turn into 11 September 2024. Every other row is unaffected. The overall range would not change, because it is 1 January 2024 to 30 December 2025 either way. That means the range check alone cannot prove the reading is right, so our decision rests on the rows with a first number above 12. The effect would be limited to monthly trends, where up to 535 visits could land in the wrong month, so we treated it as a decision to record and defend, not a setting to leave at its default.|

**3\. Before and after**

From section 10 of your notebook. Every number that changed needs an explanation that adds up.

**Row count**

| Before / after / difference: 25100 /25000 / 100 |
| :---- |
| **Account for every row you lost — how many were duplicates, how many impossible, how many orphans. The numbers must add up:**  We lost 100 rows in total (25,100 to 25,000). All 100 were duplicates: exact copies of another row, sharing the same visit_id and we kept the first copy of each. Impossible values cost 0 rows, because the 50 negative wait_minutes were set to NULL and the rows stayed. Orphan keys cost 0 rows, because the 62 orphan patient_id values were repointed to an Unknown record. 100 duplicates + 0 impossible + 0 orphans = 100 rows lost, which matches the drop exactly.|

**Categories in visit\_type**

| **Before / after:**  
12 distinct values as stored (13 groups if the blank rows are counted)/ 4 values: Outpatient, Follow-Up, Emergency and Unknown. Standardizing case and whitespace merged the 12 variants into the 3 real categories, and the fourth is the 'Unknown' label given to the 1,500 blank rows that remained after the duplicates were removed.|
| :---- |

**Missing values**

| **Before / after, and what accounts for the change:** 
1,508 missing values, all in visit_type. Every other column was complete, including wait_minutes./ 50 missing values, all in wait_minutes. visit_type and every other column have 0, duplicates were removed,blanks were filled with 'Unknown'for visit_type and negative wait_minutes values were set to null. |
| :---- |

**Date range**

| **What the range is now, and how it compares with the nonsense you got in week 2:** 
The date range is now 1 January 2024 to 30 December 2025, two full calendar years, with nothing before 2024 and nothing in the future. In week 2 the text version gave 01/01/2024 to 31-Oct-2025. That result was wrong because visit_date was stored as text and text sorts character by character rather than by date. So "31-Oct-2025" came out as the latest value, even though the real latest visit is two months later, on 30 December 2025. Now that visit_date is a real date type, sorting is chronological and the problem is gone. We also checked each of the four raw formats against a strict parse, and every row matched, so the range is not distorted by any day and month being swapped. |
| :---- |

**4\. Tables you wrote back**

Everything now in your group2a schema, with row counts. Power BI reads these next week, so they need to be right.

**Table name / rows / what it is: visits_clean, 25,000 rows**. 
visits_clean, 25,000 rows. The fact table, where one row is one patient visit. Duplicates were removed and visit_date was parsed to a real date. The 50 negative wait_minutes values were set to NULL and the 62 orphan patient_id values were pointed at the Unknown patient record. It has 8 columns: visit_id, visit_date, patient_id, doctor_id, department_id, visit_type, wait_minutes and consultation_fee.

patients_clean, 901 rows. The 900 patients, with sex and region standardized, plus one Unknown record (patient_id = -1) that the orphan visits point to.

doctors_clean, 40 rows. The doctors dimension.

departments_clean, 8 rows. The departments dimension.


**5\. Reproducibility check**

A notebook that only works on one laptop, in the order that person happened to click, is not finished. Test it properly before answering this.

*Runtime → Restart runtime, then Run all. Then have somebody else do the same on their machine.*

| Who else ran it, on what machine, and did they get the same tables?  |
| :---- |
| **If it failed the first time, what was wrong and how did you fix it?**  |

**6\. Is it ready for week 4?**

Next week you build a star schema on these tables. Think ahead.

| **Which table will be your fact table, and what does one row represent?** visits_clean is the fact table. One row is one patient visit (25,000 rows) |
| :---- |
| **Which will be your dimensions?** departments_clean (8 rows) is the dimension our question needs, because it turns department_id into a department name. patients_clean (901 rows, including the Unknown record) and doctors_clean (40 rows) are also available as dimensions. We will build a date table ourselves in week 4 |
| **Do any columns still need work before the model will hold together?** visit_date carries a time part (00:00:00), so we will convert it to a plain date before relating it to the date table. The column names need renaming for a non-analyst reader and the raw key columns will be hidden in the report view. We also need to confirm that patient_id is unique in patients_clean, so the relationship is one-to-many. |
| **Anything you deliberately left alone, and why:** We left the 50 NULL wait_minutes values as they are, because we cannot know the true waits and filling them in would invent data. We kept the 1,500 Unknown visit_type rows and the 62 visits pointing at the Unknown patient record, so those real visits stay in the totals instead of being dropped. We did not investigate the high end of wait_minutes (the maximum is 209 minutes) or analyze consultation_fee, because our question does not depend on either. |

**7\. Questions for the weekly call**
1. Should the Unknown visit_type rows appear in the department wait-time charts or be filtered out? Including them keeps 1,500 valid wait times, but they cannot be split by visit type.
2. Is a wait of around 209 minutes plausible for this clinic or should we treat the top end as suspect too?
3. Our question only uses visits and departments, so do we need patients and doctors in the week 4 model at all? 


| Before you submit this Notebook committed to notebooks/ and runs from a fresh runtime. Clean tables visible in your schema. Every decision above has a reason attached. No password anywhere in the notebook. Cleaning approaches can be discussed openly with group2b. Your decisions and your reasoning stay yours. |
| :---- |

