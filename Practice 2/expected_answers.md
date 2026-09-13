# Company Project Tracker — Expected Outputs

These are the actual outputs produced by running every query in `queries.md`, in order, starting from a fresh load of `departments.sql`, `employees.sql`, `projects.sql`, and `employee_projects.sql` on a MariaDB 10.11 instance. Because Q4, Q5, Q6, Q7, Q26, Q28, and Q29 change the data or schema, later results already reflect those changes — run the queries in this same order to reproduce them.


## Basic (Q1–Q10)

### Q1. List the department name and location for departments located in "Bangalore" or "Mumbai".

| DEPT_NAME | LOCATION |
|---|---|
| ENGINEERING | BANGALORE |
| MARKETING | MUMBAI |

### Q2. List all employee names and designations, sorted alphabetically by employee name.

| EMP_NAME | DESIGNATION |
|---|---|
| ADITYA RAO | MANAGER |
| AMIT BHATIA | SENIOR EXECUTIVE |
| ARJUN SINGH | EXECUTIVE |
| DIVYA REDDY | SENIOR EXECUTIVE |
| KAVYA IYER | INTERN |
| KUNAL VERMA | MANAGER |
| MEERA JOSHI | INTERN |
| NEHA SHARMA | SENIOR EXECUTIVE |
| POOJA DESAI | EXECUTIVE |
| PRIYA NAIR | INTERN |
| RAHUL MEHTA | EXECUTIVE |
| ROHAN MALHOTRA | EXECUTIVE |
| SANJANA RAO | MANAGER |
| SNEHA KAPOOR | SENIOR EXECUTIVE |
| VARUN KAPOOR | INTERN |
| VIKAS GUPTA | MANAGER |

### Q3. List the project name and budget for all projects with a budget greater than 300000.

| PROJECT_NAME | BUDGET |
|---|---|
| WEBSITE REVAMP | 500000 |
| MOBILE APP | 800000 |
| CLOUD MIGRATION | 650000 |

### Q4. Insert a new employee: `Aakash Iyer`, dept_id 1, designation `Intern`, salary 22000, date_of_joining `2024-03-15`.

| EMP_ID | EMP_NAME | DEPT_ID | DESIGNATION | SALARY | DATE_OF_JOINING |
|---|---|---|---|---|---|
| 17 | Aakash Iyer | 1 | Intern | 22000 | 2024-03-15 |

> **Data change:** a new row (emp_id 17) is inserted into `EMPLOYEES`. It appears in all later queries (Q8, Q9, Q11, Q12, Q13, Q17, Q19).

### Q5. Update the salary of `Priya Nair` to 25000.

| EMP_NAME | SALARY |
|---|---|
| PRIYA NAIR | 25000 |

> **Data change:** Priya Nair's salary is now 25000 in all later queries (e.g. Q18's average).

### Q6. Delete the employee_projects row for project_id 6, emp_id 4.

| ASSIGNMENT_ID | EMP_ID | PROJECT_ID | HOURS_WORKED |
|---|---|---|---|
| 15 | 1 | 6 | 20 |
| 16 | 3 | 6 | 110 |

> **Data change:** the row (emp_id 4, project_id 6, 95 hrs) is permanently removed. Aditya Rao (emp 1) and Rahul Mehta (emp 3) remain on project 6.

### Q7. Add a new column `email` (VARCHAR(100), nullable) to the `employees` table.

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| EMP_ID | int(11) | NO | PRI | NULL | auto_increment |
| EMP_NAME | varchar(50) | NO |  | NULL |  |
| DEPT_ID | int(11) | YES | MUL | NULL |  |
| DESIGNATION | varchar(50) | NO |  | NULL |  |
| SALARY | int(11) | YES |  | NULL |  |
| DATE_OF_JOINING | date | YES |  | NULL |  |
| EMAIL | varchar(100) | YES |  | NULL |  |

> **Schema change:** `EMPLOYEES` now has an `EMAIL` column (NULL for all existing rows) for the rest of the session.

### Q8. Find the number of employees in each department (team name + count).

| TEAM_NAME | EMPLOYEE_COUNT |
|---|---|
| ENGINEERING | 5 |
| HR | 4 |
| MARKETING | 4 |
| SALES | 4 |

### Q9. Find all employees who joined after the year 2020 (use a date/year function).

| EMP_NAME | DATE_OF_JOINING |
|---|---|
| ROHAN MALHOTRA | 2021-04-18 |
| POOJA DESAI | 2021-11-11 |
| MEERA JOSHI | 2023-01-10 |
| PRIYA NAIR | 2023-06-01 |
| KAVYA IYER | 2023-09-01 |
| VARUN KAPOOR | 2024-01-15 |
| Aakash Iyer | 2024-03-15 |

