USE COMPANY_TRACKER;

-- BASIC(Q1-Q10)
-- Q1. List the department name and location for departments located in "Bangalore" or "Mumbai".
SELECT DEPT_NAME , LOCATION 
FROM DEPARTMENTS
WHERE LOCATION IN ('BANGALORE','MUMBAI');
-- OR
SELECT DEPT_NAME , LOCATION
FROM DEPARTMENTS
WHERE LOCATION='BANGALORE' OR LOCATION='MUMBAI';

-- Q2. List all employee names and designations, sorted alphabetically by employee name.
SELECT EMP_NAME , DESIGNATION 
FROM EMPLOYEES
ORDER BY EMP_NAME ASC;

-- Q3. List the project name and budget for all projects with a budget greater than 300000.
SELECT PROJECT_NAME , BUDGET 
FROM PROJECTS
WHERE BUDGET>300000;

-- Q4. Insert a new employee: Aakash Iyer, dept_id 1, designation Intern, salary 22000, date_of_joining 2024-03-15.
INSERT INTO EMPLOYEES(EMP_NAME , DEPT_ID , DESIGNATION , SALARY , DATE_OF_JOINING) VALUES
('AAKASH IYER' , 1 , 'INTERN' , 22000 , '2024-03-15');
SELECT * FROM EMPLOYEES;

-- Q5. Update the salary of Priya Nair to 25000.
UPDATE EMPLOYEES SET SALARY=25000 WHERE EMP_NAME ='PRIYA NAIR';
SELECT * FROM EMPLOYEES WHERE EMP_NAME='PRIYA NAIR';

-- Q6. Delete the employee_projects row for project_id 6, emp_id 4.
DELETE FROM EMPLOYEE_PROJECTS WHERE PROJECT_ID=6 AND EMP_ID=4;
SELECT * FROM EMPLOYEE_PROJECTS;

-- Q7. Add a new column email (VARCHAR(100), nullable) to the employees table.
ALTER TABLE EMPLOYEES
ADD COLUMN EMAIL VARCHAR(100) NULL;
DESCRIBE EMPLOYEES;

-- Q8. Find the number of employees in each department (team name + count).
SELECT DEPT_NAME ,  COUNT(EMP_ID) 
FROM DEPARTMENTS
JOIN EMPLOYEES
ON DEPARTMENTS.DEPT_ID=EMPLOYEES.DEPT_ID
GROUP BY DEPT_NAME
ORDER BY DEPT_NAME;

-- Q9. Find all employees who joined after the year 2020 (use a date/year function).
SELECT EMP_ID , EMP_NAME , DATE_OF_JOINING
FROM EMPLOYEES
WHERE YEAR(DATE_OF_JOINING)>2020
ORDER BY DATE_OF_JOINING;

-- 10. Find all distinct designations that exist in the employees table.
SELECT DISTINCT DESIGNATION
FROM EMPLOYEES
ORDER BY DESIGNATION;

-- INTERMEDIATE(Q11-Q20)
-- Q11. Using an INNER JOIN, list every employee's name, designation, and department name.
SELECT EMP_NAME , DESIGNATION , DEPT_NAME
FROM DEPARTMENTS
INNER JOIN EMPLOYEES
ON DEPARTMENTS.DEPT_ID=EMPLOYEES.DEPT_ID
ORDER BY EMP_ID;

-- Q12. Using a LEFT JOIN, find every employee who has never been assigned to any project.
SELECT EMPLOYEES.EMP_ID , EMPLOYEES.EMP_NAME
FROM EMPLOYEES
LEFT JOIN EMPLOYEE_PROJECTS
ON EMPLOYEES.EMP_ID=EMPLOYEE_PROJECTS.EMP_ID
WHERE ASSIGNMENT_ID IS NULL
ORDER BY EMPLOYEES.EMP_ID;

-- Q13. Using a SELF JOIN on employees, list every unique pair of employees who work in the same department.
SELECT E1.EMP_NAME AS EMPLOYEE1 , E2.EMP_NAME AS EMPLOYEE2 , E1.DEPT_ID
FROM EMPLOYEES E1
JOIN EMPLOYEES E2
ON E1.DEPT_ID=E2.DEPT_ID
AND E1.EMP_ID < E2.EMP_ID
ORDER BY E1.DEPT_ID , EMPLOYEE1 , EMPLOYEE2;

-- Q14. Using JOIN + GROUP BY, calculate total hours worked by each employee who has at least one project assignment.
SELECT E.EMP_ID , E.EMP_NAME , SUM(HOURS_WORKED)
FROM EMPLOYEES E
JOIN EMPLOYEE_PROJECTS EP
ON E.EMP_ID=EP.EMP_ID
GROUP BY E.EMP_ID , E.EMP_NAME
ORDER BY E.EMP_ID;

