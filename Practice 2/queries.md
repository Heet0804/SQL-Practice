# Company Project Tracker — SQL Queries

All queries below were run **in order** (Q1 → Q30) against a fresh load of the 5 base files, on MariaDB 10.11. Queries in Q4, Q5, Q6, Q7, Q26, Q28, and Q29 modify the data/schema, so every query after one of those operates on the updated state.


## Basic (Q1–Q10)

### Q1. List the department name and location for departments located in "Bangalore" or "Mumbai".

```sql
-- Q1: Departments in Bangalore or Mumbai
SELECT DEPT_NAME, LOCATION
FROM DEPARTMENTS
WHERE LOCATION IN ('Bangalore', 'Mumbai');
```

### Q2. List all employee names and designations, sorted alphabetically by employee name.

```sql
-- Q2: All employee names and designations, sorted alphabetically by name
SELECT EMP_NAME, DESIGNATION
FROM EMPLOYEES
ORDER BY EMP_NAME ASC;
```

### Q3. List the project name and budget for all projects with a budget greater than 300000.

```sql
-- Q3: Projects with budget > 300000
SELECT PROJECT_NAME, BUDGET
FROM PROJECTS
WHERE BUDGET > 300000;
```

### Q4. Insert a new employee: `Aakash Iyer`, dept_id 1, designation `Intern`, salary 22000, date_of_joining `2024-03-15`.

```sql
-- Q4: Insert new employee
INSERT INTO EMPLOYEES (EMP_NAME, DEPT_ID, DESIGNATION, SALARY, DATE_OF_JOINING)
VALUES ('Aakash Iyer', 1, 'Intern', 22000, '2024-03-15');

SELECT * FROM EMPLOYEES WHERE EMP_NAME = 'Aakash Iyer';
```

### Q5. Update the salary of `Priya Nair` to 25000.

```sql
-- Q5: Update salary of Priya Nair
UPDATE EMPLOYEES
SET SALARY = 25000
WHERE EMP_NAME = 'Priya Nair';

SELECT EMP_NAME, SALARY FROM EMPLOYEES WHERE EMP_NAME = 'Priya Nair';
```

### Q6. Delete the employee_projects row for project_id 6, emp_id 4.

```sql
-- Q6: Delete employee_projects row for project_id 6, emp_id 4
DELETE FROM EMPLOYEE_PROJECTS
WHERE PROJECT_ID = 6 AND EMP_ID = 4;

SELECT * FROM EMPLOYEE_PROJECTS WHERE PROJECT_ID = 6;
```

### Q7. Add a new column `email` (VARCHAR(100), nullable) to the `employees` table.

```sql
-- Q7: Add email column to employees
ALTER TABLE EMPLOYEES
ADD COLUMN EMAIL VARCHAR(100) NULL;

DESCRIBE EMPLOYEES;
```

### Q8. Find the number of employees in each department (team name + count).

```sql
-- Q8: Number of employees in each department
SELECT D.DEPT_NAME AS TEAM_NAME, COUNT(E.EMP_ID) AS EMPLOYEE_COUNT
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_NAME
ORDER BY D.DEPT_NAME;
```

### Q9. Find all employees who joined after the year 2020 (use a date/year function).

```sql
-- Q9: Employees who joined after year 2020
SELECT EMP_NAME, DATE_OF_JOINING
FROM EMPLOYEES
WHERE YEAR(DATE_OF_JOINING) > 2020
ORDER BY DATE_OF_JOINING;
```

### Q10. Find all distinct designations that exist in the `employees` table.

```sql
-- Q10: Distinct designations
SELECT DISTINCT DESIGNATION
FROM EMPLOYEES
ORDER BY DESIGNATION;
```


## Intermediate (Q11–Q20)

### Q11. Using an INNER JOIN, list every employee's name, designation, and department name.

```sql
-- Q11: INNER JOIN - employee name, designation, department name
SELECT E.EMP_NAME, E.DESIGNATION, D.DEPT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPT_ID = D.DEPT_ID
ORDER BY E.EMP_ID;
```

### Q12. Using a LEFT JOIN, find every employee who has never been assigned to any project.

```sql
-- Q12: LEFT JOIN - employees never assigned to any project
SELECT E.EMP_ID, E.EMP_NAME
FROM EMPLOYEES E
LEFT JOIN EMPLOYEE_PROJECTS EP ON E.EMP_ID = EP.EMP_ID
WHERE EP.ASSIGNMENT_ID IS NULL
ORDER BY E.EMP_ID;
```

