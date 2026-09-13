# Student Grades SQL Practice — Expected Answers (Q1–Q30)

These outputs were produced by actually loading the base data files into
a fresh database and running every query below, in order, so each answer
in the Basic section reflects the cumulative effect of every data-changing
question before it (Q4–Q7). Q11 onward is read-only and does not change
between runs.

---

## BASIC

**Q1.** Students from Pune.

| student_name | city |
|---|---|
| Aarav Shah | Pune |
| Ira Desai | Pune |
| Kabir Tiwari | Pune |
| Saanvi Menon | Pune |
| Sara Khan | Pune |

**Q2.** Courses by credits, highest first.

| course_name | credits |
|---|---|
| Algorithms | 4 |
| Calculus I | 4 |
| Data Structures | 4 |
| Physics I | 4 |
| Physics II | 4 |
| Database Systems | 3 |
| English Literature | 3 |
| Linear Algebra | 3 |
| Organic Chemistry | 3 |
| Creative Writing | 2 |

**Q3.** Enrollments in `'Fall2024'`.

| enrollment_id | student_id | course_id | marks_obtained |
|---|---|---|---|
| 4 | 2 | 10 | 88.90 |
| 10 | 4 | 10 | 74.00 |
| 13 | 5 | 9 | 73.80 |
| 18 | 7 | 1 | 92.60 |
| 27 | 11 | 5 | 82.50 |
| 32 | 13 | 8 | 77.40 |
| 34 | 14 | 3 | 59.60 |
| 35 | 14 | 6 | 46.20 |
| 36 | 14 | 9 | 80.80 |
| 42 | 16 | 1 | 61.90 |
| 45 | 17 | 7 | 64.80 |
| 47 | 18 | 2 | 47.60 |
| 48 | 18 | 8 | 46.00 |
| 51 | 19 | 5 | 74.90 |
| 53 | 20 | 6 | 81.80 |
| 55 | 20 | 10 | 78.70 |
| 56 | 21 | 2 | 57.10 |
| 57 | 21 | 7 | 34.40 |
| 60 | 22 | 10 | 55.10 |
| 64 | 24 | 3 | 44.10 |
| 66 | 24 | 8 | 33.50 |
| 67 | 3 | 6 | **NULL** (ungraded — see Q5) |
| 71 | 2 | 5 | 91.00 |

(23 rows.)

**Q4.** Insert `Ayesha Khan` — `Query OK, 1 row affected`. Verification:

| student_id | student_name | gender | date_of_birth | enrollment_date | city |
|---|---|---|---|---|---|
| 26 | Ayesha Khan | F | 2004-03-12 | 2023-07-01 | Nagpur |

**Q5.** Grade enrollment_id 67 — `Query OK, 1 row affected`. Verification:

| enrollment_id | student_id | course_id | semester | marks_obtained |
|---|---|---|---|---|
| 67 | 3 | 6 | Fall2024 | 74.50 |