-- Q15. Find every instance of an employee working more than 100 hours on a single project — show employee name, project_id, hours.
SELECT E.EMP_NAME , PROJECT_ID , HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E
ON EP.EMP_ID=E.EMP_ID
WHERE HOURS_WORKED>100;

-- Q16. Using GROUP BY and HAVING, find departments with more than 4 employees.
SELECT DEPT_NAME , COUNT(EMP_ID)
FROM DEPARTMENTS
JOIN EMPLOYEES
ON DEPARTMENTS.DEPT_ID=EMPLOYEES.DEPT_ID
GROUP BY DEPT_NAME
HAVING COUNT(EMP_ID)>4;

-- Q17. Using UNION, produce one combined list of names of all Managers and all Interns.
SELECT EMP_ID , EMP_NAME , DESIGNATION FROM EMPLOYEES WHERE DESIGNATION='MANAGER'
UNION
SELECT EMP_ID , EMP_NAME , DESIGNATION FROM EMPLOYEES WHERE DESIGNATION='INTERN'
ORDER BY EMP_ID , EMP_NAME;

-- Q18. Using a subquery, find the names and salaries of employees whose salary is above the average salary across all employees.
SELECT EMP_NAME , SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC;

-- Q19. Create a VIEW called employee_stats showing emp_id, emp_name, total_hours, and projects_count for every employee.
CREATE VIEW EMPLOYEE_STATS AS
SELECT E.EMP_ID , E.EMP_NAME , SUM(HOURS_WORKED) AS TOTAL_HOURS , COUNT(ASSIGNMENT_ID) AS PROJECTS_COUNT
FROM EMPLOYEES E
LEFT JOIN EMPLOYEE_PROJECTS EP
ON E.EMP_ID=EP.EMP_ID
GROUP BY E.EMP_ID , E.EMP_NAME;

SELECT * FROM EMPLOYEE_STATS;

-- Q20. Create an INDEX called idx_dept_id on employees(dept_id).
CREATE INDEX idx_dept_id ON EMPLOYEES(DEPT_ID);
SHOW INDEXES IN EMPLOYEES;


-- ADVANCED(Q21-Q30).
-- Q21. Using a correlated subquery, find the employee with the most hours worked on each project.
SELECT E.EMP_ID , E.EMP_NAME , HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E
ON EP.EMP_ID=E.EMP_ID
WHERE HOURS_WORKED = (SELECT MAX(HOURS_WORKED) FROM EMPLOYEE_PROJECTS EP2 WHERE EP2.PROJECT_ID=EP.PROJECT_ID)
ORDER BY EP.PROJECT_ID;

-- Q22. Using multiple JOINs, list project_name, dept_name, and total hours logged against each project (include projects with zero hours logged, if any).
SELECT P.PROJECT_NAME , D.DEPT_NAME , SUM(EP.HOURS_WORKED)
FROM PROJECTS P
JOIN DEPARTMENTS D
ON P.DEPT_ID=D.DEPT_ID
LEFT JOIN EMPLOYEE_PROJECTS EP
ON P.PROJECT_ID=EP.PROJECT_ID
GROUP BY P.PROJECT_ID , P.PROJECT_NAME , D.DEPT_NAME 
ORDER BY P.PROJECT_ID;

-- Q23. Using UNION ALL, combine (a) all employee_projects rows with hours_worked > 100 and (b) all employee_projects rows with hours_worked < 30 — duplicates allowed. Show employee name, project_id, hours.
SELECT EP.PROJECT_ID , E.EMP_NAME , EP.HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E
ON EP.EMP_ID=E.EMP_ID
WHERE HOURS_WORKED>100
UNION ALL
SELECT EP.PROJECT_ID , E.EMP_NAME , EP.HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E
ON EP.EMP_ID=E.EMP_ID
WHERE HOURS_WORKED<30
ORDER BY HOURS_WORKED DESC;

-- Q24. Using JOIN + GROUP BY + HAVING, find departments with total_projects greater than 1.
SELECT D.DEPT_NAME , COUNT(P.PROJECT_ID) AS TOTAL_PROJECTS
FROM DEPARTMENTS D 
JOIN PROJECTS P
ON D.DEPT_ID=P.DEPT_ID
GROUP BY D.DEPT_NAME
HAVING COUNT(P.PROJECT_ID)>1;

-- Q25. Using a subquery with MAX(), find the department(s) with the highest total_projects.
SELECT D.DEPT_NAME , COUNT(P.PROJECT_ID)
FROM DEPARTMENTS D
JOIN PROJECTS P
ON D.DEPT_ID=P.DEPT_ID
GROUP BY D.DEPT_NAME
HAVING COUNT(P.PROJECT_ID)=(
SELECT MAX(PROJECT_COUNT)
FROM (SELECT COUNT(PROJECT_ID) AS PROJECT_COUNT FROM PROJECTS GROUP BY DEPT_ID) AS COUNTS);

