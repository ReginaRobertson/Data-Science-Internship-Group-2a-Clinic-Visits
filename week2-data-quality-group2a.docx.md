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

*Fill in every box. Where a box asks for a number, give the number — not "some" or "a few".*

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
| **Missing values** | visit_type: 1,508 |   |
| **Duplicate rows** | distinct visit_id: 100  |  we will drop or investigate the 100 repeated visit_ids before week 4 |
| **Inconsistent categories** | visit_type has 13 raw values but only 3 real categories (Outpatient, Follow-up, Emergency)  | We will standardize them with TRIM() + consistent casing in week 3; otherwise Power BI will treats them as different bars on the same chart  |
| **Date formats** | visit_date is stored as TEXT. 4 formats present: YYYY-MM-DD (20,566), DD/MM/YYYY (1,558), YYYY/MM/DD (1,505), DD-Mon-YYYY (1,471)  | We will parse every row into a single real DATE type in week 3, reading slash-format dates as DD/MM/YYYY.  |
| **Impossible values** | 51 rows have negative wait_minutes |  Negative wait times are impossible so we will check if there's a pattern (same department, same date range, same data source) before we will decide to either correct or drop those rows before any average or median is calculated |
| **Orphan keys** |  62 visits have a patient_id with no matching row in patients. |  Since our question doesn't depend on patients, these 62 rows stay usable. We will tag the patient link as "Unknown" in week 3 rather than drop them. |


|   |
| :---- |

**3\. The seven numbers**

By the end of this week you must be able to say these without looking them up. Write them here anyway.

**a.  Rows in each table**

| visits: 25,100, patients: 900, doctors: 40 and departments: 8 |
| :---- |

**b.  Which columns have missing values, and how many in each**

| SELECT count(\*)                        AS total,        count(\*) \- count(visit\_type)   AS missing\_visit\_type FROM raw\_clinic.visits; |
| :---- |

*Check every column, not just this one.*

|   |
| :---- |

**c.  How many duplicate rows, and in which table**

| SELECT count(\*) \- count(DISTINCT visit\_id) AS extras FROM raw\_clinic.visits; |
| :---- |
|  |

**d.  How many real categories hide behind the messy visit\_type values**

| SELECT count(DISTINCT visit\_type)               AS as\_stored,        count(DISTINCT upper(trim(visit\_type)))  AS actually FROM raw\_clinic.visits; |
| :---- |
| **As stored / actually — and which other text columns have the same problem:**  |

**e.  Which date formats appear in visit\_date, and how many rows use each**

|   |
| :---- |

*Ambiguous dates like 03/04/2025 could be 3 April or 4 March. Nothing in the data proves which. State which reading you chose and stick to it — this is a real analyst decision and you will be asked to defend it.*

| Our reading of ambiguous dates, and why:  |
| :---- |

**f.  How many impossible values (negative wait times)**

| SELECT min(wait\_minutes) AS lowest, max(wait\_minutes) AS highest FROM raw\_clinic.visits; |
| :---- |
|   |

**g.  How many orphan keys**

| SELECT count(\*) AS orphans FROM raw\_clinic.visits f LEFT JOIN raw\_clinic.patients d   ON f.patient\_id \= d.patient\_id WHERE d.patient\_id IS NULL; |
| :---- |

*Check every foreign key, not just this one. A plain JOIN would silently drop these rows and your totals would be wrong with no error shown.*

|   |
| :---- |

**4\. Two things the query pack wants you to notice**

**The date range that makes no sense**

Query 9 asks for the earliest and latest visit\_date. The answer is nonsense. Work out why before reading on, then write the explanation here.

| What we got, and why it happens:  |
| :---- |

**The monthly rollup that throws data away**

Query 10 filters to rows already in YYYY-MM-DD form. How many rows does that quietly discard, and what would that have done to a dashboard built on it?

| Rows discarded, and the consequence:  |
| :---- |

**5\. Is this data ready to answer your question?**

Now that you know what is wrong with it — honestly, not optimistically.

| Which of the four tables do you actually need to answer your question? Do you need all four?  |
| :---- |
| **Name one number that would be wrong today if you built a dashboard without fixing anything:**  |
| **What must be fixed in week 3 before the model in week 4 will work:**  |

**6\. Our plan for week 3**

Turn section 2 into an ordered list of cleaning steps. This becomes your notebook next week.

| 1\.  |
| :---- |
| **2\.**  |
| **3\.**  |
| **4\.**  |
| **5\.**  |
| **6\.**  |

**7\. Questions for the weekly call**

|   |
| :---- |

| Before you submit this Every .sql file you wrote is saved in your sql/ folder and pushed. This document is committed. Every number above is filled in with an actual figure. Data-quality findings can be shared openly with group2b — you will both hit the same potholes. Your analysis and your decisions stay yours. |
| :---- |

