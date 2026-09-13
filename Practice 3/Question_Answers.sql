-- PRACTICE 3 QUESTIONS
USE STUDENT_GRADES;

-- BASIC(Q1-Q10)
-- Q1. List the student name and city of all students from "Pune".
SELECT S_NAME , CITY 
FROM STUDENTS
WHERE CITY='PUNE';

-- Q2. List all course names and their credits, ordered from highest credits to lowest (ties broken alphabetically by course name).
SELECT C_NAME , CREDITS
FROM COURSES
ORDER BY CREDITS DESC , C_NAME;

-- Q3.List the enrollment ID, student ID, course ID, and marks obtained for all enrollments in the 'Fall2024' semester.
SELECT E_ID , S_ID , C_ID , MARKS 
FROM ENROLLMENTS
WHERE SEMESTER='FALL2024';

-- Q4. Insert a new student: Ayesha Khan, gender F, date_of_birth 2004-03-12, enrollment_date 2023-07-01, city Nagpur.
INSERT INTO STUDENTS(S_NAME , GENDER , DATE_OF_BIRTH , ENROLL_DATE , CITY) VALUES
('AYESHA KHAN' , 'FEMALE' , '2004-03-12' , '2023-07-01' , 'NAGPUR');
SELECT * FROM STUDENTS;

-- Q5.A previously-ungraded enrollment (enrollment_id = 67, for student_id 3 in course_id 6, Fall2024) has just been graded. Update its marks_obtained to 74.5.
UPDATE ENROLLMENTS
SET MARKS=75 WHERE E_ID=67 AND S_ID=3 AND C_ID=6;
SELECT * FROM ENROLLMENTS;

-- Q6. . Delete the enrollment record with enrollment_id = 50 (the student dropped that course).
DELETE FROM ENROLLMENTS WHERE E_ID=50;
SELECT * FROM ENROLLMENTS;

-- Q7. Add a new column email (VARCHAR(100), nullable) to the students table.
ALTER TABLE STUDENTS ADD COLUMN EMAIL VARCHAR(100) NULL;
SELECT * FROM STUDENTS;

-- Q8. Find the number of students in each city (city + student count).
SELECT CITY , COUNT(S_ID) 
FROM STUDENTS
GROUP BY CITY;

-- Q9. Find all students who enrolled after the year 2022 (use a date/year function on enrollment_date), ordered by enrollment date.
SELECT S_ID , S_NAME , ENROLL_DATE 
FROM STUDENTS
WHERE YEAR(ENROLL_DATE)>2022;

-- Q10. Find all distinct departments that exist in the courses table.
SELECT DISTINCT DEPT 
FROM COURSES
ORDER BY DEPT;


-- INTERMEDIATE(Q11-Q20)
-- Q11. Using an INNER JOIN, list every enrollment's student_name, course_name, and marks_obtained.
SELECT S.S_NAME , C.C_NAME , E.MARKS
FROM ENROLLMENTS E
INNER JOIN STUDENTS S ON E.S_ID=S.S_ID
INNER JOIN COURSES C ON E.C_ID=C.C_ID
ORDER BY S.S_NAME , C.C_NAME;

-- Q12. Using a LEFT JOIN, find every student who has never enrolled in any course.
SELECT S.S_ID , S.S_NAME
FROM STUDENTS S
LEFT JOIN ENROLLMENTS E
ON S.S_ID=E.S_ID
WHERE E.E_ID IS NULL;

-- Q13. Using a SELF JOIN on students, list every unique pair of students who were born in the same year (student_1, student_2, birth_year).
SELECT S1.S_NAME AS STUDENT1 , S2.S_NAME AS STUDENT2 , YEAR(S1.DATE_OF_BIRTH) AS BIRTH_YEAR
FROM STUDENTS S1
JOIN STUDENTS S2
ON YEAR(S1.DATE_OF_BIRTH)=YEAR(S2.DATE_OF_BIRTH)
AND S1.S_ID<S2.S_ID
ORDER BY STUDENT1 , STUDENT2 , BIRTH_YEAR;