### Q13. Using a SELF JOIN on `employees`, list every unique pair of employees who work in the same department.

```sql
-- Q13: SELF JOIN - unique pairs of employees in same department
SELECT E1.EMP_NAME AS EMPLOYEE_1, E2.EMP_NAME AS EMPLOYEE_2, E1.DEPT_ID
FROM EMPLOYEES E1
JOIN EMPLOYEES E2 ON E1.DEPT_ID = E2.DEPT_ID AND E1.EMP_ID < E2.EMP_ID
ORDER BY E1.DEPT_ID, E1.EMP_NAME, E2.EMP_NAME;
```

### Q14. Using JOIN + GROUP BY, calculate total hours worked by each employee who has at least one project assignment.

```sql
-- Q14: JOIN + GROUP BY - total hours worked by each employee with at least one project
SELECT E.EMP_ID, E.EMP_NAME, SUM(EP.HOURS_WORKED) AS TOTAL_HOURS
FROM EMPLOYEES E
JOIN EMPLOYEE_PROJECTS EP ON E.EMP_ID = EP.EMP_ID
GROUP BY E.EMP_ID, E.EMP_NAME
ORDER BY E.EMP_ID;
```

### Q15. Find every instance of an employee working more than 100 hours on a single project — show employee name, project_id, hours.

```sql
-- Q15: Employee working more than 100 hours on a single project
SELECT E.EMP_NAME, EP.PROJECT_ID, EP.HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E ON E.EMP_ID = EP.EMP_ID
WHERE EP.HOURS_WORKED > 100
ORDER BY EP.HOURS_WORKED DESC;
```

### Q16. Using GROUP BY and HAVING, find departments with more than 4 employees.

```sql
-- Q16: GROUP BY + HAVING - departments with more than 4 employees
SELECT D.DEPT_NAME, COUNT(E.EMP_ID) AS EMPLOYEE_COUNT
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_NAME
HAVING COUNT(E.EMP_ID) > 4;
```

### Q17. Using UNION, produce one combined list of names of all Managers and all Interns.

```sql
-- Q17: UNION - names of all Managers and all Interns
SELECT EMP_NAME, DESIGNATION FROM EMPLOYEES WHERE DESIGNATION = 'Manager'
UNION
SELECT EMP_NAME, DESIGNATION FROM EMPLOYEES WHERE DESIGNATION = 'Intern'
ORDER BY DESIGNATION, EMP_NAME;
```

### Q18. Using a subquery, find the names and salaries of employees whose salary is above the average salary across all employees.

```sql
-- Q18: Subquery - employees with salary above average
SELECT EMP_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC;
```

### Q19. Create a VIEW called `employee_stats` showing emp_id, emp_name, total_hours, and projects_count for every employee.

```sql
-- Q19: VIEW employee_stats
CREATE OR REPLACE VIEW employee_stats AS
SELECT E.EMP_ID,
       E.EMP_NAME,
       COALESCE(SUM(EP.HOURS_WORKED), 0) AS TOTAL_HOURS,
       COUNT(EP.ASSIGNMENT_ID) AS PROJECTS_COUNT
FROM EMPLOYEES E
LEFT JOIN EMPLOYEE_PROJECTS EP ON E.EMP_ID = EP.EMP_ID
GROUP BY E.EMP_ID, E.EMP_NAME;

SELECT * FROM employee_stats ORDER BY EMP_ID;
```

### Q20. Create an INDEX called `idx_dept_id` on `employees(dept_id)`.

```sql
-- Q20: INDEX idx_dept_id
CREATE INDEX idx_dept_id ON EMPLOYEES(DEPT_ID);

SHOW INDEX FROM EMPLOYEES WHERE Key_name = 'idx_dept_id';
```


## Advanced (Q21–Q30)

### Q21. Using a correlated subquery, find the employee with the most hours worked on each project.

```sql
-- Q21: Correlated subquery - employee with most hours worked on each project
SELECT EP.PROJECT_ID, E.EMP_NAME, EP.HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E ON E.EMP_ID = EP.EMP_ID
WHERE EP.HOURS_WORKED = (
    SELECT MAX(EP2.HOURS_WORKED)
    FROM EMPLOYEE_PROJECTS EP2
    WHERE EP2.PROJECT_ID = EP.PROJECT_ID
)
ORDER BY EP.PROJECT_ID;
```