**Q6.** Delete enrollment_id 50 — `Query OK, 1 row affected`. Row deleted was `(50, 19, 1, 'Fall2023', 73.80, 72.20)` (Yuvan Bhatt's Calculus I enrollment). Verification select now returns 0 rows.

**Q7.** Add `email` column — `Query OK, 0 rows affected`. Verification: new column is NULL for all rows, e.g. `(1, 'Aarav Shah', NULL)`.

**Q8.** Students per city.

| city | student_count |
|---|---|
| Ahmedabad | 1 |
| Bangalore | 4 |
| Chennai | 3 |
| Delhi | 5 |
| Hyderabad | 2 |
| Mumbai | 5 |
| Nagpur | 1 |
| Pune | 5 |

(8 rows, 26 students total.)

**Q9.** Students who enrolled after 2022.

| student_id | student_name | enrollment_date |
|---|---|---|
| 26 | Ayesha Khan | 2023-07-01 |

(1 row — only the student inserted in Q4; everyone else enrolled in 2021 or 2022.)

**Q10.** Distinct departments.

| department |
|---|
| Chemistry |
| Computer Science |
| English |
| Mathematics |
| Physics |

---

## INTERMEDIATE

**Q11.** Every enrollment with student and course name (INNER JOIN).

72 rows total. First few and last few, alphabetically by student then course:

| student_name | course_name | marks_obtained |
|---|---|---|
| Aarav Shah | Creative Writing | 67.00 |
| Aarav Shah | Database Systems | 48.10 |
| Aarav Shah | English Literature | 62.40 |
| Aditya Rao | English Literature | 77.40 |
| Aditya Rao | Linear Algebra | 42.80 |
| ... | ... | ... |
| Yuvan Bhatt | Creative Writing | 78.60 |
| Yuvan Bhatt | Data Structures | 74.90 |
| Zara Ahmed | Algorithms | 88.40 |
| Zara Ahmed | Creative Writing | 55.10 |
| Zara Ahmed | English Literature | 62.50 |

(72 rows — note this INNER JOIN naturally excludes Om Prakash and Ayesha Khan, who have no enrollments at all.)

**Q12.** Students who have never enrolled in any course.

| student_id | student_name |
|---|---|
| 25 | Om Prakash |
| 26 | Ayesha Khan |

(Om Prakash never enrolled in anything; Ayesha Khan is the student inserted in Q4, who also has no enrollments.)

**Q13.** Unique pairs of students born in the same year.

172 rows total (35 pairs born in 2003, 137 pairs born in 2004 — 2004 is a much more common birth year in this dataset). A sample:

| student_1 | student_2 | birth_year |
|---|---|---|
| Aditya Rao | Dhruv Kapoor | 2003 |
| Aditya Rao | Kabir Tiwari | 2003 |
| Aditya Rao | Navya Pillai | 2003 |
| ... | ... | ... |
| Zara Ahmed | Ayesha Khan | 2004 |
| Zara Ahmed | Ishaan Nair | 2004 |
| Zara Ahmed | Om Prakash | 2004 |

(172 rows — 9 students were born in 2003, giving C(9,2) = 36 pairs, and 17 were born in 2004, giving C(17,2) = 136 pairs; 36 + 136 = 172.)

**Q14.** Students enrolled per course.

| course_name | students_enrolled |
|---|---|
| Creative Writing | 10 |
| Linear Algebra | 9 |
| Database Systems | 8 |
| English Literature | 8 |
| Algorithms | 7 |
| Data Structures | 7 |
| Physics I | 7 |
| Calculus I | 6 |
| Organic Chemistry | 6 |
| Physics II | 4 |

**Q15.** Enrollments graded `'F'` (marks under 40).

| student_name | course_name | marks_obtained | grade_letter |
|---|---|---|---|
| Kiara Malhotra | Calculus I | 20.20 | F |
| Dhruv Kapoor | Organic Chemistry | 28.00 | F |
| Kabir Singh | Linear Algebra | 31.20 | F |
| Dhruv Kapoor | Physics I | 32.00 | F |
| Tara Kulkarni | English Literature | 33.50 | F |
| Kabir Tiwari | Organic Chemistry | 34.40 | F |

(6 rows.)

**Q16.** Departments with average marks over 75.

| department | avg_marks |
|---|---|
| Computer Science | 75.24 |

(1 row — the only department clearing 75; note this is computed only over graded enrollments.)

**Q17.** Female students UNION Delhi students.

| student_name |
|---|
| Ananya Iyer |
| Anika Verma |
| Aryan Chopra |
| Ayesha Khan |
| Diya Patel |
| Ira Desai |
| Kabir Singh |
| Kiara Malhotra |
| Myra Nair |
| Navya Pillai |
| Reyansh Gupta |
| Riya Sharma |
| Saanvi Menon |
| Sara Khan |
| Tara Kulkarni |
| Zara Ahmed |

(16 rows — Kabir Singh, Aryan Chopra, and Reyansh Gupta are male Delhi residents; the rest are female students from anywhere.)

**Q18.** Enrollments scoring above the overall average (average = 67.34).

36 rows, topped by:

| student_name | course_name | marks_obtained |
|---|---|---|
| Vihaan Reddy | Creative Writing | 100.00 |
| Saanvi Menon | Data Structures | 100.00 |
| Ira Desai | Linear Algebra | 97.80 |
| Diya Patel | Calculus I | 96.00 |
| Reyansh Gupta | Data Structures | 95.00 |
| ... | ... | ... |
| Dhruv Kapoor | Database Systems | 70.30 |

(36 rows, ending at 70.30 — the lowest score still above the 67.34 average.)

**Q19.** `student_performance` view, queried in full.

| student_id | student_name | total_courses | average_marks |
|---|---|---|---|
| 7 | Reyansh Gupta | 4 | 85.05 |
| 2 | Diya Patel | 6 | 83.25 |
| 5 | Vihaan Reddy | 3 | 82.13 |
| 11 | Vivaan Joshi | 2 | 78.85 |
| 10 | Ira Desai | 4 | 77.65 |
| 19 | Yuvan Bhatt | 2 | 76.75 |
| 23 | Ishaan Nair | 3 | 74.40 |
| 16 | Saanvi Menon | 3 | 74.10 |
| 17 | Aryan Chopra | 2 | 73.65 |
| 6 | Sara Khan | 2 | 70.80 |
| 20 | Riya Sharma | 4 | 69.88 |
| 9 | Arjun Mehta | 2 | 69.00 |
| 22 | Zara Ahmed | 3 | 68.67 |
| 8 | Myra Nair | 2 | 68.40 |
| 12 | Anika Verma | 3 | 65.73 |
| 4 | Ananya Iyer | 2 | 64.30 |
| 3 | Kabir Singh | 3 | 60.63 |
| 13 | Aditya Rao | 2 | 60.10 |
| 1 | Aarav Shah | 3 | 59.17 |
| 18 | Navya Pillai | 3 | 52.60 |
| 14 | Kiara Malhotra | 4 | 51.70 |
| 15 | Dhruv Kapoor | 5 | 50.08 |
| 21 | Kabir Tiwari | 2 | 45.75 |
| 24 | Tara Kulkarni | 3 | 44.77 |
| 25 | Om Prakash | 0 | NULL |
| 26 | Ayesha Khan | 0 | NULL |

(26 rows — every student appears, including the two with zero enrollments, whose `average_marks` is `NULL` since `AVG()` over no rows is `NULL` and `COUNT()` correctly returns `0`.)

**Q20.** Create index `idx_student_id` — `Query OK, 0 rows affected`. The index now appears when running `SHOW INDEX FROM enrollments;`.

---

## ADVANCED

**Q21.** Top-scoring student in each course.

| course_name | student_name | marks_obtained |
|---|---|---|
| Algorithms | Ishaan Nair | 90.20 |
| Calculus I | Diya Patel | 96.00 |
| Creative Writing | Vihaan Reddy | 100.00 |
| Data Structures | Saanvi Menon | 100.00 |
| Database Systems | Diya Patel | 93.00 |
| English Literature | Aditya Rao | 77.40 |
| Linear Algebra | Ira Desai | 97.80 |
| Organic Chemistry | Arjun Mehta | 83.70 |
| Physics I | Diya Patel | 65.30 |
| Physics II | Aryan Chopra | 82.50 |

(10 rows — no ties this time, exactly one top scorer per course.)

**Q22.** Computer Science enrollments with teacher.

| student_name | course_name | teacher_name | marks_obtained |
|---|---|---|---|
| Ishaan Nair | Algorithms | Prof. Ramesh Iyer | 90.20 |
| Zara Ahmed | Algorithms | Prof. Ramesh Iyer | 88.40 |
| Riya Sharma | Algorithms | Prof. Ramesh Iyer | 81.80 |
| Kabir Singh | Algorithms | Prof. Ramesh Iyer | 74.50 |
| Anika Verma | Algorithms | Prof. Ramesh Iyer | 67.30 |
| Saanvi Menon | Algorithms | Prof. Ramesh Iyer | 60.40 |
| Kiara Malhotra | Algorithms | Prof. Ramesh Iyer | 46.20 |
| Saanvi Menon | Data Structures | Prof. Ramesh Iyer | 100.00 |
| Reyansh Gupta | Data Structures | Prof. Ramesh Iyer | 95.00 |
| Diya Patel | Data Structures | Prof. Ramesh Iyer | 91.00 |
| Vivaan Joshi | Data Structures | Prof. Ramesh Iyer | 82.50 |
| Reyansh Gupta | Data Structures | Prof. Ramesh Iyer | 80.00 |
| Yuvan Bhatt | Data Structures | Prof. Ramesh Iyer | 74.90 |
| Ishaan Nair | Data Structures | Prof. Ramesh Iyer | 62.40 |
| Diya Patel | Database Systems | Dr. Kavita Nair | 93.00 |
| Kiara Malhotra | Database Systems | Dr. Kavita Nair | 80.80 |
| Sara Khan | Database Systems | Dr. Kavita Nair | 79.40 |
| Vihaan Reddy | Database Systems | Dr. Kavita Nair | 73.80 |
| Dhruv Kapoor | Database Systems | Dr. Kavita Nair | 70.30 |
| Riya Sharma | Database Systems | Dr. Kavita Nair | 58.50 |
| Tara Kulkarni | Database Systems | Dr. Kavita Nair | 56.70 |
| Aarav Shah | Database Systems | Dr. Kavita Nair | 48.10 |

(22 rows — Reyansh Gupta appears twice under Data Structures because he retook it in a later semester (see Q28), scoring 80 the first time and 95 the second.)

**Q23.** Marks ≥ 90 UNION ALL attendance < 50.

| student_name | course_name | marks_obtained | attendance_percentage |
|---|---|---|---|
| Dhruv Kapoor | Organic Chemistry | 28.00 | 48.00 |
| Diya Patel | Calculus I | 96.00 | 95.00 |
| Diya Patel | Database Systems | 93.00 | 92.00 |
| Diya Patel | Data Structures | 91.00 | 90.00 |
| Ira Desai | Linear Algebra | 97.80 | 89.60 |
| Ishaan Nair | Algorithms | 90.20 | 69.60 |
| Reyansh Gupta | Calculus I | 92.60 | 88.80 |
| Reyansh Gupta | Data Structures | 95.00 | 42.00 |
| Reyansh Gupta | Data Structures | 95.00 | 42.00 |
| Saanvi Menon | Data Structures | 100.00 | 73.10 |
| Vihaan Reddy | Creative Writing | 100.00 | 74.00 |

(11 rows — Reyansh Gupta's 95-marks Data Structures retake appears **twice**, because that single enrollment satisfies both halves of the UNION ALL: marks ≥ 90 *and* attendance < 50. This is exactly the kind of duplicate UNION ALL is meant to preserve — a plain UNION would have collapsed it to one row.)

**Q24.** Students averaging over 85.

| student_id | student_name | avg_marks |
|---|---|---|
| 7 | Reyansh Gupta | 85.05 |

(1 row — Reyansh Gupta is the only student clearing an 85 average.)

**Q25.** Course with the highest average marks.

| course_name | avg_marks |
|---|---|
| Data Structures | 83.69 |

**Q26.** Top 3 students by average marks (≥ 2 graded courses).

| student_id | student_name | num_courses | avg_marks |
|---|---|---|---|
| 7 | Reyansh Gupta | 4 | 85.05 |
| 2 | Diya Patel | 6 | 83.25 |
| 5 | Vihaan Reddy | 3 | 82.13 |

**Q27.** Students ranked by marks within each course (`RANK`).

72 rows. A sample (Algorithms and Calculus I shown in full; the remaining 8 courses follow the same pattern):

| course_name | student_name | marks_obtained | student_rank |
|---|---|---|---|
| Algorithms | Ishaan Nair | 90.20 | 1 |
| Algorithms | Zara Ahmed | 88.40 | 2 |
| Algorithms | Riya Sharma | 81.80 | 3 |
| Algorithms | Kabir Singh | 74.50 | 4 |
| Algorithms | Anika Verma | 67.30 | 5 |
| Algorithms | Saanvi Menon | 60.40 | 6 |
| Algorithms | Kiara Malhotra | 46.20 | 7 |
| Calculus I | Diya Patel | 96.00 | 1 |
| Calculus I | Reyansh Gupta | 92.60 | 2 |
| Calculus I | Ishaan Nair | 70.60 | 3 |
| Calculus I | Diya Patel | 65.30 | 4 |
| Calculus I | Saanvi Menon | 61.90 | 5 |
| Calculus I | Kiara Malhotra | 20.20 | 6 |
| ... | ... | ... | ... |

(72 rows total — full ranking for every course in `queries.md`'s output; no ties occur in this dataset, so `RANK` and `DENSE_RANK` would agree throughout.)

**Q28.** Running average of marks per student, in true chronological order (Fall2023 → Spring2024 → Fall2024).

72 rows. A representative slice:

| student_id | student_name | semester | course_name | marks_obtained | running_avg_marks |
|---|---|---|---|---|---|
| 2 | Diya Patel | Fall2023 | Physics I | 65.30 | 65.30 |
| 2 | Diya Patel | Fall2023 | Calculus I | 65.30 | 65.30 |
| 2 | Diya Patel | Fall2023 | Calculus I | 96.00 | 75.53 |
| 2 | Diya Patel | Spring2024 | Database Systems | 93.00 | 79.90 |
| 2 | Diya Patel | Fall2024 | Creative Writing | 88.90 | 81.70 |
| 2 | Diya Patel | Fall2024 | Data Structures | 91.00 | 83.25 |
| 7 | Reyansh Gupta | Fall2023 | Creative Writing | 72.60 | 72.60 |
| 7 | Reyansh Gupta | Spring2024 | Data Structures | 80.00 | 76.30 |
| 7 | Reyansh Gupta | Spring2024 | Data Structures | 95.00 | 82.53 |
| 7 | Reyansh Gupta | Fall2024 | Calculus I | 92.60 | 85.05 |

(72 rows in total, one block per student, each block's running average building up to that student's final `average_marks` in the Q19 view. Note this differs from a naive alphabetical-by-semester-name sort: `'Spring2024'` correctly falls *between* `'Fall2023'` and `'Fall2024'` here.)

**Q29.** Student with the second-highest overall average marks (≥ 2 graded courses).

| student_name | avg_marks |
|---|---|
| Diya Patel | 83.25 |

(Reyansh Gupta, at 85.05, holds first place.)

**Q30.** Student classification: Honors / Satisfactory / Needs Improvement / Not Graded.

| student_id | student_name | avg_marks | classification |
|---|---|---|---|
| 7 | Reyansh Gupta | 85.05 | Honors |
| 2 | Diya Patel | 83.25 | Honors |
| 5 | Vihaan Reddy | 82.13 | Honors |
| 11 | Vivaan Joshi | 78.85 | Honors |
| 10 | Ira Desai | 77.65 | Honors |
| 19 | Yuvan Bhatt | 76.75 | Satisfactory |
| 23 | Ishaan Nair | 74.40 | Satisfactory |
| 16 | Saanvi Menon | 74.10 | Satisfactory |
| 17 | Aryan Chopra | 73.65 | Satisfactory |
| 6 | Sara Khan | 70.80 | Satisfactory |
| 20 | Riya Sharma | 69.88 | Satisfactory |
| 9 | Arjun Mehta | 69.00 | Satisfactory |
| 22 | Zara Ahmed | 68.67 | Satisfactory |
| 8 | Myra Nair | 68.40 | Satisfactory |
| 12 | Anika Verma | 65.73 | Satisfactory |
| 4 | Ananya Iyer | 64.30 | Satisfactory |
| 3 | Kabir Singh | 60.63 | Satisfactory |
| 13 | Aditya Rao | 60.10 | Satisfactory |
| 1 | Aarav Shah | 59.17 | Satisfactory |
| 18 | Navya Pillai | 52.60 | Satisfactory |
| 14 | Kiara Malhotra | 51.70 | Satisfactory |
| 15 | Dhruv Kapoor | 50.08 | Satisfactory |
| 21 | Kabir Tiwari | 45.75 | Needs Improvement |
| 24 | Tara Kulkarni | 44.77 | Needs Improvement |
| 26 | Ayesha Khan | NULL | Not Graded |
| 25 | Om Prakash | NULL | Not Graded |

(26 rows — 24 graded students split into a top-20% "Honors" bucket of 5 via `NTILE(5)` and 19 others; 2 of those 19 fall under the hard 50-point "Needs Improvement" floor; the 2 students with zero enrollments are labeled "Not Graded" rather than being scored.)
