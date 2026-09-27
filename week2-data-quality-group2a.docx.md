**Week 2 — Data quality notes**

**Group 2a**  ·  Clinic visits  ·  your week 2 deliverable

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** | Regina Robertson  |
| **Who worked on it** | Regina Robertson |
| **Date completed** |  |

| Your question Which departments have the longest patient wait times, and how does that vary by visit type and over time? |
| :---- |

**What this document is for**

This is the single most important thing you produce before week 3\. Week 3 is cleaning — and you can only clean what you have found. Everything you write here becomes a decision you act on next week.

Work through your query pack from the top. It is called week2\_profiling\_clinic.sql and it has around twenty queries in the order you need them. Do not skip to the interesting ones.

*Fill in every box. Where a box asks for a number, give the number — not "some" or "a few*.

| A group that writes "the data looks fine" has not done week 2\. The problems in this dataset were put there deliberately. There are six kinds. If you have not found all six, keep looking. |
| :---- |

**1\. What is in the data**

Row counts for all four tables. Confirm the fact table against the number on your access sheet.

| SELECT 'visits' AS table\_name, count(\*) FROM raw\_clinic.visits UNION ALL SELECT 'patients', count(\*) FROM raw\_clinic.patients UNION ALL SELECT 'doctors', count(\*) FROM raw\_clinic.doctors UNION ALL SELECT 'departments', count(\*) FROM raw\_clinic.departments; |  |
| :---- | :---- |
| **visits  (expect 25,100)** | 25,100 |
| **patients  (expect 900\)** | 900  |
| **doctors  (expect 40\)** | 40 |
| **departments  (expect 8\)** | 8 |

| How the four tables join together — which column links to which: visits.patient_id → patients.patient_id, visits.doctor_id → doctors.doctor_id and visits.department_id → departments.department_id. visits is the fact table (one row per visit); patients, doctors and departments are the dimension tables it joins out to for names and details. |
| :---- |

**2\. The six problems**

One row per problem. The middle column is what you measured. The right column is the decision you will carry into week 3 — and the reason for it, because you will be asked.

| The problem | What we found (numbers) | What we will do, and why |
| :---- | :---- | :---- |
| **Missing values** | visit_type: 1,508 |  In week 3, we will label them as an explicit "Unknown" category rather than dropping the rows. The visits themselves are still real and contribute valid wait-time data; we just can't say what type of visit they were. |
| **Duplicate rows** | distinct visit_id: 100  |  we will drop or investigate the 100 repeated visit_ids before week 4 |
| **Inconsistent categories** | visit_type has 13 raw values but only 3 real categories (Outpatient, Follow-up, Emergency)  | We will standardize them with TRIM() + consistent casing in week 3; otherwise Power BI will treats them as different bars on the same chart  |
| **Date formats** | visit_date is stored as text. 4 formats present: YYYY-MM-DD (20,566), DD/MM/YYYY (1,558), YYYY/MM/DD (1,505), DD-Mon-YYYY (1,471)  | We will parse every row into a single real DATE type in week 3, reading slash-format dates as DD/MM/YYYY.  |
| **Impossible values** | 51 rows have negative wait_minutes |  Negative wait times are impossible so we will check if there's a pattern (same department, same date range, same data source) before we will decide to either correct or drop those rows before any average or median is calculated |
| **Orphan keys** |  62 visits have a patient_id with no matching row in patients. |  Since our question doesn't depend on patients, these 62 rows stay usable. We will tag the patient link as "Unknown" in week 3 rather than drop them. |




**3\. The seven numbers**

By the end of this week you must be able to say these without looking them up. Write them here anyway.

**a.  Rows in each table**

| visits: 25,100, patients: 900, doctors: 40 and departments: 8 |
| :---- |

**b.  Which columns have missing values, and how many in each**

| SELECT count(\*)                        AS total,        count(\*) \- count(visit\_type)   AS missing\_visit\_type FROM raw\_clinic.visits; |
| :---- |

*Check every column, not just this one.*

|  visit_date	0, visit_type	1,508, consultation_fee	0, patient_id	0, doctor_id	0 and department_id	0 |
| :---- |

**c.  How many duplicate rows, and in which table**

| SELECT count(\*) \- count(DISTINCT visit\_id) AS extras FROM raw\_clinic.visits; |
| :---- |
| 100 duplicate rows found in visits, identified by comparing the total row count (25,100) against the count of distinct visit_id values.  |

**d.  How many real categories hide behind the messy visit\_type values**

| SELECT count(DISTINCT visit\_type)               AS as\_stored,        count(DISTINCT upper(trim(visit\_type)))  AS actually FROM raw\_clinic.visits; |
| :---- |
| **As stored / actually — and which other text columns have the same problem:** 12 / 3 visit_type has 12 distinct raw values collapsing into 3 real categories (Outpatient, Follow-up, Emergency) once case and whitespace are normalized. The 1,508 missing rows are excluded from both counts since COUNT(DISTINCT) ignores NULLs. No other text column has this problem.|

**e. Which date formats appear in visit\_date, and how many rows use each:** Four date formats. Thus, YYYY-MM-DD, DD/MM/YYYY, YYYY/MM/DD and DD-Mon-YYYY 
| :---- |

*Ambiguous dates like 03/04/2025 could be 3 April or 4 March. Nothing in the data proves which. State which reading you chose and stick to it — this is a real analyst decision and you will be asked to defend it.*