### Q10. Find all distinct designations that exist in the `employees` table.

| DESIGNATION |
|---|
| EXECUTIVE |
| INTERN |
| MANAGER |
| SENIOR EXECUTIVE |


## Intermediate (Q11–Q20)

### Q11. Using an INNER JOIN, list every employee's name, designation, and department name.

| EMP_NAME | DESIGNATION | DEPT_NAME |
|---|---|---|
| ADITYA RAO | MANAGER | ENGINEERING |
| NEHA SHARMA | SENIOR EXECUTIVE | ENGINEERING |
| RAHUL MEHTA | EXECUTIVE | ENGINEERING |
| PRIYA NAIR | INTERN | ENGINEERING |
| KUNAL VERMA | MANAGER | MARKETING |
| SNEHA KAPOOR | SENIOR EXECUTIVE | MARKETING |
| ARJUN SINGH | EXECUTIVE | MARKETING |
| MEERA JOSHI | INTERN | MARKETING |
| VIKAS GUPTA | MANAGER | SALES |
| DIVYA REDDY | SENIOR EXECUTIVE | SALES |
| ROHAN MALHOTRA | EXECUTIVE | SALES |
| KAVYA IYER | INTERN | SALES |
| SANJANA RAO | MANAGER | HR |
| AMIT BHATIA | SENIOR EXECUTIVE | HR |
| POOJA DESAI | EXECUTIVE | HR |
| VARUN KAPOOR | INTERN | HR |
| Aakash Iyer | Intern | ENGINEERING |

### Q12. Using a LEFT JOIN, find every employee who has never been assigned to any project.

| EMP_ID | EMP_NAME |
|---|---|
| 8 | MEERA JOSHI |
| 12 | KAVYA IYER |
| 15 | POOJA DESAI |
| 16 | VARUN KAPOOR |
| 17 | Aakash Iyer |

### Q13. Using a SELF JOIN on `employees`, list every unique pair of employees who work in the same department.

| EMPLOYEE_1 | EMPLOYEE_2 | DEPT_ID |
|---|---|---|
| ADITYA RAO | Aakash Iyer | 1 |
| ADITYA RAO | NEHA SHARMA | 1 |
| ADITYA RAO | PRIYA NAIR | 1 |
| ADITYA RAO | RAHUL MEHTA | 1 |
| NEHA SHARMA | Aakash Iyer | 1 |
| NEHA SHARMA | PRIYA NAIR | 1 |
| NEHA SHARMA | RAHUL MEHTA | 1 |
| PRIYA NAIR | Aakash Iyer | 1 |
| RAHUL MEHTA | Aakash Iyer | 1 |
| RAHUL MEHTA | PRIYA NAIR | 1 |
| ARJUN SINGH | MEERA JOSHI | 2 |
| KUNAL VERMA | ARJUN SINGH | 2 |
| KUNAL VERMA | MEERA JOSHI | 2 |
| KUNAL VERMA | SNEHA KAPOOR | 2 |
| SNEHA KAPOOR | ARJUN SINGH | 2 |
| SNEHA KAPOOR | MEERA JOSHI | 2 |
| DIVYA REDDY | KAVYA IYER | 3 |
| DIVYA REDDY | ROHAN MALHOTRA | 3 |
| ROHAN MALHOTRA | KAVYA IYER | 3 |
| VIKAS GUPTA | DIVYA REDDY | 3 |
| VIKAS GUPTA | KAVYA IYER | 3 |
| VIKAS GUPTA | ROHAN MALHOTRA | 3 |
| AMIT BHATIA | POOJA DESAI | 4 |
| AMIT BHATIA | VARUN KAPOOR | 4 |
| POOJA DESAI | VARUN KAPOOR | 4 |
| SANJANA RAO | AMIT BHATIA | 4 |
| SANJANA RAO | POOJA DESAI | 4 |
| SANJANA RAO | VARUN KAPOOR | 4 |

### Q14. Using JOIN + GROUP BY, calculate total hours worked by each employee who has at least one project assignment.

| EMP_ID | EMP_NAME | TOTAL_HOURS |
|---|---|---|
| 1 | ADITYA RAO | 60 |
| 2 | NEHA SHARMA | 270 |
| 3 | RAHUL MEHTA | 350 |
| 4 | PRIYA NAIR | 60 |
| 5 | KUNAL VERMA | 30 |
| 6 | SNEHA KAPOOR | 90 |
| 7 | ARJUN SINGH | 85 |
| 9 | VIKAS GUPTA | 35 |
| 10 | DIVYA REDDY | 95 |
| 11 | ROHAN MALHOTRA | 88 |
| 13 | SANJANA RAO | 25 |
| 14 | AMIT BHATIA | 70 |