### Q22. Using multiple JOINs, list project_name, dept_name, and total hours logged against each project (include projects with zero hours logged, if any).

```sql
-- Q22: Multiple JOINs - project_name, dept_name, total hours logged (include zero-hour projects)
SELECT P.PROJECT_NAME, D.DEPT_NAME, COALESCE(SUM(EP.HOURS_WORKED), 0) AS TOTAL_HOURS
FROM PROJECTS P
JOIN DEPARTMENTS D ON P.DEPT_ID = D.DEPT_ID
LEFT JOIN EMPLOYEE_PROJECTS EP ON P.PROJECT_ID = EP.PROJECT_ID
GROUP BY P.PROJECT_ID, P.PROJECT_NAME, D.DEPT_NAME
ORDER BY P.PROJECT_ID;
```

### Q23. Using UNION ALL, combine (a) all employee_projects rows with hours_worked > 100 and (b) all employee_projects rows with hours_worked < 30 — duplicates allowed. Show employee name, project_id, hours.

```sql
-- Q23: UNION ALL - hours > 100 and hours < 30
SELECT E.EMP_NAME, EP.PROJECT_ID, EP.HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E ON E.EMP_ID = EP.EMP_ID
WHERE EP.HOURS_WORKED > 100
UNION ALL
SELECT E.EMP_NAME, EP.PROJECT_ID, EP.HOURS_WORKED
FROM EMPLOYEE_PROJECTS EP
JOIN EMPLOYEES E ON E.EMP_ID = EP.EMP_ID
WHERE EP.HOURS_WORKED < 30
ORDER BY HOURS_WORKED DESC;
```

### Q24. Using JOIN + GROUP BY + HAVING, find departments with `total_projects` greater than 1.

```sql
-- Q24: JOIN + GROUP BY + HAVING - departments with total_projects > 1 (computed from PROJECTS table)
SELECT D.DEPT_NAME, COUNT(P.PROJECT_ID) AS TOTAL_PROJECTS
FROM DEPARTMENTS D
JOIN PROJECTS P ON D.DEPT_ID = P.DEPT_ID
GROUP BY D.DEPT_NAME
HAVING COUNT(P.PROJECT_ID) > 1;
```

### Q25. Using a subquery with MAX(), find the department(s) with the highest `total_projects`.

```sql
-- Q25: Subquery with MAX() - department(s) with highest total_projects
SELECT D.DEPT_NAME, COUNT(P.PROJECT_ID) AS TOTAL_PROJECTS
FROM DEPARTMENTS D
JOIN PROJECTS P ON D.DEPT_ID = P.DEPT_ID
GROUP BY D.DEPT_NAME
HAVING COUNT(P.PROJECT_ID) = (
    SELECT MAX(project_count)
    FROM (
        SELECT COUNT(PROJECT_ID) AS project_count
        FROM PROJECTS
        GROUP BY DEPT_ID
    ) AS counts
);
```

### Q26. Demonstrate a TRANSACTION: move `Rahul Mehta` (emp_id 3) from Engineering to Marketing, verify with a SELECT, then COMMIT. Explain what ROLLBACK would have done instead.

```sql
-- Q26: TRANSACTION - move Rahul Mehta (emp_id 3) from Engineering to Marketing
START TRANSACTION;

UPDATE EMPLOYEES
SET DEPT_ID = 2
WHERE EMP_ID = 3;

SELECT EMP_ID, EMP_NAME, DEPT_ID FROM EMPLOYEES WHERE EMP_ID = 3;

COMMIT;

SELECT EMP_ID, EMP_NAME, DEPT_ID FROM EMPLOYEES WHERE EMP_ID = 3;
```

### Q27. Create a STORED PROCEDURE `GetEmployeeProjects(IN p_emp_id INT)` that returns all project assignments for a given employee. Call it for emp_id = 1.

