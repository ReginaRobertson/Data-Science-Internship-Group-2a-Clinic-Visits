**Week 5 — Measures and first dashboard**

**Group 2a**  ·  Clinic visits  ·  your week 5 deliverable

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** |  |
| **Who wrote the measures** |  |
| **Who built the dashboard** |  |
| **Date completed** |  |

| Your question Which departments have the longest patient wait times, and how does that vary by visit type and over time? |
| :---- |

**Ugly is expected this week**

You are proving the numbers are right, not designing anything. Week 6 is when it gets to look good. A beautiful dashboard built on a wrong total is worse than an ugly one built on a right total, because nobody questions it.

**1\. Your measures**

Five is plenty. Write the DAX for each one here — we will be reading it, so format it readably.

**1\.  Average Wait**

| The DAX:  |
| :---- |

**2\.  Median Wait**

| The DAX:  |
| :---- |

**3\.  Visits**

| The DAX:  |
| :---- |

**4\.  % Emergency Visits**

| The DAX:  |
| :---- |

**5\.  Fee Revenue**

| The DAX:  |
| :---- |

**2\. Proving the numbers are right**

Every measure, checked against a SQL query in DBeaver. This is the most important section in the form — a measure that returns a plausible wrong number is worse than one that errors, because nobody notices.

| \-- the pattern, in DBeaver SELECT round(sum(wait\_minutes), 2\) FROM group2a.visits\_clean; \-- then drop the measure into a card in Power BI \-- the two must match exactly |
| :---- |

| Measure name | Power BI says | SQL says | Match? If not, why |
| :---- | :---- | :---- | :---- |
| **Average Wait** |  |  |  |
| **Median Wait** |  |  |  |
| **Visits** |  |  |  |
| **% Emergency Visits** |  |  |  |
| **Fee Revenue** |  |  |  |

| If any did not match — what was wrong, and what did you change? (Usually the model, not the measure.)  |
| :---- |

**3\. Assumptions you had to make**

Some measures need a decision that the data cannot settle, exactly like dayfirst in week 3\. State them plainly — you will be asked to defend them in week 8\.

**Do you report mean or median wait as the headline — and why?**

| Our decision, and why:  |
| :---- |
| **Any other assumptions buried in your measures:**  |

**4\. Your dashboard page**

One page. Cards along the top, a trend, a breakdown, at least one slicer.

| Which measures are on the cards?  |
| :---- |
| **What is the trend chart showing, and is it using dim\_date rather than the fact table's own date column?**  |
| **What is the breakdown chart showing?**  |
| **Which slicers did you add? Did you click them and watch every visual change?**  |

**Paste a screenshot of the page below**

|   |
| :---- |

**5\. What does it actually say?**

You now have real numbers for the first time. What do they tell you about your question?

| The single most interesting thing you can see so far:  |
| :---- |
| **Anything that surprised you, or contradicted what you expected in week 1:**  |
| **Anything that looks wrong rather than surprising — and what you plan to check:**  |

**6\. Ready for week 6?**

Week 6 is iteration — fixing what this draft exposed and making it readable. Think about what it exposed.

| What is missing from the model that you now wish you had? (A dimension, a column, a derived field.)  |
| :---- |
| **Which of your week 1 sub-questions can this dashboard already answer?**  |
| **Which cannot be answered yet, and what would it take?**  |

**7\. Questions for the weekly call**

|   |
| :---- |

| Before you submit this Five measures written, named in plain English and formatted. Every one checked against SQL. One dashboard page with cards, a trend, a breakdown and a working slicer. The .pbix committed to dashboard/. Measure definitions can be discussed openly with group2b. Your dashboard and your findings stay yours. |
| :---- |

