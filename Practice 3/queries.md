# Student Grades SQL Practice — Queries (Q1–Q30)

`USE student_grades;` is assumed before every query below.

---

## BASIC

**Q1.**
```sql
SELECT student_name, city
FROM students
WHERE city = 'Pune'
ORDER BY student_name;
```

**Q2.**
```sql
SELECT course_name, credits
FROM courses
ORDER BY credits DESC, course_name;
```

**Q3.**
```sql
SELECT enrollment_id, student_id, course_id, marks_obtained
FROM enrollments
WHERE semester = 'Fall2024'
ORDER BY enrollment_id;
```

**Q4.**
```sql
INSERT INTO students (student_name, gender, date_of_birth, enrollment_date, city)
VALUES ('Ayesha Khan', 'F', '2004-03-12', '2023-07-01', 'Nagpur');
```

**Q5.**
```sql
UPDATE enrollments
SET marks_obtained = 74.5
WHERE enrollment_id = 67;
```

**Q6.**
```sql
DELETE FROM enrollments
WHERE enrollment_id = 50;
```

**Q7.**
```sql
ALTER TABLE students
ADD COLUMN email VARCHAR(100) NULL;
```

**Q8.**
```sql
SELECT city, COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY city;
```

**Q9.**
```sql
SELECT student_id, student_name, enrollment_date
FROM students
WHERE YEAR(enrollment_date) > 2022
ORDER BY enrollment_date;
```

**Q10.**
```sql
SELECT DISTINCT department
FROM courses
ORDER BY department;
```

---

## INTERMEDIATE

**Q11.**
```sql
SELECT s.student_name, c.course_name, e.marks_obtained
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_name, c.course_name;
```

**Q12.**
```sql
SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL
ORDER BY s.student_id;
```

**Q13.**
```sql
SELECT s1.student_name AS student_1, s2.student_name AS student_2,
       YEAR(s1.date_of_birth) AS birth_year
FROM students s1
JOIN students s2 ON YEAR(s1.date_of_birth) = YEAR(s2.date_of_birth)
                 AND s1.student_id < s2.student_id
ORDER BY birth_year, s1.student_name, s2.student_name;
```

**Q14.**
```sql
SELECT c.course_name, COUNT(e.enrollment_id) AS students_enrolled
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY students_enrolled DESC, c.course_name;
```

**Q15.**
```sql
SELECT s.student_name, c.course_name, e.marks_obtained,
       CASE
           WHEN e.marks_obtained >= 90 THEN 'A'
           WHEN e.marks_obtained >= 75 THEN 'B'
           WHEN e.marks_obtained >= 60 THEN 'C'
           WHEN e.marks_obtained >= 40 THEN 'D'
           ELSE 'F'
       END AS grade_letter
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.marks_obtained IS NOT NULL AND e.marks_obtained < 40
ORDER BY e.marks_obtained;
```

**Q16.**
```sql
SELECT c.department, ROUND(AVG(e.marks_obtained), 2) AS avg_marks
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.marks_obtained IS NOT NULL
GROUP BY c.department
HAVING AVG(e.marks_obtained) > 75
ORDER BY avg_marks DESC;
```

**Q17.**
```sql
SELECT student_name FROM students WHERE gender = 'F'
UNION
SELECT student_name FROM students WHERE city = 'Delhi'
ORDER BY student_name;
```

**Q18.**
```sql
SELECT s.student_name, c.course_name, e.marks_obtained
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.marks_obtained > (SELECT AVG(marks_obtained) FROM enrollments)
ORDER BY e.marks_obtained DESC;
```

**Q19.**
```sql
CREATE VIEW student_performance AS
SELECT s.student_id, s.student_name,
       COUNT(e.enrollment_id) AS total_courses,
       ROUND(AVG(e.marks_obtained), 2) AS average_marks
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name;

SELECT * FROM student_performance
ORDER BY average_marks DESC;
```

**Q20.**
```sql
CREATE INDEX idx_student_id ON enrollments(student_id);
```

---

## ADVANCED

**Q21.**
```sql
SELECT c.course_name, s.student_name, e.marks_obtained
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
JOIN students s ON e.student_id = s.student_id
WHERE e.marks_obtained = (
    SELECT MAX(e2.marks_obtained)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
)
ORDER BY c.course_name;
```

**Q22.**
```sql
SELECT s.student_name, c.course_name, t.teacher_name, e.marks_obtained
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN teachers t ON c.teacher_id = t.teacher_id
WHERE c.department = 'Computer Science'
ORDER BY c.course_name, e.marks_obtained DESC;
```