-- Q14. Using JOIN + GROUP BY, find how many students are enrolled in each course (course_name + students_enrolled), ordered from most enrolled to least.
SELECT C_NAME , COUNT(E.E_ID)  
FROM COURSES C
JOIN ENROLLMENTS E
ON C.C_ID=E.C_ID
GROUP BY C_NAME
ORDER BY COUNT(E.E_ID) DESC;

-- Q15. Using a CASE expression, classify every graded enrollment into a letter grade ('A' ≥ 90, 'B' ≥ 75, 'C' ≥ 60, 'D' ≥ 40, else 'F'), then show only the enrollments that earned an 'F' (student_name, course_name, marks_obtained, grade_letter), ordered by marks ascending.
SELECT S.S_NAME , C.C_NAME , E.MARKS ,
	CASE
		WHEN E.MARKS>=90 THEN 'A'
        WHEN E.MARKS>=75 THEN 'B'
        WHEN E.MARKS>=60 THEN 'C'
        WHEN E.MARKS>=40 THEN 'D'
        ELSE 'F'
	END AS GRADE
FROM ENROLLMENTS E
JOIN STUDENTS S
ON E.S_ID=S.S_ID
JOIN COURSES C
ON E.C_ID=C.C_ID
WHERE E.MARKS IS NOT NULL AND E.MARKS<40
ORDER BY E.MARKS;

-- Q16. Using GROUP BY and HAVING, find the departments where the average marks (across all graded enrollments in that department) exceed 75.
SELECT C.DEPT , AVG(E.MARKS) AS AVG_MARKS
FROM COURSES C
JOIN ENROLLMENTS E
ON C.C_ID=E.C_ID
GROUP BY C.DEPT
HAVING AVG(E.MARKS)>75
ORDER BY C.DEPT;

-- Q17. . Using UNION, produce one combined, deduplicated list of the names of all female students and all students from "Delhi".
SELECT S_NAME , GENDER , CITY FROM STUDENTS WHERE GENDER='FEMALE'
UNION
SELECT S_NAME , GENDER , CITY FROM STUDENTS WHERE CITY='DELHI';

-- Q18. Using a subquery, find the student name, course name, and marks for every graded enrollment scoring above the average marks across all enrollments, ordered by marks descending.
SELECT S.S_NAME , C.C_NAME , E.MARKS
FROM ENROLLMENTS E
JOIN STUDENTS S
ON E.S_ID=S.S_ID
JOIN COURSES C
ON E.C_ID=C.C_ID
WHERE E.MARKS>(SELECT AVG(MARKS) FROM ENROLLMENTS)
ORDER BY E.MARKS DESC; 

-- Q19. Create a VIEW called student_performance showing student_id, student_name, total_courses, and average_marks for every student (students with zero enrollments should show 0 courses and a NULL average, not be excluded). Then query it, ordered by average_marks descending.
CREATE VIEW student_performance AS
SELECT S.S_ID , S.S_NAME , AVG(E.MARKS) AS AVG_MARKS , COUNT(E.E_ID)
FROM STUDENTS S
JOIN ENROLLMENTS E
ON S.S_ID=E.S_ID
GROUP BY S.S_ID , S.S_NAME;

SELECT * FROM student_performance
ORDER BY AVG_MARKS DESC;

-- Q20. Create an INDEX called idx_student_id on enrollments(student_id).
SHOW INDEXES IN ENROLLMENTS;
CREATE INDEX idx_student_id ON ENROLLMENTS(S_ID);
SHOW INDEXES IN ENROLLMENTS;


