# Company Project Tracker SQL Practice (Q1–Q30)

A set of 30 SQL practice problems built around a small "Company Project
Tracker" database, progressing from basic `SELECT`/`INSERT`/`UPDATE`
statements through joins and subqueries to views, indexes, transactions,
stored procedures, and triggers.

## Contents

| File | Description |
|---|---|
| `questions (1).md` | All 30 questions in plain English, grouped by difficulty (Basic → Intermediate → Advanced). |
| `queries.md` | The reference SQL solution for each question. |
| `expected_answers.md` | The actual result set produced by running every query, in order, against a fresh MariaDB 10.11 database — including row counts and table snapshots after data-changing statements. |
| `QUESTION_ANSWERS.sql` | A separate solution attempt. Not fully aligned with `queries.md` / `expected_answers.md` — see note below. |
| `departments.sql`, `employees.sql`, `projects.sql`, `employee_projects.sql` | Base setup scripts that create the database and load starting data. |

> Table/column names are used exactly as created (`COMPANY_TRACKER`,
> `DEPARTMENTS`, `EMPLOYEES`, `PROJECTS`, `EMPLOYEE_PROJECTS`, all
> uppercase). `USE COMPANY_TRACKER;` is assumed before every query. For
> `CREATE PROCEDURE` / `CREATE TRIGGER` blocks, remember to switch the
> client delimiter (e.g. `DELIMITER //`) so semicolons inside the
> routine body don't end the statement early.

## Schema

- **DEPARTMENTS** — dept_id, dept_name, location, total_projects
- **EMPLOYEES** — emp_id, emp_name, dept_id, designation, salary,
  date_of_joining (plus `email`, added in Q7)
- **PROJECTS** — project_id, project_name, dept_id, budget, start_date,
  end_date
- **EMPLOYEE_PROJECTS** — assignment_id, emp_id, project_id, hours_worked

## Topics covered

**Basic (Q1–Q10)** — `SELECT`/`WHERE`/`ORDER BY`, `INSERT`, `UPDATE`,
`DELETE`, `ALTER TABLE`, `GROUP BY`, date functions, `DISTINCT`.

**Intermediate (Q11–Q20)** — `INNER`/`LEFT JOIN`, self-joins, `GROUP BY`
+ `HAVING`, `UNION`, scalar subqueries, `VIEW`s, `INDEX`es.

**Advanced (Q21–Q30)** — correlated subqueries, multi-table joins,
`UNION ALL`, nested subqueries for max-per-group, `TRANSACTION`s
(`COMMIT`/`ROLLBACK`), `STORED PROCEDURE`s, and `TRIGGER`s.

## ⚠️ Important: solve strictly in order

This is **not** a bag of independent queries — it's a single running
database. The following questions **permanently change the data or
schema**, and every later question reflects that changed state:

- Q4 — inserts a new employee (Aakash Iyer)
- Q5 — updates Priya Nair's salary
- Q6 — deletes an employee_projects row
- Q7 — adds the `EMAIL` column to `EMPLOYEES`
- Q26 — moves Rahul Mehta from Engineering to Marketing (his hours move
  with him in Q30)
- Q28 — creates a trigger and inserts a new project, bumping
  `DEPARTMENTS.TOTAL_PROJECTS`
- Q29 — creates a procedure that inserts another project, relying on
  the Q28 trigger

If you run the queries out of order, or skip a data-changing step, your
results will diverge from `expected_answers.md`.

## How to use this

1. Load the four base setup files, in order:
   `departments.sql` → `employees.sql` → `projects.sql` →
   `employee_projects.sql`, into a fresh MySQL/MariaDB-compatible
   database. `departments.sql` also creates and switches into the
   `COMPANY_TRACKER` database.
2. Work through `questions (1).md` in order (Q1 → Q30), writing your
   own query for each before checking it against `queries.md`.
3. Compare your output to the corresponding section in
   `expected_answers.md` to confirm correctness.
4. Treat `QUESTION_ANSWERS.sql` as a second attempt to check yourself
   against — not as a guaranteed match for `expected_answers.md`. A few
   of its queries select different columns, skip an `ORDER BY`, or (in
   Q19) miss a `COALESCE`, so its raw output won't always line up
   with the documented expected result even when the underlying logic
   is reasonable.

## Notable milestones

- **Q19** creates the `employee_stats` view (total hours + project
  count per employee).
- **Q20** creates an index on `EMPLOYEES(DEPT_ID)`.
- **Q26** is a full transaction walkthrough (`START TRANSACTION` →
  `UPDATE` → verify → `COMMIT`), with a written explanation of what
  `ROLLBACK` would have done instead.
- **Q27** creates the `GetEmployeeProjects` stored procedure.
- **Q28** creates the `trg_update_dept_projects` trigger, which
  auto-increments a department's `total_projects` whenever a matching
  row is inserted into `PROJECTS`.
- **Q29** creates the `AddProject` procedure, which inserts a project
  inside a transaction and relies on the Q28 trigger to keep
  `total_projects` in sync automatically.
- By Q30, department-level top performers are: Neha Sharma
  (Engineering), Rahul Mehta (Marketing, after his Q26 transfer), Amit
  Bhatia (HR), Divya Reddy (Sales).