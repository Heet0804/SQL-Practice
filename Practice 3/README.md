# Student Grades — SQL Practice Project

A 4-table practice database built around a small college's student
records: who's enrolled in what course, taught by which teacher, and
how they scored. Designed to progress from basic `SELECT` statements
up through joins, subqueries, views, CTEs, and window functions.

## Files in this project

| File | Purpose |
|---|---|
| `schema.sql` | Creates the database and all 4 tables (structure only, no data) |
| `teachers.sql` | Data for the `teachers` table |
| `students.sql` | Data for the `students` table |
| `courses.sql` | Data for the `courses` table |
| `enrollments.sql` | Data for the `enrollments` table |
| `questions.sql` | All 30 questions as SQL comments, each followed by its solving query |
| `questions.md` | The 30 questions, organized into Basic / Intermediate / Advanced |
| `queries.md` | The correct SQL query for every question |
| `expected_answers.md` | The verified output for every question |

## Setup

Run the files in this order:

```sql
SOURCE schema.sql;
SOURCE teachers.sql;
SOURCE students.sql;
SOURCE courses.sql;
SOURCE enrollments.sql;
```

After that, `student_grades` is a fully populated database ready for
the questions in `questions.md` / `questions.sql`.

## Schema overview

**`teachers`** (7 rows) — `teacher_id`, `teacher_name`, `department`, `hire_date`
One teacher (Dr. Alok Verma, Biology) is deliberately assigned to zero
courses — an edge case for LEFT JOIN practice.

**`students`** (25 rows, 26 after Q4 inserts one) — `student_id`,
`student_name`, `gender`, `date_of_birth`, `enrollment_date`, `city`
One student (Om Prakash) has zero enrollments from the start; the
student inserted in Q4 (Ayesha Khan) also has none — both are edge
cases for LEFT JOIN / "students with no activity" questions.

**`courses`** (10 rows) — `course_id`, `course_name`, `department`,
`credits`, `teacher_id` (FK → `teachers`)
Spans 5 departments (Mathematics, Physics, Computer Science,
Chemistry, English), 2–4 credits each.

**`enrollments`** (73 rows, adjusted by Q5/Q6) — `enrollment_id`,
`student_id` (FK), `course_id` (FK), `semester`, `marks_obtained`,
`attendance_percentage`
The central fact table — one row per student-course-semester
combination. Semesters are `'Fall2023'`, `'Spring2024'`, `'Fall2024'`
(note: **not** alphabetical chronological order — Spring2024 falls
between the two Fall semesters, which matters for any "in chronological
order" question).

### Relationships

```
teachers (1) ──< courses (many)
students (1) ──< enrollments (many) >── (1) courses
```

### Built-in edge cases (useful for testing NULL/empty-set handling)

- A teacher with no courses assigned
- A student with no enrollments at all (before any inserts)
- An enrollment with `marks_obtained = NULL` (not yet graded) — this
  is graded in Q5
- A low-attendance-but-high-marks anomaly (attendance 42%, marks 95)
- A student who retook a course in a later semester (Reyansh Gupta —
  Data Structures, scored 80 then 95)
- A failing student (multiple enrollments under 40 marks)

## How the question set is organized

30 questions, split evenly:

- **Basic (Q1–Q10)** — filtering, sorting, `INSERT`/`UPDATE`/`DELETE`/`ALTER TABLE`,
  `GROUP BY`, `DISTINCT`, date functions
- **Intermediate (Q11–Q20)** — `INNER`/`LEFT`/`SELF` joins, `CASE`
  expressions, `HAVING`, `UNION`, subqueries, `VIEW`s, indexes
- **Advanced (Q21–Q30)** — correlated subqueries, `UNION ALL`, CTEs,
  window functions (`RANK`, `DENSE_RANK`, `NTILE`, running averages)
  combined with `CASE` expressions for multi-step business logic

**Important:** Q4–Q7 in the Basic section permanently modify the data
(insert a student, grade an enrollment, delete an enrollment, add a
column). Every question from Q8 onward assumes those changes have
already happened — solve the Basic section in order. Q11 onward is
read-only and order-independent.

## Verification

Every query in `queries.md` / `questions.sql` was run against the
actual generated data and cross-checked against `expected_answers.md`
— schema, data, questions, queries, and expected answers are all
mutually consistent.