-- Q26. Demonstrate a TRANSACTION: move Rahul Mehta (emp_id 3) from Engineering to Marketing, verify with a SELECT, then COMMIT. Explain what ROLLBACK would have done instead.
START TRANSACTION;
UPDATE EMPLOYEES 
SET DEPT_ID=2 WHERE EMP_NAME='RAHUL MEHTA';
SELECT EMP_NAME , EMP_ID , DEPT_ID FROM EMPLOYEES WHERE EMP_NAME='RAHUL MEHTA';
COMMIT;

-- Q27. Create a STORED PROCEDURE GetEmployeeProjects(IN p_emp_id INT) that returns all project assignments for a given employee. Call it for emp_id = 1.
DELIMITER $$
CREATE PROCEDURE GetEmployeeProjects(IN p_emp_id INT)
BEGIN
	SELECT E.EMP_NAME , EP.PROJECT_ID , P.PROJECT_NAME , EP.HOURS_WORKED
    FROM EMPLOYEE_PROJECTS EP
    JOIN EMPLOYEES E
    ON EP.EMP_ID=E.EMP_ID
    JOIN PROJECTS P
    ON P.PROJECT_ID=EP.PROJECT_ID
    WHERE EP.EMP_ID = p_emp_id;
END $$
DELIMITER ;

CALL GetEmployeeProjects(1);


-- Q28. Create a TRIGGER trg_update_dept_projects that automatically increments the relevant department's total_projects whenever a new row is inserted into projects. Demonstrate it by inserting a new project into HR (dept_id 4): Payroll System Upgrade, budget 150000, start 2025-05-01, end 2025-08-31.
DELIMITER $$
CREATE TRIGGER trg_update_dept_projects
AFTER INSERT ON PROJECTS
FOR EACH ROW
BEGIN 
	UPDATE DEPARTMENTS
    SET TOTAL_PROJECTS=TOTAL_PROJECTS+1
    WHERE DEPT_ID=NEW.DEPT_ID;
END $$
DELIMITER ;
INSERT INTO PROJECTS (PROJECT_NAME, DEPT_ID, BUDGET, START_DATE, END_DATE)
VALUES ('Payroll System Upgrade', 4, 150000, '2025-05-01', '2025-08-31');


-- Q29. Create a STORED PROCEDURE AddProject(...) that inserts a new project row, relying on the Q28 trigger to update total_projects automatically. Use it to add Social Media Campaign to Marketing (dept_id 2), budget 250000, start 2025-06-01, end 2025-09-30. Wrap the call in a transaction.
DELIMITER $$
CREATE PROCEDURE AddProject(
    IN p_project_name VARCHAR(100), IN p_dept_id INT, IN p_budget INT,
    IN p_start_date DATE, IN p_end_date DATE
)
BEGIN
    INSERT INTO PROJECTS (PROJECT_NAME, DEPT_ID, BUDGET, START_DATE, END_DATE)
    VALUES (p_project_name, p_dept_id, p_budget, p_start_date, p_end_date);
END $$	
DELIMITER ;

START TRANSACTION;
CALL AddProject('Social Media Campaign', 2, 250000, '2025-06-01', '2025-09-30');
COMMIT;


-- Q30. Using JOIN + subquery + GROUP BY, find the employee with the highest total hours worked in each department (remember: Rahul Mehta moved departments in Q26 — his hours move with him).
SELECT D.DEPT_NAME , E.EMP_NAME , ET.TOTAL_HOURS
FROM (
	SELECT E.DEPT_ID , E.EMP_ID , SUM(EP.HOURS_WORKED) AS TOTAL_HOURS
    FROM EMPLOYEES E
    JOIN EMPLOYEE_PROJECTS EP
    ON E.EMP_ID=EP.EMP_ID
    GROUP BY E.DEPT_ID , E.EMP_ID
)ET
JOIN EMPLOYEES E
ON E.EMP_ID=ET.EMP_ID
JOIN DEPARTMENTS D
ON D.DEPT_ID=ET.DEPT_ID
WHERE ET.TOTAL_HOURS=(
	SELECT MAX(ET2.TOTAL_HOURS) FROM (
		SELECT E2.DEPT_ID , E2.EMP_ID , SUM(EP2.HOURS_WORKED) AS TOTAL_HOURS
        FROM EMPLOYEES E2
        JOIN EMPLOYEE_PROJECTS EP2
        ON E2.EMP_ID=EP2.EMP_ID
        GROUP BY E2.DEPT_ID , E2.EMP_ID
	)ET2 WHERE ET2.DEPT_ID=ET.DEPT_ID
)
ORDER BY D.DEPT_NAME;