-- ADVANCED(Q21-Q30)
-- Q21. Using a correlated subquery, find the top-scoring student in each course (course_name, student_name, marks_obtained).
SELECT  S.S_NAME , C.C_NAME , E.MARKS
FROM ENROLLMENTS E
JOIN COURSES C
ON E.C_ID=C.C_ID
JOIN STUDENTS S
ON E.S_ID=S.S_ID
HAVING E.MARKS=(SELECT MAX(E2.MARKS) FROM ENROLLMENTS E2 WHERE E2.C_ID=E.C_ID)
ORDER BY C.C_NAME;

-- Q22. Using multiple JOINs, list student_name, course_name, teacher_name, and marks_obtained for every enrollment in the "Computer Science" department, ordered by course_name then marks descending.
SELECT S.S_NAME , C.C_NAME , T.T_NAME , E.MARKS
FROM ENROLLMENTS E
JOIN STUDENTS S ON E.S_ID=S.S_ID
JOIN COURSES C ON E.C_ID=C.C_ID
JOIN TEACHERS T ON C.T_ID=T.T_ID
WHERE C.DEPT='COMPUTER SCIENCE'
ORDER BY C.C_NAME , E.MARKS DESC;

-- Q23. Using UNION ALL, combine (a) all enrollments with marks_obtained ≥ 90 and (b) all enrollments with attendance_percentage < 50 — duplicates allowed. Show student_name, course_name, marks_obtained, attendance_percentage.
SELECT S.S_NAME , C.C_NAME , E.MARKS , E.ATTENDANCE
FROM ENROLLMENTS E
JOIN STUDENTS S ON E.S_ID=S.S_ID
JOIN COURSES C ON E.C_ID=C.C_ID
WHERE E.MARKS>=90
UNION ALL
SELECT S.S_NAME , C.C_NAME , E.MARKS , E.ATTENDANCE
FROM ENROLLMENTS E
JOIN STUDENTS S ON E.S_ID=S.S_ID
JOIN COURSES C ON E.C_ID=C.C_ID
WHERE E.ATTENDANCE<50
ORDER BY S_NAME;

-- Q24. Using JOIN + GROUP BY + HAVING, find students whose average marks (across their graded enrollments) exceed 85 — show student_id, student_name, avg_marks.
SELECT S.S_ID , S.S_NAME , AVG(E.MARKS) AS AVG_MARKS
FROM ENROLLMENTS E
JOIN STUDENTS S
ON E.S_ID=S.S_ID
GROUP BY S.S_ID , S.S_NAME
HAVING AVG_MARKS>85;

-- Q25. Using a subquery with MAX(), find the course(s) with the single highest average marks across all graded enrollments.
SELECT C.C_NAME,AVG(E.MARKS) AS AVG_MARKS
FROM COURSES C
JOIN ENROLLMENTS E
ON C.C_ID=E.C_ID
GROUP BY C.C_ID,C.C_NAME
ORDER BY AVG(E.MARKS) DESC
LIMIT 1;

-- Q26. Using a CTE that computes each student's average marks (only counting students with at least 2 graded enrollments), list the top 3 students by average marks (student_id, student_name, num_courses, avg_marks).
WITH STUDENT_AVG AS (
	SELECT S.S_ID , S.S_NAME , COUNT(*) AS NUM_COURSE , ROUND(AVG(E.MARKS),2) AS AVG_MARKS
    FROM STUDENTS S
    JOIN ENROLLMENTS E
    ON S.S_ID=E.S_ID
    GROUP BY S.S_ID  , S.S_NAME
    HAVING COUNT(*)>=2
)
SELECT S_ID , S_NAME , NUM_COURSE , AVG_MARKS
FROM STUDENT_AVG
ORDER BY AVG_MARKS DESC
LIMIT 3;
    
-- Q27. Using a window function (RANK), rank students within each course by marks obtained, from highest to lowest — show course_name, student_name, marks_obtained, and student_rank.
SELECT C.C_NAME , S.S_NAME , E.MARKS , RANK() OVER(PARTITION BY C.C_ID ORDER BY E.MARKS DESC) AS STUDENT_RANK
FROM ENROLLMENTS E
JOIN STUDENTS S ON E.S_ID=S.S_ID
JOIN COURSES C ON E.C_ID=C.C_ID
WHERE E.MARKS IS NOT NULL
ORDER BY C.C_NAME , STUDENT_RANK;

