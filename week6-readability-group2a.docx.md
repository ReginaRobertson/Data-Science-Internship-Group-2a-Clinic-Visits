**Week 6 — Make it readable**

**Group 2a**  ·  Clinic visits  ·  start this in the breakout, finish it during the week

| Group | group2a |
| :---- | :---- |
| **Phase lead this week** |  |
| **Who is here for the breakout** |  |
| **Testing with** | group4a |
| **Date completed** | 30th October, 2026 |

| Your question Which departments have the longest patient wait times, and how does that vary by visit type and over time? |
| :---- |

**How to use this one document**

This is the only week 6 file. There is no separate breakout sheet.

**Part A** is the half hour in the breakout. It needs other people in the room, so it cannot be done alone later.

**Part B** is the rest of the week. Keep adding to this same file and commit it when you are done.

| Do not add anything new this week. No new pages, no new measures. Week 6 is for fixing what week 5 exposed and making the result readable. Week 7 freezes the scope entirely — anything unfinished by then is not in your submission. |
| :---- |

**Part A — in the breakout**

About thirty minutes. These three things need the room.

**A1. The silent test**

You are paired with **group4a** — a different domain, so they have never seen your data.

Hand them your laptop with the dashboard open. Say nothing. Do not explain, do not point, do not apologise for anything. Watch them for ninety seconds.

*Then swap and do theirs.*

**What happened when they looked at yours**

| What did they say first, in their own words?  |
| :---- |
| **Where did they hesitate, pause, or squint? Be specific — which chart, which label.**  |
| **Did they draw any conclusion that was wrong? (This matters more than confusion.)**  |
| **What did they ask you about once the ninety seconds were up?**  |
| **Hesitation is data.** Every pause is a place where your dashboard made someone work. You will not get a clearer list of what to fix than the one you just watched. |

**A2. Turn that into a fix list**

Five minutes, as a group. Write down what you are actually going to change, in the order you will do it.

*Fix the model first, then the content, then the presentation. A group that polishes before fixing the model polishes something it then has to rebuild.*

| 1\.  |
| :---- |
| **2\.**  |
| **3\.**  |
| **4\.**  |
| **5\.**  |

**A3. The five fixes that cost nothing**

Do these now, in the breakout, while you are all together. They need no decisions and they are the cheapest marks in the programme. Put initials in the last column as you finish each one.

|  | What to do | Done by |
| :---- | :---- | :---- |
|  | Rename every visible field in plain English — wait\_minutes becomes Average Wait, and so on |  |
|  | Delete every default chart title (“Sum of wait\_minutes by department\_name” tells your stakeholder you did not look) |  |
|  | Format the numbers — currency, thousands separators, sensible decimal places |  |
|  | Sort Month by MonthNumber, so April stops coming first |  |
|  | Hide every ID column in report view, so nobody can drag one onto a chart |  |

| Anything you could not finish in the breakout, and who is picking it up:  |
| :---- |

**Part B — during the week**

Keep working in this same file. Do not start a second one.

**B1. Fix the model**

Week 5 almost certainly exposed something — a measure that will not slice by what you need, a dimension you wish you had, a relationship dropping rows.

| What the draft exposed about the model:  |
| :---- |
| **What you changed, and did the totals still match SQL afterwards?**  |

*Re-check at least one measure against the database after any model change. A relationship edit can silently change every number on the page.*

| \-- the check, again, after you changed the model SELECT round(sum(wait\_minutes), 2\) FROM group2a.visits\_clean; |
| :---- |

| Power BI says / SQL says / do they still match:  |
| :---- |

**B2. What you deleted**

Go through every page and every chart. For each one: what is it meant to say, and does it answer part of your question? If it does not, delete it. Fewer pages done well beats more pages done thinly.

| Chart / page | What it is meant to say | Keep, fix or delete |
| :---- | :---- | :---- |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

| What you deleted, and why you are comfortable losing it:  |
| :---- |

**B3. Chart choices**

**Is anything better as a number than a chart?**

A single value belongs on a card, not in a one-bar bar chart. Three or four headline figures belong in a row of cards, not a grouped bar chart.

| What you changed:  |
| :---- |

**Do you have any chart with two y-axes?**

Power BI's line-and-column combo chart is a dual axis. Where the two series cross depends only on the scales you happened to pick, so it invents a relationship that is not in the data. If you have one, replace it.

| Did you have one? What did you replace it with?  |
| :---- |

**Where is one bar the answer?**

If your dashboard answers a question, usually one is the answer. Colour that one and grey the rest. Six colours say “here are six departments”; one colour says “this is the one that matters”.

| Where did you use emphasis, and what is it pointing at?  |
| :---- |

**B4. Reading order**

People read a dashboard the way they read a page — top-left first. Answer first, evidence second, detail last.

| filters across the top headline figures          \<- the answer trend  \|  breakdown       \<- the evidence detail, only if asked for \<- the detail |
| :---- |

| Describe your layout top to bottom. If it starts with a table of detail, that is the problem:  |
| :---- |

**B5. Run the silent test again**

Once you have made the changes, find a different person — not the one from the breakout, who now knows your data.

| Who tested it, and what did they say first?  |
| :---- |
| **Did they get there faster than the first tester? Where do they still hesitate?**  |
| **You are done with week 6 when** someone who has never seen your dashboard can tell you what it says, without you narrating it, and without reaching a wrong conclusion. |

**B6. Your next steps list**

Every idea you are deliberately not building. Judges ask what you would do next, and a thought-out answer shows you understood the problem rather than that you ran out of time.

| What we would do with another month:  |
| :---- |

**B7. Ready for week 7?**

Week 7 freezes the scope. No new pages, no new measures, no new ideas — just polish, documentation and rehearsal.

| Anything still unfinished that must land before Monday:  |
| :---- |
| **Who is leading the presentation phase, and who speaks about what?**  |

**B8. Questions for the weekly call**

|   |
| :---- |

| Before you submit this Part A filled in from the breakout. Model fixes checked against SQL. Deletions recorded. Dual-axis charts gone. A next steps list started. The .pbix committed to dashboard/ with this document. Design approaches can be discussed openly with group2b. Your dashboard and your findings stay yours. |
| :---- |

