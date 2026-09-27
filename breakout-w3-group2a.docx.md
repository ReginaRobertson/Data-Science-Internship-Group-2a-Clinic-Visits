**Week 3 breakout — get everyone connected**

**Group 2a**  ·  Clinic visits  ·  30 minutes

| Group | group2a |
| :---- | :---- |
| **Date** |  |
| **Who is here** |  |
| **Who is reporting back** |  |

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

| Name — connected? (one line per person, everybody listed)  |
| :---- |

**If somebody cannot connect**

Work through these in order before asking for help. Nine times in ten it is the first or second one.

| 1\. Password typed, not pasted? Pasting from chat often adds an invisible space.  |
| :---- |
| **2\. Username is group2a — lowercase, no spaces?**  |
| **3\. Did section 1 finish before you ran section 2? Wait for the green tick.**  |
| **4\. Still stuck — what is the exact error text?**  |

**Part B — Check it against week 2**

| 2 | Do the numbers match what you found? | 6 min |
| :---: | :---- | ----: |

Section 2 prints the shape of each table. Section 3 records your starting numbers. Compare them with your week 2 notes.

| before \= {     'rows':       len(df),     'duplicates': len(df) \- df\['visit\_id'\].nunique(),     'missing':    df.isna().sum().sum(),     'categories': df\['visit\_type'\].nunique(), } before |
| :---- |
| **Rows / duplicates / missing / categories:**  |
| **Does every number match your week 2 data quality notes? If not, which one is different and why?**  |

**Part C — Your first real fix**

| 3 | Clean the messy categories together | 8 min |
| :---: | :---- | ----: |

Run section 5\. Watch what happens to visit\_type.

| df\['visit\_type'\].value\_counts(dropna=False)     \# before df\['visit\_type'\] \= df\['visit\_type'\].str.strip().str.title() df\['visit\_type'\].value\_counts(dropna=False)     \# after |
| :---- |
| **How many values before, and how many after?**  |
| **If you had built a dashboard without doing this, what would have gone wrong with your totals?**  |

**Part D — Talk about the decisions**

No code for these. Ten minutes. Sections 7, 8 and 9 of the notebook each ask you to choose, and there is no single right answer. Start deciding now so you are not guessing alone at midnight.

**Impossible values — you have negative wait times in your data**

Drop those rows · set the value to NULL · fix an obvious sign error

| Which, and why?  |
| :---- |

**Orphan keys — roughly 62 rows point at records that do not exist**

Drop them · keep them, pointing at an "Unknown" record

| Which, and why?  |
| :---- |

**Missing values**

Leave as NULL · fill with a label like "Unknown" · drop the row

| Which, and why? You may want a different answer per column.  |
| :---- |

**Ambiguous dates — 03/04/2025 could be 3 April or 4 March**

| Which reading are you taking, and what made you decide?  |
| :---- |

**Report back to the class**

Ninety seconds. Pick someone who has not spoken yet.

| 1\. How many of us are connected:  |
| :---- |
| **2\. Our category count, before and after:**  |
| **3\. One decision we are still arguing about:**  |

| Before you leave the breakout Everybody connected. Anyone who is not — say so now, not on Thursday. Save your notebook: File \> Save a copy in GitHub, or download the .ipynb and commit it to notebooks/. Your password is not in it — keep it that way. |
| :---- |