-- Q28. Using a window function, show every graded enrollment for every student in true chronological order by semester (Fall2023 → Spring2024 → Fall2024), along with a running average of that student's marks over time — show student_id, student_name, semester, course_name, marks_obtained, and running_avg_marks.
SELECT S.S_ID,S.S_NAME,E.SEMESTER,C.C_NAME,E.MARKS,
ROUND(AVG(E.MARKS) OVER(
    PARTITION BY S.S_ID
    ORDER BY CASE E.SEMESTER
        WHEN 'FALL2023' THEN 1
        WHEN 'SPRING2024' THEN 2
        WHEN 'FALL2024' THEN 3
    END
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
),2) AS RUNNING_AVG_MARKS
FROM ENROLLMENTS E
JOIN STUDENTS S
ON E.S_ID=S.S_ID
JOIN COURSES C
ON E.C_ID=C.C_ID
WHERE E.MARKS IS NOT NULL
ORDER BY S.S_NAME,
CASE E.SEMESTER
    WHEN 'FALL2023' THEN 1
    WHEN 'SPRING2024' THEN 2
    WHEN 'FALL2024' THEN 3
END;

-- Q29. Using a CTE combined with a window function (DENSE_RANK), find the student with the second-highest overall average marks, considering only students with at least 2 graded enrollments.
WITH STUDENT_AVG AS (
	SELECT S.S_ID , S.S_NAME , ROUND(AVG(E.MARKS), 2) AS AVG_MARKS
	FROM ENROLLMENTS E
    JOIN STUDENTS S
    ON E.S_ID=S.S_ID
    GROUP BY S.S_ID , S.S_NAME
    HAVING COUNT(*)>=2
),
RANKED AS (
	SELECT S_ID , S_NAME , AVG_MARKS, DENSE_RANK() OVER (ORDER BY AVG_MARKS DESC) AS RNK
    FROM STUDENT_AVG
)
SELECT S_NAME , AVG_MARKS
FROM RANKED 
WHERE RNK=2;

-- Q30. Using a CTE, a window function (NTILE), and a CASE expression together, classify every student as 'Honors' (top 20% by average marks, among graded students), 'Needs Improvement' (average marks under 50), 'Satisfactory' (everyone else with grades), or 'Not Graded' (students with no graded enrollments at all). Show student_id, student_name, avg_marks, and classification, ordered by avg_marks descending.
WITH STUDENT_AVG AS(
    SELECT S.S_ID,S.S_NAME,
           ROUND(AVG(E.MARKS),2) AS AVG_MARKS
    FROM STUDENTS S
    LEFT JOIN ENROLLMENTS E
    ON S.S_ID=E.S_ID
    GROUP BY S.S_ID,S.S_NAME
),
RANKED AS(
    SELECT S_ID,S_NAME,AVG_MARKS,
           NTILE(5) OVER(ORDER BY AVG_MARKS DESC) AS PERFORMANCE_BUCKET
    FROM STUDENT_AVG
    WHERE AVG_MARKS IS NOT NULL
)
SELECT SA.S_ID,SA.S_NAME,SA.AVG_MARKS,
       CASE
           WHEN SA.AVG_MARKS IS NULL THEN 'NOT GRADED'
           WHEN SA.AVG_MARKS<50 THEN 'NEEDS IMPROVEMENT'
           WHEN R.PERFORMANCE_BUCKET=1 THEN 'HONORS'
           ELSE 'SATISFACTORY'
       END AS CLASSIFICATION
FROM STUDENT_AVG SA
LEFT JOIN RANKED R
ON SA.S_ID=R.S_ID
ORDER BY SA.AVG_MARKS DESC,SA.S_NAME;