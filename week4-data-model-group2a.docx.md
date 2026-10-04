**Week 4 — Your data model**

**Group 2a**  ·  Clinic visits  ·  your week 4 deliverable

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** | Regina Robertson |
| **Who built the model** | Regina Robertson |
| **Date completed** | 4th October, 2026 |

| No visuals this week A .pbix with a working model and nothing on the canvas. A chart built on a broken model looks fine and is wrong — you would not find out until week 6\. |
| :---- |

**1\. Your grain**

The single most important sentence in your model. Everything else follows from it.

Complete it: one row of our fact table is one patient visit.

| One row of visits\_clean is one:  patient visit |
| :---- |
| **How many rows does it have after cleaning, and does that match your week 3 notes?**  25,000 rows. Yes, this matches our week 3 notes exactly. We started with 25,100 rows, dropped 100 exact duplicates, and the remaining 25,000 is what was written to visits_clean and confirmed again today when the Power BI total (2,652,563) matched the SQL total against this same table. |

**2\. Tables you loaded**

Only the \_clean tables from your own schema. If anything from raw\_clinic is in here, say so and explain why.

| Fact table (name and row count): visits_clean, 25,000 rows. |
| :---- |
| **Dimension tables (name and row count each):**  departments_clean (8 rows), patients_clean (901 rows, including the Unknown record), doctors_clean (40 rows), plus DateTable (731 rows, built in Power BI rather than loaded from the database). |
| **Anything you loaded and then removed, and why:**  Nothing from raw_clinic was loaded. We loaded only the four_clean tables from our own schema, so the raw text dates, duplicates and messy categories never entered the model. We also saw two other tables in our schema when connecting (test and zz_Regbert_visits) but did not load either; they appear to be scratch tables from earlier experimentation, not part of our cleaned data. |

**3\. Your date table**

| Date range it covers (start and end): 1 January 2024 to 31 December 2025. |
| :---- |
| **Does that fully cover the minimum and maximum date in your fact table? How did you check?** Yes. Our week 3 notebook confirmed visit_date in visits_clean ranges from 1 January 2024 to 30 December 2025, after parsing. DateTable covers the full two calendar years (through 31 December 2025), so every visit date falls inside it with no gaps at either end. |
| **Columns you added beyond Date:** Year, Month, MonthNumber, Quarter, DayOfWeek. |

Marked as a date table? This is the step everyone skips, and skipping it gives wrong answers with no error.

**Marked as date table — yes or no, and who did it:**  Yes, Regina Robertson did it.
| :---- |
| **Auto date/time switched off — yes or no:**  Yes |

**4\. Your relationships**

One row per relationship. Every one should read: one row in the dimension, many in the fact table, filtering one way.

| From (dimension) | To (fact) | On column | Cardinality | Direction |
| :---- | :---- | :---- | :---- | :---- |
| departments_clean | visits_clean | department_id | One to many | Single |
| patients_clean | visits_clean | patient_id | One to many | Single |
| DateTable | visits_clean | Date (visit_date) | One to many | Single |
| departments_clean | doctors_clean  | department_id | One to many | Single |

**Did Power BI offer many-to-many on any of them? If so, which, and what did you do about it?**  Not directly as a cardinality option, but we triggered an equivalent warning. When we tried activating a direct relationship between visits_clean and doctors_clean on doctor_id, Power BI blocked it with an "ambiguous paths" error — two active routes would have existed between the same two tables (the direct one and an indirect one through departments_clean). We left that relationship inactive rather than force it.

**Any inactive (dashed) relationships? Why do they exist?** Yes, one; visits_clean to doctors_clean on doctor_id. It exists because we loaded doctors_clean into the model, but an active path to it already flows indirectly through departments_clean (visits_clean links to departments_clean,departments_clean links to doctors_clean). Power BI won't allow two active paths between the same two tables, so this direct one stays inactive. Our question doesn't need doctor-level analysis, so we didn't force it active.

**5\. Making it readable**

Your stakeholder is not an analyst. They should never see a column called wait\_minutes.

