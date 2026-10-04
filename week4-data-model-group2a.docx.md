**Week 4 — Your data model**

**Group 2a**  ·  Clinic visits  ·  your week 4 deliverable

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** |  |
| **Who built the model** |  |
| **Date completed** |  |

| No visuals this week A .pbix with a working model and nothing on the canvas. A chart built on a broken model looks fine and is wrong — you would not find out until week 6\. |
| :---- |

**1\. Your grain**

The single most important sentence in your model. Everything else follows from it.

Complete it: one row of our fact table is one …

| One row of visits\_clean is one:  |
| :---- |
| **How many rows does it have after cleaning, and does that match your week 3 notes?**  |

**2\. Tables you loaded**

Only the \_clean tables from your own schema. If anything from raw\_clinic is in here, say so and explain why.

| Fact table (name and row count):  |
| :---- |
| **Dimension tables (name and row count each):**  |
| **Anything you loaded and then removed, and why:**  |

**3\. Your date table**

| Date range it covers (start and end):  |
| :---- |
| **Does that fully cover the minimum and maximum date in your fact table? How did you check?**  |
| **Columns you added beyond Date:**  |

Marked as a date table? This is the step everyone skips, and skipping it gives wrong answers with no error.

| Marked as date table — yes or no, and who did it:  |
| :---- |
| **Auto date/time switched off — yes or no:**  |

**4\. Your relationships**

One row per relationship. Every one should read: one row in the dimension, many in the fact table, filtering one way.

| From (dimension) | To (fact) | On column | Cardinality | Direction |
| :---- | :---- | :---- | :---- | :---- |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

| Did Power BI offer many-to-many on any of them? If so, which, and what did you do about it?  |
| :---- |
| **Any inactive (dashed) relationships? Why do they exist?**  |

**5\. Making it readable**

Your stakeholder is not an analyst. They should never see a column called wait\_minutes.

| Columns you renamed — original name and new name (the important ones):  |
| :---- |
| **Columns you hid, and why:**  |
| **Data types you corrected:**  |
| **Month sorting fixed with MonthNumber — yes or no:**  |

**6\. Proving the model works**

You have no visuals, so you cannot eyeball it. Check the numbers directly instead: drop a field into a table visual temporarily, read the total, then delete the visual.

| Total wait\_minutes from Power BI:  |
| :---- |
| **The same total from a SQL query against your clean table:**  |
| **Do they match? If not, what is different and why?**  |

Now the same by a dimension attribute — this proves the relationship actually works.

| Total by department\_name — does the breakdown add up to the grand total?  |
| :---- |

**7\. What your Model view looks like**

Take a screenshot of Model view and paste it below, or describe the shape.

|   |
| :---- |
| **Is it a star — fact in the middle, every dimension joined only to it? If anything is joined dimension-to-dimension, say which:**  |

**8\. Ready for week 5?**

Next week is measures and your first dashboard. It goes fast if the model is right.

| Which measures do you already know you will need?  |
| :---- |
| **Anything still not working that you need help with:**  |

**9\. Questions for the weekly call**

|   |
| :---- |

| Before you submit this .pbix committed to dashboard/. Date table marked. Every relationship one-to-many, single direction, solid. Columns renamed, IDs hidden. No visuals. Modelling approaches can be discussed openly with group2b. Your model and your measures stay yours. |
| :---- |

