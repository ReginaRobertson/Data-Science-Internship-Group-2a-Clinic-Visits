# Data-Science-Internship-Group-2a-Clinic-Visits

Data Science & Analytics Internship · 8-week project

## Introduction

This project is part of an 8-week Data Science & Analytics internship, where two groups independently analyze the same dataset and answer the same question, so their approaches can be compared at the end.

Our group, **Group2a**, has been assigned the **Clinic Visits** dataset from a clinic with eight departments. The clinic has been getting complaints about wait times, but staff disagree on which departments are actually the worst offenders, nobody has looked at the data to settle it. Our job is to do that: analyze roughly 25,100 patient visit records to find out **which departments have the longest wait times and how that varies by visit type and over time.**

The final output is a Power BI dashboard built on a proper data model (not a flat spreadsheet dump), designed for the clinic administrator; someone who isn't a data analyst to read and understand on their own, without us there to explain it.

Over the eight weeks, we move from scoping the question, to profiling and cleaning the raw data, to building a data model, to designing and refining the dashboard, ending with a final presentation of what we found.

## The situation

A clinic with eight departments is getting complaints about waiting. Staff opinions on which departments are worst disagree and the visit records have never been analyzed. This project uses those records to answer the question with data, for an audience, the clinic administrator is someone who is not an analyst and needs the answer to make sense without anyone explaining it.

## The data

| Table | Rows | Contents |
|---|---|---|
| `visits` | 25,100 | Fact table — one row per visit: date, patient, doctor, department, visit type, wait minutes, fee |
| `patients` | 900 | Birth year, sex, region, insurance scheme |
| `doctors` | 40 | Name, department, years of experience |
| `departments` | 8 | Department name, floor |

Source: PostgreSQL, read from the `raw_clinic` schema (read-only). Our own work is written to the `group2a` schema. There is no date table in the source — we build one ourselves in week 4.

The raw data has known issues — missing values, duplicates, inconsistent category spellings, dates in multiple formats and some impossible values. These are catalogued in `data_quality_notes.md`.

## Repository structure

```
group2a-clinic-visits/
  README.md                 this file
  scope.md                  week 1 — our question and scope
  breakout-week1.md         week 1 — breakout session notes
  sql/                      our queries (profiling, exploration)
  notebooks/                our Colab cleaning work
  data_quality_notes.md     week 2 — what we found wrong with the data
  dashboard/                our .pbix file
  presentation/             week 8 slides
```

## How to run this

1. **Database access:** connect to the PostgreSQL instance at `internship-db.coh86gwewtxb.us-east-1.rds.amazonaws.com:5432`, database `internship`, using the `group2a` credentials (password held by the group lead). SSL required. Read from `raw_clinic`, write to `group2a`.
2. **SQL:** the queries in `sql/` can be run in any PostgreSQL client (we use DBeaver).
3. **Cleaning:** the notebook(s) in `notebooks/` run in Google Colab and read from `raw_clinic`, writing cleaned tables to the `group2a` schema.
4. **Dashboard:** open the `.pbix` file in `dashboard/` with Power BI Desktop. It connects to the cleaned tables in `group2a`.

## Project timeline

| Week | Phase | Deliverable |
|---|---|---|
| 1 | Scope | `scope.md`, breakout notes |
| 2 | Profile the data (SQL) | `data_quality_notes.md` |
| 3 | Clean the data (Python) | Cleaning notebook + cleaned tables in `group2a` |
| 4 | Build the model (Power BI) | Star schema, relationships set, no visuals yet |
| 5 | Measures & first dashboard draft | Rough dashboard, measures working |
| 6 | Iterate | Revised dashboard |
| 7 | Freeze & rehearse | Documentation complete, presentation rehearsed (scope frozen) |
| 8 | Submit & present | Final dashboard, repo, ten-minute demo |

## Notes

- This dataset is shared with group2b, who are answering the same question independently. Data quality findings are shared openly between groups; analysis and conclusions are not.
- Never committed to this repo: passwords, connection strings, or large raw data files.