### Q15. Find every instance of an employee working more than 100 hours on a single project — show employee name, project_id, hours.

| EMP_NAME | PROJECT_ID | HOURS_WORKED |
|---|---|---|
| NEHA SHARMA | 2 | 150 |
| RAHUL MEHTA | 2 | 140 |
| NEHA SHARMA | 1 | 120 |
| RAHUL MEHTA | 6 | 110 |

### Q16. Using GROUP BY and HAVING, find departments with more than 4 employees.

| DEPT_NAME | EMPLOYEE_COUNT |
|---|---|
| ENGINEERING | 5 |

### Q17. Using UNION, produce one combined list of names of all Managers and all Interns.

| EMP_NAME | DESIGNATION |
|---|---|
| Aakash Iyer | Intern |
| KAVYA IYER | INTERN |
| MEERA JOSHI | INTERN |
| PRIYA NAIR | INTERN |
| VARUN KAPOOR | INTERN |
| ADITYA RAO | MANAGER |
| KUNAL VERMA | MANAGER |
| SANJANA RAO | MANAGER |
| VIKAS GUPTA | MANAGER |

### Q18. Using a subquery, find the names and salaries of employees whose salary is above the average salary across all employees.

| EMP_NAME | SALARY |
|---|---|
| ADITYA RAO | 95000 |
| KUNAL VERMA | 90000 |
| VIKAS GUPTA | 88000 |
| SANJANA RAO | 80000 |
| NEHA SHARMA | 65000 |
| RAHUL MEHTA | 62000 |
| DIVYA REDDY | 58000 |

### Q19. Create a VIEW called `employee_stats` showing emp_id, emp_name, total_hours, and projects_count for every employee.

| EMP_ID | EMP_NAME | TOTAL_HOURS | PROJECTS_COUNT |
|---|---|---|---|
| 1 | ADITYA RAO | 60 | 2 |
| 2 | NEHA SHARMA | 270 | 2 |
| 3 | RAHUL MEHTA | 350 | 3 |
| 4 | PRIYA NAIR | 60 | 1 |
| 5 | KUNAL VERMA | 30 | 1 |
| 6 | SNEHA KAPOOR | 90 | 1 |
| 7 | ARJUN SINGH | 85 | 1 |
| 8 | MEERA JOSHI | 0 | 0 |
| 9 | VIKAS GUPTA | 35 | 1 |
| 10 | DIVYA REDDY | 95 | 1 |
| 11 | ROHAN MALHOTRA | 88 | 1 |
| 12 | KAVYA IYER | 0 | 0 |
| 13 | SANJANA RAO | 25 | 1 |
| 14 | AMIT BHATIA | 70 | 1 |
| 15 | POOJA DESAI | 0 | 0 |
| 16 | VARUN KAPOOR | 0 | 0 |
| 17 | Aakash Iyer | 0 | 0 |

### Q20. Create an INDEX called `idx_dept_id` on `employees(dept_id)`.

| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Ignored |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| EMPLOYEES | 1 | idx_dept_id | 1 | DEPT_ID | A | 8 | NULL | NULL | YES | BTREE |  |  | NO |


## Advanced (Q21–Q30)

### Q21. Using a correlated subquery, find the employee with the most hours worked on each project.

| PROJECT_ID | EMP_NAME | HOURS_WORKED |
|---|---|---|
| 1 | NEHA SHARMA | 120 |
| 2 | NEHA SHARMA | 150 |
| 3 | SNEHA KAPOOR | 90 |
| 4 | DIVYA REDDY | 95 |
| 5 | AMIT BHATIA | 70 |
| 6 | RAHUL MEHTA | 110 |

### Q22. Using multiple JOINs, list project_name, dept_name, and total hours logged against each project (include projects with zero hours logged, if any).

| PROJECT_NAME | DEPT_NAME | TOTAL_HOURS |
|---|---|---|
| WEBSITE REVAMP | ENGINEERING | 260 |
| MOBILE APP | ENGINEERING | 350 |
| AD CAMPAIGN Q1 | MARKETING | 205 |
| PRODUCT LAUNCH | SALES | 218 |
| ONBOARDING REVAMP | HR | 95 |
| CLOUD MIGRATION | ENGINEERING | 130 |

### Q23. Using UNION ALL, combine (a) all employee_projects rows with hours_worked > 100 and (b) all employee_projects rows with hours_worked < 30 — duplicates allowed. Show employee name, project_id, hours.

