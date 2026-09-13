# Student Grades SQL Practice — Questions (Q1–Q30)

A 30-question practice set built around a compact "Student Grades"
database (4 tables: `teachers`, `students`, `courses`, `enrollments`),
progressing from basic `SELECT`/`INSERT`/`UPDATE` statements through
joins, subqueries and views, up to CTEs, window functions, and
multi-step business logic.

> Table/column names are used exactly as created (`student_grades`,
> `teachers`, `students`, `courses`, `enrollments`, all lowercase
> snake_case). `USE student_grades;` is assumed before every query.
> `enrollments` is the central table — it links a student, a course,
> and a semester, and carries that student's `marks_obtained` and
> `attendance_percentage` for that course.

## ⚠️ Important: solve strictly in order (Basic section only)

This is **not** a bag of independent queries for the Basic section — it's
a single running database. **Q4, Q5, Q6, and Q7** permanently change the
data (insert a student, grade a previously-ungraded enrollment, delete
an enrollment, add a column), and every later question (Q8 onward)
reflects that changed state. From Q11 onward no question changes the
data, so the Intermediate and Advanced sections are read-only queries
against the state left behind after Q7.

---

## BASIC (Q1–Q10)

**Q1.** List the student name and city of all students from "Pune".

**Q2.** List all course names and their credits, ordered from highest credits to lowest (ties broken alphabetically by course name).

**Q3.** List the enrollment ID, student ID, course ID, and marks obtained for all enrollments in the `'Fall2024'` semester.

**Q4.** Insert a new student: `Ayesha Khan`, gender `F`, date_of_birth `2004-03-12`, enrollment_date `2023-07-01`, city `Nagpur`.

**Q5.** A previously-ungraded enrollment (`enrollment_id = 67`, for student_id 3 in course_id 6, `Fall2024`) has just been graded. Update its `marks_obtained` to `74.5`.

**Q6.** Delete the enrollment record with `enrollment_id = 50` (the student dropped that course).

**Q7.** Add a new column `email` (VARCHAR(100), nullable) to the `students` table.

**Q8.** Find the number of students in each city (city + student count).

**Q9.** Find all students who enrolled after the year 2022 (use a date/year function on `enrollment_date`), ordered by enrollment date.

**Q10.** Find all distinct departments that exist in the `courses` table.

---

## INTERMEDIATE (Q11–Q20)

**Q11.** Using an INNER JOIN, list every enrollment's student_name, course_name, and marks_obtained.

**Q12.** Using a LEFT JOIN, find every student who has never enrolled in any course.

**Q13.** Using a SELF JOIN on `students`, list every unique pair of students who were born in the same year (student_1, student_2, birth_year).

**Q14.** Using JOIN + GROUP BY, find how many students are enrolled in each course (course_name + students_enrolled), ordered from most enrolled to least.

**Q15.** Using a CASE expression, classify every graded enrollment into a letter grade (`'A'` ≥ 90, `'B'` ≥ 75, `'C'` ≥ 60, `'D'` ≥ 40, else `'F'`), then show only the enrollments that earned an `'F'` (student_name, course_name, marks_obtained, grade_letter), ordered by marks ascending.

**Q16.** Using GROUP BY and HAVING, find the departments where the average marks (across all graded enrollments in that department) exceed 75.

**Q17.** Using UNION, produce one combined, deduplicated list of the names of all female students and all students from "Delhi".

**Q18.** Using a subquery, find the student name, course name, and marks for every graded enrollment scoring above the average marks across all enrollments, ordered by marks descending.

**Q19.** Create a VIEW called `student_performance` showing student_id, student_name, total_courses, and average_marks for every student (students with zero enrollments should show `0` courses and a `NULL` average, not be excluded). Then query it, ordered by average_marks descending.

**Q20.** Create an INDEX called `idx_student_id` on `enrollments(student_id)`.

---

## ADVANCED (Q21–Q30)

**Q21.** Using a correlated subquery, find the top-scoring student in each course (course_name, student_name, marks_obtained).

**Q22.** Using multiple JOINs, list student_name, course_name, teacher_name, and marks_obtained for every enrollment in the "Computer Science" department, ordered by course_name then marks descending.

**Q23.** Using UNION ALL, combine (a) all enrollments with marks_obtained ≥ 90 and (b) all enrollments with attendance_percentage < 50 — duplicates allowed. Show student_name, course_name, marks_obtained, attendance_percentage.

**Q24.** Using JOIN + GROUP BY + HAVING, find students whose average marks (across their graded enrollments) exceed 85 — show student_id, student_name, avg_marks.

**Q25.** Using a subquery with MAX(), find the course(s) with the single highest average marks across all graded enrollments.

**Q26.** Using a CTE that computes each student's average marks (only counting students with at least 2 graded enrollments), list the top 3 students by average marks (student_id, student_name, num_courses, avg_marks).

**Q27.** Using a window function (`RANK`), rank students within each course by marks obtained, from highest to lowest — show course_name, student_name, marks_obtained, and student_rank.

**Q28.** Using a window function, show every graded enrollment for every student in true chronological order by semester (`Fall2023` → `Spring2024` → `Fall2024`), along with a running average of that student's marks over time — show student_id, student_name, semester, course_name, marks_obtained, and running_avg_marks.

**Q29.** Using a CTE combined with a window function (`DENSE_RANK`), find the student with the second-highest overall average marks, considering only students with at least 2 graded enrollments.

**Q30.** Using a CTE, a window function (`NTILE`), and a CASE expression together, classify every student as `'Honors'` (top 20% by average marks, among graded students), `'Needs Improvement'` (average marks under 50), `'Satisfactory'` (everyone else with grades), or `'Not Graded'` (students with no graded enrollments at all). Show student_id, student_name, avg_marks, and classification, ordered by avg_marks descending.
