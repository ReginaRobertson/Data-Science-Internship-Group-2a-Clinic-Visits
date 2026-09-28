**Week 3 breakout — get everyone connected**

**Group 2a**  ·  Clinic visits  ·  30 minutes

| Group | group2a |
| :---- | :---- |
| **Date** |  |
| **Who is here** |  |
| **Who is reporting back** | Regina Robertson |

| The one thing that must happen today Every single person in this group connects to the database from their own Colab notebook. Not one person while the rest watch. If somebody cannot connect by the end of this session, we fix it before you leave. |
| :---- |

**Open your notebook first**

Everyone: go to colab.research.google.com, then File \> Upload notebook, and upload week3-cleaning-group2a.ipynb from your group files. You each work in your own copy.

*You will not finish the notebook today. You are getting through section 5\.*

**Part A — Everyone connects**

| 1 | Run sections 1 and 2 | 10 min |
| :---: | :---- | ----: |

Section 1 installs the libraries and asks for your password. Section 2 loads the four tables.

*The password is the same one you use in DBeaver. getpass hides it as you type — that is deliberate, so it never gets saved into the file.*

| \# the check at the end of section 1 should return: 25,100 |
| :---- |

**Tick off every person as they get that number. This is the point of the session.**

**Name — connected? (one line per person, everybody listed)**

Regina Robertson

Bright Osei

**If somebody cannot connect**

Work through these in order before asking for help. Nine times in ten it is the first or second one.

| 1\. Password typed, not pasted? Pasting from chat often adds an invisible space.  |
| :---- |
| **2\. Username is group2a — lowercase, no spaces?** Yes |
| **3\. Did section 1 finish before you ran section 2? Wait for the green tick.** Yes |
| **4\. Still stuck — what is the exact error text?**  |

**Part B — Check it against week 2**

| 2 | Do the numbers match what you found? | 6 min |
| :---: | :---- | ----: |

Section 2 prints the shape of each table. Section 3 records your starting numbers. Compare them with your week 2 notes.

| before \= {     'rows':       len(df),     'duplicates': len(df) \- df\['visit\_id'\].nunique(),     'missing':    df.isna().sum().sum(),     'categories': df\['visit\_type'\].nunique(), } before |
| :---- |
| **Rows / duplicates / missing / categories:** 25,100 / 100 / 1,508 / 12 |
| **Does every number match your week 2 data quality notes? If not, which one is different and why?**  Yes, every number matches. Rows are 25,100, duplicates are 100 (25,100 rows against 25,000 distinct visit_ids) and missing is 1,508 (all in visit_type, the only column with NULLs at this stage). Categories are 12, the distinct spellings of visit_type as stored. |

**Part C — Your first real fix**

| 3 | Clean the messy categories together | 8 min |
| :---: | :---- | ----: |

Run section 5\. Watch what happens to visit\_type.

| df\['visit\_type'\].value\_counts(dropna=False)     \# before df\['visit\_type'\] \= df\['visit\_type'\].str.strip().str.title() df\['visit\_type'\].value\_counts(dropna=False)     \# after |
| :---- |
| **How many values before, and how many after?**  Before was 12 distinct spellings of visit_type (13 groups when the blank rows are counted). After, only 3 real categories existed, thus, Outpatient, Follow-Up and Emergency (4 groups when the blank rows are counted).|
| **If you had built a dashboard without doing this, what would have gone wrong with your totals?**  Each real category would have been split across several bars. For example, Outpatient's 12,895 visits would have shown as four separate bars (11,364, 523, 513 and 495), so no bar would show the true total and someone reading the chart would think Outpatient was far smaller than it is. Emergency (3,628 visits) would have been split into four bars in the same way. |

**Part D — Talk about the decisions**

No code for these. Ten minutes. Sections 7, 8 and 9 of the notebook each ask you to choose, and there is no single right answer. Start deciding now so you are not guessing alone at midnight.

**Impossible values — you have negative wait times in your data**

Drop those rows · set the value to NULL · fix an obvious sign error

**Which, and why?**  
We set the values to NULL. We checked for a pattern and found none: the negatives are spread across all 8 departments, nearly every month and all three visit types. With no evidence of what the true values were, we can't justify flipping the sign and dropping the rows would lose valid department, visit type and date information. 
| :---- |

**Orphan keys — roughly 62 rows point at records that do not exist**

Drop them · keep them, pointing at an "Unknown" record

**Which, and why?**
We kept them, pointing at an "Unknown" patient record. Our question is about departments, visit type and wait times and these 62 visits still have valid values for all three. Dropping them would remove real visits from every total.
| :---- |

**Missing values**

Leave as NULL · fill with a label like "Unknown" · drop the row

**Which, and why? You may want a different answer per column.**
We chose different answers per column. visit_type was filled with "Unknown", because it is a category we group by and the wait times were still valid. wait_minutes was left as NULL, because we can't know the true wait and filling it would invent data
| :---- |

**Ambiguous dates — 03/04/2025 could be 3 April or 4 March**

**Which reading are you taking, and what made you decide?** 
We took the day first (DD/MM/YYYY). Slash dates such as 29/07/2024 and 26/07/2025 have a first number above 12, so that number can only be the day and we applied the same reading to every slash date.
| :---- |

**Report back to the class**

Ninety seconds. Pick someone who has not spoken yet.

| 1\. How many of us are connected:  |
| :---- |
| **2\. Our category count, before and after:**  12 before, 3 after (Outpatient, Follow-Up, Emergency). |
| **3\. One decision we are still arguing about:**  should the 1,500 "Unknown" visit_type rows appear in the department wait-time charts? Including them keeps valid waits but they can't be split by visit type. |

| Before you leave the breakout Everybody connected. Anyone who is not — say so now, not on Thursday. Save your notebook: File \> Save a copy in GitHub, or download the .ipynb and commit it to notebooks/. Your password is not in it — keep it that way. |
| :---- |

