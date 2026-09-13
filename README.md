# SQL Practice Repository

This repository contains **three independent SQL practice sets**. They use
different databases and different data, and don't depend on each other in
any way. You can do them in any order, or just one of them.

| Practice Set | Database | Questions | Focus |
|---|---|---|---|
| [Cricket League](#1-cricket-league-sql-practice-q1q60) | `CRICKET_LEAGUE` | Q1–Q60 | Teams, players, matches, performances |
| [Company Project Tracker](#2-company-project-tracker-sql-practice-q1q30) | `COMPANY_TRACKER` | Q1–Q30 | Departments, employees, projects, assignments |
| [Student Grades](#3-student-grades-sql-practice-q1q30) | `student_grades` | Q1–Q30 | Teachers, students, courses, enrollments |

Both sets follow the same format:
- A `questions` file with the plain-English problem statements.
- A `queries`/`query` file with reference SQL solutions.
- An `expected_answers` file showing the actual output of running every
  query, in order, on a fresh database.
- Base setup `.sql` files to load the starting schema and data.

Both sets are **sequential, not independent** — several questions in each
set permanently change the underlying data or schema, so every later
question depends on the changes made earlier. Skipping a step or running
questions out of order will make your results diverge from the documented
expected answers. Details for each set are below.

---

## 1. Cricket League SQL Practice (Q1–Q60)

Built around a `TEAMS` / `PLAYERS` / `MATCHES` / `PERFORMANCES` schema.
Progresses from basic `SELECT`/`INSERT`/`UPDATE` through joins and
subqueries to stored procedures, triggers, and transactions.

**Files:** `questions.md`, `query.md`, `expected_answers.md`, plus base
setup files (`teams_table.sql`, `players_table.sql`, `matches_table.sql`,
`performances_table.sql`).

**Data-changing questions:** Q4–Q7, Q14–Q17 (basic), Q46, Q48, Q49, Q56,
Q58, Q59 (advanced — includes a player transfer, a trigger that
auto-updates `total_wins`, and multi-statement transactions).

**Topic breakdown:** Basic (Q1–Q20), Intermediate (Q21–Q40, includes
views and indexes), Advanced (Q41–Q60, includes correlated subqueries,
transactions, stored procedures, triggers).

Full details: see the dedicated README for this set.

---

## 2. Company Project Tracker SQL Practice (Q1–Q30)

Built around a `DEPARTMENTS` / `EMPLOYEES` / `PROJECTS` /
`EMPLOYEE_PROJECTS` schema. Same progression — basic statements through
joins, subqueries, views, indexes, transactions, stored procedures, and
triggers — compressed into 30 questions instead of 60.

**Files:** `questions (1).md`, `queries.md`, `expected_answers.md`,
`QUESTION_ANSWERS.sql`, plus base setup files (`departments.sql`,
`employees.sql`, `projects.sql`, `employee_projects.sql`).

**Data-changing questions:** Q4 (insert employee), Q5 (update salary),
Q6 (delete assignment), Q7 (add `EMAIL` column), Q26 (transfer an
employee between departments), Q28 (create trigger + insert project),
Q29 (procedure that inserts another project via the same trigger).

**Topic breakdown:** Basic (Q1–Q10), Intermediate (Q11–Q20, includes a
view and an index), Advanced (Q21–Q30, includes a transaction, two
stored procedures, and a trigger).

**Note on `QUESTION_ANSWERS.sql`:** this is a separate solution attempt,
not a verified match to `expected_answers.md`. A handful of its queries
select different columns, drop an `ORDER BY`, or (Q19) omit a
`COALESCE` that the reference solution relies on to turn `NULL` hour
totals into `0`. Use `queries.md` as the source of truth if the two
disagree.

Full details: see the dedicated README for this set.

---

## 3. Student Grades SQL Practice (Q1–Q30)

Built around a `teachers` / `students` / `courses` / `enrollments`
schema modeling a small college — who teaches what, who's enrolled in
what, and how they scored. Progresses from basic filtering through
joins, subqueries, views, indexes, CTEs, and window functions
(`RANK`, `DENSE_RANK`, `NTILE`, running averages).

**Files:** `schema.sql` (structure only), `teachers.sql`,
`students.sql`, `courses.sql`, `enrollments.sql` (data), `questions.sql`
(questions + solving queries as SQL comments), `questions.md`,
`queries.md`, `expected_answers.md`.

**Data-changing questions:** Q4 (insert student), Q5 (grade an
ungraded enrollment), Q6 (delete an enrollment), Q7 (add a column) —
all in the Basic section. Q11 onward is read-only and
order-independent.

**Topic breakdown:** Basic (Q1–Q10), Intermediate (Q11–Q20, joins,
`CASE`, `HAVING`, `UNION`, subqueries, views, indexes), Advanced
(Q21–Q30, correlated subqueries, `UNION ALL`, CTEs, window functions).

**Built-in edge cases** (deliberately present in the data, useful for
testing NULL/empty-set handling):
- A teacher with zero courses assigned (Dr. Alok Verma)
- Two students with zero enrollments (Om Prakash from the start;
  Ayesha Khan after the Q4 insert)
- An enrollment with `marks_obtained = NULL` until it's graded in Q5
- A low-attendance/high-marks anomaly (42% attendance, 95 marks)
- A student who retook a course and improved (Reyansh Gupta — Data
  Structures, 80 then 95)
- A failing student with multiple sub-40 scores
- Semesters stored as `'Fall2023'`, `'Spring2024'`, `'Fall2024'` —
  **not** in chronological order alphabetically, which matters for any
  "order by semester chronologically" question

Full details: see the dedicated README for this set.

---

## Setup order (per set)

**Cricket League:**
`teams_table.sql` → `players_table.sql` → `matches_table.sql` →
`performances_table.sql` → `USE CRICKET_LEAGUE;` → work through
`questions.md` Q1→Q60.

**Company Project Tracker:**
`departments.sql` → `employees.sql` → `projects.sql` →
`employee_projects.sql` (database and `USE COMPANY_TRACKER;` are set up
by `departments.sql`) → work through `questions (1).md` Q1→Q30.

**Student Grades:**
`schema.sql` → `teachers.sql` → `students.sql` → `courses.sql` →
`enrollments.sql` → work through `questions.md` / `questions.sql`,
solving Q1–Q7 in order (Q4–Q7 change the data); Q8 onward can be done
in any order.