**Our reading of ambiguous dates, and why:** 
We are reading all slash-separated dates (DD/MM/YYYY format) as day/month/year and applying this consistently across all 1,558 rows in this format. We chose this reading because we have confirmed it directly from the data: running a check for rows where the first number exceeds 12 returned real examples, including 29/07/2024, 27/08/2024 and 26/07/2025. Since no calendar has a 29th, 27th or 26th month, the first number in these dates must be the day, not the month. We are applying this DD/MM/YYYY reading consistently throughout the project. 
| :---- |

**f.  How many impossible values (negative wait times)**

| SELECT min(wait\_minutes) AS lowest, max(wait\_minutes) AS highest FROM raw\_clinic.visits; |
| :---- |
|  Lowest: -209 and Highest: 209. Running a count of rows where wait_minutes < 0 confirms 51 impossible values such rows out of 25,100 |

**g.  How many orphan keys**

| SELECT count(\*) AS orphans FROM raw\_clinic.visits f LEFT JOIN raw\_clinic.patients d   ON f.patient\_id \= d.patient\_id WHERE d.patient\_id IS NULL;  |
| :---- |

*Check every foreign key, not just this one. A plain JOIN would silently drop these rows and your totals would be wrong with no error shown.*

| patient_id: 62 orphan rows, doctor_id: 0 and department_id: 0 orphans. Only the patient link has orphan keys, the doctor and department links are fully clean. |
| :---- |

**4\. Two things the query pack wants you to notice**

**The date range that makes no sense**

Query 9 asks for the earliest and latest visit\_date. The answer is nonsense. Work out why before reading on, then write the explanation here.

**What we got, and why it happens:**
| visit_date is stored as TEXT, not a real DATE type, because the source mixes four different formats that wouldn't load cleanly as one type. Because it's text, MIN()/MAX() sort alphabetically, not chronologically so Week 1's result (01/01/2024 and 31-Oct-2025) isn't the true earliest or latest visit, just whichever strings happen to sort first/last as characters. The real date range can only be trusted once every row is parsed into a genuine date type in week 3.|
| :---- |

**The monthly rollup that throws data away**

Query 10 filters to rows already in YYYY-MM-DD form. How many rows does that quietly discard, and what would that have done to a dashboard built on it?

**Rows discarded, and the consequence:**

|Filtering to only YYYY-MM-DD-formatted rows discards 4,534 rows (25,100 − 20,566) about 18% of the entire dataset, covering every row in DD/MM/YYYY, YYYY/MM/DD and DD-Mon-YYYY format. A dashboard built on this filtered query would understate visit counts and skew wait-time trends for any month or department with more non-standard-formatted dates than others, with no error or warning shown. This is why every row needs to be parsed into one consistent date type in week 3 before any time-based analysis is trustworthy. |
| :---- |

**5\. Is this data ready to answer your question?**

Now that you know what is wrong with it — honestly, not optimistically.

**Which of the four tables do you actually need to answer your question? Do you need all four?** 

| No, we don't need all four. Only visits and departments are required. visits contains wait_minutes, visit_type and visit_date (everything the question asks about) and departments is needed only to translate department_id into a readable name. patients and doctors aren't needed for this question. |
| :---- |

**Name one number that would be wrong today if you built a dashboard without fixing anything:**  Total visit count. The dashboard would show 25,100 total visits but only 25,000 are actually unique; 100 rows are exact duplicates of an existing visit_id, so every count, sum or average built on the raw data is inflated by those 100 extra rows.|

| **What must be fixed in week 3 before the model in week 4 will work:**  Four things, in order of how much they block the analysis: (1) parse visit_date into one consistent real date type across all four formats, since nothing time-based works until then; (2) standardize visit_type casing or whitespace so the 12 raw variants collapse into 3 real categories; (3) remove the 100 duplicate visit_id rows to avoid double-counting visits; (4) handle the 51 negative wait_minutes values, since they can't be included in any average or median as they stand currently.|

**6\. Our plan for week 3**

Turn section 2 into an ordered list of cleaning steps. This becomes your notebook next week.

| **1\.** We will parse visit_date into a single real date type, correctly handling all four formats found (YYYY-MM-DD, DD/MM/YYYY, YYYY/MM/DD, DD-Mon-YYYY) this unblocks every time-based part of the analysis. |
| **2\.** Standardize the visit_type by trimming whitespace and normalizing case, collapsing the 12 raw variants into the 3 real categories (Outpatient, Follow-up, Emergency). |
| **3\.** Label the 1,508 rows with missing visit_type as an explicit "Unknown" category rather than dropping them.  |
| **4\.** Remove the 100 duplicate rows (identified by repeated visit_id), keeping one copy of each. |
| **5\.** Investigate the 51 rows with negative wait_minutes; correct where a real value can be recovered, otherwise we will treat as missing rather than including a negative number in any calculation. |
| **6\.** Tag the 62 orphan patient_id rows (no matching row in patients) as "Unknown" patient rather than dropping the visit. doctor_id and department_id are already fully clean, so no action is needed there. |

**7\. Questions for the weekly call**
| :---- |
|1. Are the 100 duplicate rows exact duplicates in every column or do they differ somewhere (e.g. a re-entered wait time)? Worth checking before deciding whether to just delete or investigate case-by-case.

| :---- |
2. Is there any acceptable upper bound for wait_minutes we should also flag as suspicious (e.g. is 209 minutes itself plausible or should we question the top end too)?

| :---- |
3. If we label the 1,508 missing visit_type rows and 62 orphan patient_id rows as "Unknown" rather than dropping them, should "Unknown" visits be included in department-level wait-time averages? |


| Before you submit this Every .sql file you wrote is saved in your sql/ folder and pushed. This document is committed. Every number above is filled in with an actual figure. Data-quality findings can be shared openly with group2b — you will both hit the same potholes. Your analysis and your decisions stay yours. |
| :---- |