| EMP_NAME | PROJECT_ID | HOURS_WORKED |
|---|---|---|
| NEHA SHARMA | 2 | 150 |
| RAHUL MEHTA | 2 | 140 |
| NEHA SHARMA | 1 | 120 |
| RAHUL MEHTA | 6 | 110 |
| SANJANA RAO | 5 | 25 |
| ADITYA RAO | 6 | 20 |

### Q24. Using JOIN + GROUP BY + HAVING, find departments with `total_projects` greater than 1.

| DEPT_NAME | TOTAL_PROJECTS |
|---|---|
| ENGINEERING | 3 |

### Q25. Using a subquery with MAX(), find the department(s) with the highest `total_projects`.

| DEPT_NAME | TOTAL_PROJECTS |
|---|---|
| ENGINEERING | 3 |

### Q26. Demonstrate a TRANSACTION: move `Rahul Mehta` (emp_id 3) from Engineering to Marketing, verify with a SELECT, then COMMIT. Explain what ROLLBACK would have done instead.

Result after UPDATE (inside transaction, before COMMIT):

| EMP_ID | EMP_NAME | DEPT_ID |
|---|---|---|
| 3 | RAHUL MEHTA | 2 |

Result after COMMIT (final, verified state):

| EMP_ID | EMP_NAME | DEPT_ID |
|---|---|---|
| 3 | RAHUL MEHTA | 2 |

> **Data change:** Rahul Mehta (emp_id 3) now belongs to dept_id 2 (Marketing), not dept_id 1 (Engineering), for all subsequent queries (see Q30). If `ROLLBACK` had been issued instead of `COMMIT`, the `UPDATE` would have been undone and Rahul Mehta would still show `DEPT_ID = 1` — the change made inside the transaction is never persisted to the table.

### Q27. Create a STORED PROCEDURE `GetEmployeeProjects(IN p_emp_id INT)` that returns all project assignments for a given employee. Call it for emp_id = 1.

| EMP_NAME | PROJECT_ID | PROJECT_NAME | HOURS_WORKED |
|---|---|---|---|
| ADITYA RAO | 1 | WEBSITE REVAMP | 40 |
| ADITYA RAO | 6 | CLOUD MIGRATION | 20 |

### Q28. Create a TRIGGER `trg_update_dept_projects` that automatically increments the relevant department's `total_projects` whenever a new row is inserted into `projects`. Demonstrate it by inserting a new project into HR (dept_id 4): `Payroll System Upgrade`, budget 150000, start `2025-05-01`, end `2025-08-31`.

| DEPT_ID | DEPT_NAME | LOCATION | TOTAL_PROJECTS |
|---|---|---|---|
| 4 | HR | PUNE | 2 |

> **Data change:** a new project (project_id 7, 'Payroll System Upgrade') is added to HR, and the trigger bumps `DEPARTMENTS.TOTAL_PROJECTS` for dept_id 4 from 1 to 2.

### Q29. Create a STORED PROCEDURE `AddProject(...)` that inserts a new project row, relying on the Q28 trigger to update `total_projects` automatically. Use it to add `Social Media Campaign` to Marketing (dept_id 2), budget 250000, start `2025-06-01`, end `2025-09-30`. Wrap the call in a transaction.

DEPARTMENTS row for Marketing (dept_id 2) after AddProject call:

| DEPT_ID | DEPT_NAME | LOCATION | TOTAL_PROJECTS |
|---|---|---|---|
| 2 | MARKETING | MUMBAI | 2 |

New PROJECTS row inserted:

| PROJECT_ID | PROJECT_NAME | DEPT_ID | BUDGET | START_DATE | END_DATE |
|---|---|---|---|---|---|
| 8 | Social Media Campaign | 2 | 250000 | 2025-06-01 | 2025-09-30 |

> **Data change:** a new project (project_id 8, 'Social Media Campaign') is added to Marketing, and the Q28 trigger bumps `DEPARTMENTS.TOTAL_PROJECTS` for dept_id 2 from 1 to 2 automatically.

### Q30. Using JOIN + subquery + GROUP BY, find the employee with the highest total hours worked in each department (remember: Rahul Mehta moved departments in Q26 — his hours move with him).

| DEPT_NAME | EMP_NAME | TOTAL_HOURS |
|---|---|---|
| ENGINEERING | NEHA SHARMA | 270 |
| HR | AMIT BHATIA | 70 |
| MARKETING | RAHUL MEHTA | 350 |
| SALES | DIVYA REDDY | 95 |