**Q23.**
```sql
SELECT s.student_name, c.course_name, e.marks_obtained, e.attendance_percentage
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.marks_obtained >= 90
UNION ALL
SELECT s.student_name, c.course_name, e.marks_obtained, e.attendance_percentage
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.attendance_percentage < 50
ORDER BY student_name;
```

**Q24.**
```sql
SELECT s.student_id, s.student_name, ROUND(AVG(e.marks_obtained), 2) AS avg_marks
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.marks_obtained IS NOT NULL
GROUP BY s.student_id, s.student_name
HAVING AVG(e.marks_obtained) > 85
ORDER BY avg_marks DESC;
```

**Q25.**
```sql
SELECT course_name, avg_marks
FROM (
    SELECT c.course_id, c.course_name, ROUND(AVG(e.marks_obtained), 2) AS avg_marks
    FROM courses c
    JOIN enrollments e ON c.course_id = e.course_id
    WHERE e.marks_obtained IS NOT NULL
    GROUP BY c.course_id, c.course_name
) t
WHERE avg_marks = (
    SELECT MAX(avg_marks)
    FROM (
        SELECT c.course_id, ROUND(AVG(e.marks_obtained), 2) AS avg_marks
        FROM courses c
        JOIN enrollments e ON c.course_id = e.course_id
        WHERE e.marks_obtained IS NOT NULL
        GROUP BY c.course_id
    ) t2
);
```

**Q26.**
```sql
WITH student_avg AS (
    SELECT s.student_id, s.student_name, COUNT(*) AS num_courses,
           ROUND(AVG(e.marks_obtained), 2) AS avg_marks
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    WHERE e.marks_obtained IS NOT NULL
    GROUP BY s.student_id, s.student_name
    HAVING COUNT(*) >= 2
)
SELECT student_id, student_name, num_courses, avg_marks
FROM student_avg
ORDER BY avg_marks DESC
LIMIT 3;
```

**Q27.**
```sql
SELECT c.course_name, s.student_name, e.marks_obtained,
       RANK() OVER (PARTITION BY e.course_id ORDER BY e.marks_obtained DESC) AS student_rank
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.marks_obtained IS NOT NULL
ORDER BY c.course_name, student_rank;
```

**Q28.**
```sql
SELECT s.student_id, s.student_name, e.semester, c.course_name, e.marks_obtained,
       ROUND(AVG(e.marks_obtained) OVER (
           PARTITION BY s.student_id
           ORDER BY CASE e.semester
                        WHEN 'Fall2023' THEN 1
                        WHEN 'Spring2024' THEN 2
                        WHEN 'Fall2024' THEN 3
                    END
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2) AS running_avg_marks
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.marks_obtained IS NOT NULL
ORDER BY s.student_name,
         CASE e.semester
             WHEN 'Fall2023' THEN 1
             WHEN 'Spring2024' THEN 2
             WHEN 'Fall2024' THEN 3
         END;
```

**Q29.**
```sql
WITH student_avg AS (
    SELECT s.student_id, s.student_name, ROUND(AVG(e.marks_obtained), 2) AS avg_marks
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    WHERE e.marks_obtained IS NOT NULL
    GROUP BY s.student_id, s.student_name
    HAVING COUNT(*) >= 2
),
ranked AS (
    SELECT student_id, student_name, avg_marks,
           DENSE_RANK() OVER (ORDER BY avg_marks DESC) AS rnk
    FROM student_avg
)
SELECT student_name, avg_marks
FROM ranked
WHERE rnk = 2;
```

**Q30.**
```sql
WITH student_avg AS (
    SELECT s.student_id, s.student_name,
           ROUND(AVG(e.marks_obtained), 2) AS avg_marks
    FROM students s
    LEFT JOIN enrollments e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.student_name
),
ranked AS (
    SELECT student_id, student_name, avg_marks,
           NTILE(5) OVER (ORDER BY avg_marks DESC) AS performance_bucket
    FROM student_avg
    WHERE avg_marks IS NOT NULL
)
SELECT sa.student_id, sa.student_name, sa.avg_marks,
       CASE
           WHEN sa.avg_marks IS NULL THEN 'Not Graded'
           WHEN sa.avg_marks < 50 THEN 'Needs Improvement'
           WHEN r.performance_bucket = 1 THEN 'Honors'
           ELSE 'Satisfactory'
       END AS classification
FROM student_avg sa
LEFT JOIN ranked r ON sa.student_id = r.student_id
ORDER BY sa.avg_marks DESC, sa.student_name;
```