```sql
-- Q27: Stored procedure GetEmployeeProjects
DROP PROCEDURE IF EXISTS GetEmployeeProjects;

DELIMITER //
CREATE PROCEDURE GetEmployeeProjects(IN p_emp_id INT)
BEGIN
    SELECT E.EMP_NAME, EP.PROJECT_ID, P.PROJECT_NAME, EP.HOURS_WORKED
    FROM EMPLOYEE_PROJECTS EP
    JOIN EMPLOYEES E ON E.EMP_ID = EP.EMP_ID
    JOIN PROJECTS P ON P.PROJECT_ID = EP.PROJECT_ID
    WHERE EP.EMP_ID = p_emp_id;
END //
DELIMITER ;

CALL GetEmployeeProjects(1);
```

### Q28. Create a TRIGGER `trg_update_dept_projects` that automatically increments the relevant department's `total_projects` whenever a new row is inserted into `projects`. Demonstrate it by inserting a new project into HR (dept_id 4): `Payroll System Upgrade`, budget 150000, start `2025-05-01`, end `2025-08-31`.

```sql
-- Q28: Trigger trg_update_dept_projects
DROP TRIGGER IF EXISTS trg_update_dept_projects;

DELIMITER //
CREATE TRIGGER trg_update_dept_projects
AFTER INSERT ON PROJECTS
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENTS
    SET TOTAL_PROJECTS = TOTAL_PROJECTS + 1
    WHERE DEPT_ID = NEW.DEPT_ID;
END //
DELIMITER ;

INSERT INTO PROJECTS (PROJECT_NAME, DEPT_ID, BUDGET, START_DATE, END_DATE)
VALUES ('Payroll System Upgrade', 4, 150000, '2025-05-01', '2025-08-31');

SELECT * FROM DEPARTMENTS WHERE DEPT_ID = 4;
```

### Q29. Create a STORED PROCEDURE `AddProject(...)` that inserts a new project row, relying on the Q28 trigger to update `total_projects` automatically. Use it to add `Social Media Campaign` to Marketing (dept_id 2), budget 250000, start `2025-06-01`, end `2025-09-30`. Wrap the call in a transaction.

```sql
-- Q29: Stored procedure AddProject relying on Q28 trigger
DROP PROCEDURE IF EXISTS AddProject;

DELIMITER //
CREATE PROCEDURE AddProject(
    IN p_project_name VARCHAR(100),
    IN p_dept_id INT,
    IN p_budget INT,
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    INSERT INTO PROJECTS (PROJECT_NAME, DEPT_ID, BUDGET, START_DATE, END_DATE)
    VALUES (p_project_name, p_dept_id, p_budget, p_start_date, p_end_date);
END //
DELIMITER ;

START TRANSACTION;
CALL AddProject('Social Media Campaign', 2, 250000, '2025-06-01', '2025-09-30');
COMMIT;

SELECT * FROM DEPARTMENTS WHERE DEPT_ID = 2;
SELECT * FROM PROJECTS WHERE PROJECT_NAME = 'Social Media Campaign';
```

### Q30. Using JOIN + subquery + GROUP BY, find the employee with the highest total hours worked in each department (remember: Rahul Mehta moved departments in Q26 — his hours move with him).

```sql
-- Q30: Employee with highest total hours worked in each department (Rahul moved dept in Q26)
SELECT D.DEPT_NAME, E.EMP_NAME, ET.TOTAL_HOURS
FROM (
    SELECT E.DEPT_ID, E.EMP_ID, SUM(EP.HOURS_WORKED) AS TOTAL_HOURS
    FROM EMPLOYEES E
    JOIN EMPLOYEE_PROJECTS EP ON E.EMP_ID = EP.EMP_ID
    GROUP BY E.DEPT_ID, E.EMP_ID
) ET
JOIN EMPLOYEES E ON E.EMP_ID = ET.EMP_ID
JOIN DEPARTMENTS D ON D.DEPT_ID = ET.DEPT_ID
WHERE ET.TOTAL_HOURS = (
    SELECT MAX(ET2.TOTAL_HOURS)
    FROM (
        SELECT E2.DEPT_ID, E2.EMP_ID, SUM(EP2.HOURS_WORKED) AS TOTAL_HOURS
        FROM EMPLOYEES E2
        JOIN EMPLOYEE_PROJECTS EP2 ON E2.EMP_ID = EP2.EMP_ID
        GROUP BY E2.DEPT_ID, E2.EMP_ID
    ) ET2
    WHERE ET2.DEPT_ID = ET.DEPT_ID
)
ORDER BY D.DEPT_NAME;
```
