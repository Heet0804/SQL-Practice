# Company Project Tracker SQL Practice — Questions

IMPORTANT: These questions must be solved IN ORDER (Q1 -> Q30) against a real
database, because Q4, Q5, Q6, Q7, Q26, Q28, and Q29 permanently change the
data. Every question after one of those reflects the changed state, not the
original data. The expected outputs in `expected_outputs.md` already account
for this — they are what you should see if you run every query in order,
starting from a fresh load of the 5 base files.

## Basic (Q1–Q10)

1. List the department name and location for departments located in "Bangalore" or "Mumbai".
2. List all employee names and designations, sorted alphabetically by employee name.
3. List the project name and budget for all projects with a budget greater than 300000.
4. Insert a new employee: `Aakash Iyer`, dept_id 1, designation `Intern`, salary 22000, date_of_joining `2024-03-15`.
5. Update the salary of `Priya Nair` to 25000.
6. Delete the employee_projects row for project_id 6, emp_id 4.
7. Add a new column `email` (VARCHAR(100), nullable) to the `employees` table.
8. Find the number of employees in each department (team name + count).
9. Find all employees who joined after the year 2020 (use a date/year function).
10. Find all distinct designations that exist in the `employees` table.

## Intermediate (Q11–Q20)

11. Using an INNER JOIN, list every employee's name, designation, and department name.
12. Using a LEFT JOIN, find every employee who has never been assigned to any project.
13. Using a SELF JOIN on `employees`, list every unique pair of employees who work in the same department.
14. Using JOIN + GROUP BY, calculate total hours worked by each employee who has at least one project assignment.
15. Find every instance of an employee working more than 100 hours on a single project — show employee name, project_id, hours.
16. Using GROUP BY and HAVING, find departments with more than 4 employees.
17. Using UNION, produce one combined list of names of all Managers and all Interns.
18. Using a subquery, find the names and salaries of employees whose salary is above the average salary across all employees.
19. Create a VIEW called `employee_stats` showing emp_id, emp_name, total_hours, and projects_count for every employee.
20. Create an INDEX called `idx_dept_id` on `employees(dept_id)`.

## Advanced (Q21–Q30)

21. Using a correlated subquery, find the employee with the most hours worked on each project.
22. Using multiple JOINs, list project_name, dept_name, and total hours logged against each project (include projects with zero hours logged, if any).
23. Using UNION ALL, combine (a) all employee_projects rows with hours_worked > 100 and (b) all employee_projects rows with hours_worked < 30 — duplicates allowed. Show employee name, project_id, hours.
24. Using JOIN + GROUP BY + HAVING, find departments with `total_projects` greater than 1.
25. Using a subquery with MAX(), find the department(s) with the highest `total_projects`.
26. Demonstrate a TRANSACTION: move `Rahul Mehta` (emp_id 3) from Engineering to Marketing, verify with a SELECT, then COMMIT. Explain what ROLLBACK would have done instead.
27. Create a STORED PROCEDURE `GetEmployeeProjects(IN p_emp_id INT)` that returns all project assignments for a given employee. Call it for emp_id = 1.
28. Create a TRIGGER `trg_update_dept_projects` that automatically increments the relevant department's `total_projects` whenever a new row is inserted into `projects`. Demonstrate it by inserting a new project into HR (dept_id 4): `Payroll System Upgrade`, budget 150000, start `2025-05-01`, end `2025-08-31`.
29. Create a STORED PROCEDURE `AddProject(...)` that inserts a new project row, relying on the Q28 trigger to update `total_projects` automatically. Use it to add `Social Media Campaign` to Marketing (dept_id 2), budget 250000, start `2025-06-01`, end `2025-09-30`. Wrap the call in a transaction.
30. Using JOIN + subquery + GROUP BY, find the employee with the highest total hours worked in each department (remember: Rahul Mehta moved departments in Q26 — his hours move with him).
