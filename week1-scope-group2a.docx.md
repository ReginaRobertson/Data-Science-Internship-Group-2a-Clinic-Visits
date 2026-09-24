**Week 1 — Scope note**

**Group 2a**  ·  Clinic visits  ·  due before your first weekly call

| Group | group2a |
| :---- | :---- |
| **Date agreed** |17th September,2026, 24th September, 2026|
| **Who was in the discussion** |  |
| **Phase lead for week 1** | Margaret Isliker, Regina Robertson|

| The question you were given Which departments have the longest patient wait times, and how does that vary by visit type and over time? |
| :---- |

**Before you start**

Budget about an hour as a group. Do this before you write any queries. The point is that everyone leaves agreeing on the same thing.

Type into the grey boxes. The lines with a green bar beside them are guidance — read them, then ignore them; they are not part of your answer.

Have your tables open in DBeaver while you talk. Not to analyse anything, just to see what columns exist. It makes the conversation concrete.

**1\. The situation**

A clinic with eight departments is getting complaints about waiting. Staff have opinions about which departments are worst, but the opinions disagree. The visit records have never been analysed.

Your audience is **the clinic administrator**. They are not an analyst. Whatever you build has to make sense to them without you standing next to it explaining.

**2\. What we think the question is actually asking**

| *Staff believe they already know which departments are the worst for waiting, but those opinions contradict each other, thus, nobody has actually checked. We're using the real visit records to find out, objectively, which departments genuinely have the longest waits, whether that changes depending on the type of visit (Outpatient, Follow-up, Emergency) and whether it's been getting better or worse across the two years the data covers. If the data disagrees with what staff currently believe, that's the finding that changes minds.* |
| :---- |
|   |

**3\. Our sub-questions**

| *The main question is too big for one chart. Break it into three to five smaller ones, each answerable by a single chart. These become your dashboard pages in week 6, so time spent here saves rework later.* |
| :---- |
| *Specific enough to be answerable. Not "look at wait time" but something like: Which three departments have the longest average wait, and is the gap widening or narrowing across 2024 and 2025?* |


| *Our sub-questions*:  |
| :---- |

1\. Which departments have the longest average and median wait and how big is the gap between the best and worst?

2\. Do emergency visits wait less than routine (Outpatient/Follow-up) visits, as they should, in every department or only some?

3\. Are wait times getting better, worse or staying flat across 2024–2025, department by department?

4\. Within the worst-performing departments, is one visit type driving the problem or is it bad across the board?

5\. Is the "worst three" ranking stable month to month or does it shift (e.g. seasonal spikes)?* 


**4\. Who this is for, and what they would do with it**

| *What decision would the clinic administrator make differently if they had your answer? If you cannot name a decision, the dashboard will end up as decoration — and charts nobody acts on score badly however pretty they are.* |
| :---- |
| **The decision they would make:**  |

**5\. What "done" looks like**

| *Describe the finished dashboard in plain sentences, before building anything. What can someone see? What can they filter by? What could they say after ten seconds of looking?* |
| :---- |
| **Our dashboard will let the clinic administrator:**  |

**6\. What is out of scope**

| *This section saves you in week 6, when someone has a good idea that would take three weeks. Write down what you are deliberately not doing, so you can point at it.* |
| :---- |
| *Worth excluding for your domain: Diagnosing why waits are long — you can show where, not why. Staffing recommendations.* |
| **We are NOT:**  |

**7\. Our data**

| Schema we read | raw\_clinic |
| :---- | :---- |
| **Schema we write to** | group2a |
| **Fact table** | visits |
| **All four tables** | visits (25,100) · patients (900) · doctors (40) · departments (8) |

| *One or two lines each. Anything that already looks odd, any column you do not understand, anything you expected to find and did not.* |
| :---- |
| **First impressions from looking at the tables:**  |
| **Questions we have about the data — bring these to the call:**  |

**8\. Who leads which phase**

| *A different person leads each phase. The lead is not the only one working — they are the person who makes sure it happens and who speaks for the group on that week's call. Encourage the least confident people to take an early phase.* |  |  |
| :---- | :---- | :---- |
| **Phase** | **Weeks** | **Lead** |
| **Scope** | 1 |  |
| **SQL profiling** | 2 |  |
| **Python cleaning** | 3 |  |
| **Data modelling** | 4 |  |
| **Dashboard build** | 5–6 |  |
| **Presentation** | 7–8 |  |

| How we communicate:  |
| :---- |
| **When we meet as a group:**  |

**9\. Risks we can already see**

| *Being honest here is worth more than looking confident. Every group has these.* |  |
| :---- | :---- |
| **Risk** | **What we will do about it** |
| Not everyone is available at the same times  |   |
| Most of us are new to Power BI  |   |
|   |   |
|   |   |

**Sign-off**

| *Everyone types their own name. If you have not read this document, do not add your name to it — the point is that the whole group agrees, not that the form is filled in.* |
| :---- |
| Regina Robetson  |

| Done when Every member of group2a could explain this project to a stranger in two sentences, without looking at this file. Next: week 2 — open week2\_profiling\_clinic.sql and work through it from the top. Do not skip to the interesting queries. |
| :---- |