**Columns you renamed — original name and new name (the important ones):** wait_minutes to Wait Time (Minutes), visit_type to Visit Type, department_name to Department Name, consultation_fee to Consultation Fee, visit_date to Visit Date, patient_name to Patient Name, doctor_name to Doctor Name and birth_year to Birth Year, sex to Sex, region to Region. 
| :---- |
| **Columns you hid, and why:**  We hid every raw ID column. Thus, visit_id, patient_id, doctor_id, department_id in visits_clean, plus the matching department_id, patient_id, doctor_id in the dimension tables. These exist only to make the relationships work; a stakeholder has no use for them and could accidentally drag one onto a chart, producing a meaningless count instead of a real breakdown. |
| **Data types you corrected:** Visit Date was set to Date, Wait Time (Minutes) set to Whole Number, Consultation Fee set to Fixed Decimal Number with Currency format. |
| **Month sorting fixed with MonthNumber — yes or no:** Yes. Month in DateTable is sorted by MonthNumber, so months display in calendar order (January to December) rather than alphabetically. |

**6\. Proving the model works**

You have no visuals, so you cannot eyeball it. Check the numbers directly instead: drop a field into a table visual temporarily, read the total, then delete the visual.

| Total wait\_minutes from Power BI:  2,652,563 |
| :---- |
| **The same total from a SQL query against your clean table:**  2,652,563, from SELECT sum(wait_minutes) AS total_wait FROM group2a.visits_clean;|
| **Do they match? If not, what is different and why?**  Yes, they match exactly. |

Now the same by a dimension attribute — this proves the relationship actually works.

**Total by department\_name — does the breakdown add up to the grand total?**  Yes. Both Power BI and SQL gave the same eight department totals, row for row: Dental 330,497, Emergency 335,095, General Medicine 332,316, Laboratory 333,574, Maternity 336,592, Ophthalmology 327,973, Paediatrics 325,788 and Physiotherapy 330,728. These sum to 2,652,563, matching the grand total exactly, which confirms the departments_clean link to visits_clean relationship filters correctly.  
| :---- |

**7\. What your Model view looks like**

Take a screenshot of Model view and paste it below, or describe the shape.

| <img width="1920" height="992" alt="Screenshot (118)" src="https://github.com/user-attachments/assets/eec1b8f4-acce-49f1-b7a4-78ec8c9b4350" />|
| :---- |
| **Is it a star — fact in the middle, every dimension joined only to it? If anything is joined dimension-to-dimension, say which:**  Not quite a pure star. it's a star with one exception. visits_clean sits at the centre, and three dimensions are joined directly and only to it: patients_clean, departments_clean and DateTable. doctors_clean is the exception; it's joined to departments_clean rather than directly to the fact table, because the direct visits_clean link to doctors_clean relationship is inactive (Power BI blocked it as an ambiguous path, since an active route to doctors_clean already exists through departments_clean). This was a deliberate outcome of resolving that conflict, not an oversight and since our question doesn't need doctor-level analysis, we left the model as it is rather than restructuring it around a table we won't use. |

**8\. Ready for week 5?**

Next week is measures and your first dashboard. It goes fast if the model is right.

**Which measures do you already know you will need?**   Average wait time, median wait time, visits per department, share of emergency visits and total/average wait time by visit type. These map directly to our sub-questions from scope.md; department ranking needs average and median wait; the visit-type breakdown needs wait time split by Visit Type; and the "over time" part needs these measures sliced by DateTable's Month and Year.
| :---- |
**Anything still not working that you need help with:**   Nothing broken right now; the model checks out (section 6 confirmed totals match SQL exactly). One open decision to carry into week 5: whether "Unknown" Visit Type rows (1,500 of them) and the "Unknown" patient record should be included or excluded from the department wait-time measures, since that will change what the numbers show.

**9\. Questions for the weekly call**

1. Should DAX measures exclude "Unknown" Visit Type and "Unknown" patient rows, or include them as their own category?

2. Is doctors_clean worth keeping in the model at all for week 5, given it's not directly connected to visits_clean and our question doesn't use doctor-level data?

3. Should Consultation Fee be included in any week 5 measure, or is it confirmed out of scope per our scope.md? 

| Before you submit this .pbix committed to dashboard/. Date table marked. Every relationship one-to-many, single direction, solid. Columns renamed, IDs hidden. No visuals. Modelling approaches can be discussed openly with group2b. Your model and your measures stay yours. |
| :---- |

