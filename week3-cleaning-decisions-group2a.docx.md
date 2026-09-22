**Week 3 — Cleaning decisions**

**Group 2a**  ·  Clinic visits  ·  your week 3 deliverable

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** |  |
| **Who worked on the notebook** |  |
| **Date completed** |  |

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
| **Duplicate rows** |   |   |
| **Inconsistent categories** |   |   |
| **Date formats** |   |   |
| **Impossible values** |   |   |
| **Orphan keys** |   |   |
| **Missing values** |   |   |

**2\. The ambiguous dates**

A date written 03/04/2025 could be 3 April or 4 March. Nothing in the data proves which. Your notebook uses dayfirst=True, which reads it as 3 April.

| Did you keep dayfirst=True, or change it? What made you decide?  |
| :---- |
| **How many rows would be affected if you had it backwards?**  |

**3\. Before and after**

From section 10 of your notebook. Every number that changed needs an explanation that adds up.

**Row count**

| Before / after / difference:  |
| :---- |
| **Account for every row you lost — how many were duplicates, how many impossible, how many orphans. The numbers must add up:**  |

**Categories in visit\_type**

| Before / after:  |
| :---- |

**Missing values**

| Before / after, and what accounts for the change:  |
| :---- |

**Date range**

| What the range is now, and how it compares with the nonsense you got in week 2:  |
| :---- |

**4\. Tables you wrote back**

Everything now in your group2a schema, with row counts. Power BI reads these next week, so they need to be right.

| Table name / rows / what it is:  |
| :---- |

**5\. Reproducibility check**

A notebook that only works on one laptop, in the order that person happened to click, is not finished. Test it properly before answering this.

*Runtime → Restart runtime, then Run all. Then have somebody else do the same on their machine.*

| Who else ran it, on what machine, and did they get the same tables?  |
| :---- |
| **If it failed the first time, what was wrong and how did you fix it?**  |

**6\. Is it ready for week 4?**

Next week you build a star schema on these tables. Think ahead.

| Which table will be your fact table, and what does one row represent?  |
| :---- |
| **Which will be your dimensions?**  |
| **Do any columns still need work before the model will hold together?**  |
| **Anything you deliberately left alone, and why:**  |

**7\. Questions for the weekly call**

|   |
| :---- |

| Before you submit this Notebook committed to notebooks/ and runs from a fresh runtime. Clean tables visible in your schema. Every decision above has a reason attached. No password anywhere in the notebook. Cleaning approaches can be discussed openly with group2b. Your decisions and your reasoning stay yours. |
| :---- |

