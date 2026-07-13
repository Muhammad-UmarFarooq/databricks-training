-- Problem 8: Join Queries

-- Q36.Select employee names along with their department names
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id;

-- Q37.Select project names along with the department names they belong to
SELECT p.name AS project_name, d.name AS department_name
FROM Project p
JOIN Department d
ON p.department_id = d.department_id;

-- Q38.Select employee names and their corresponding project names
SELECT e.name AS employee_name, p.name AS project_name
FROM Employee e
JOIN Project p
ON e.department_id = p.department_id;

-- Q39.Select all employees and their departments, including those without a department
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id;

-- Q40.Select all departments and their employees, including departments without employees
SELECT d.name AS department_name, e.name AS employee_name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- Q41.Select employees who are not assigned to any project
SELECT e.name
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- Q42.Select employees and the number of projects their department is working on
SELECT e.name AS employee_name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
GROUP BY e.name;

-- Q43.Select the departments that have no employees
SELECT d.name AS department_name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- Q44.Select employee names who share the same department with 'John Doe'
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'John Doe'
)
AND name <> 'John Doe';

-- Q45.Select the department name with the highest average salary
SELECT d.name AS department_name, AVG(e.salary) AS average_salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY average_salary DESC
LIMIT 1;

-- Problem 9: Nested and Correlated Queries

-- Q46.Select the employee with the highest salary
SELECT *
FROM Employee
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
);

-- Q47.Select employees whose salary is above the average salary
SELECT *
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);

-- Q48.Select the second highest salary from the Employee table
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);

-- Q49.Select the department with the most employees
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Q50.Select employees who earn more than the average salary of their department
SELECT *
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Q51.Select the nth highest salary (for example, 3rd highest)
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- Q52.Select employees who are older than all employees in the HR department
SELECT *
FROM Employee
WHERE age > ALL (
    SELECT e.age
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    WHERE d.name = 'HR'
);

-- Q53.Select departments where the average salary is greater than 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Q54.Select employees who work in a department with at least 2 projects
SELECT *
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) >= 2
);

-- Q55.Select employees who were hired on the same date as 'Jane Smith'
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    WHERE name = 'Jane Smith'
)
AND name <> 'Jane Smith';

-- Problem 10: Combined Moderate Difficulty Queries

-- Q56.Select the total salary of employees hired in the year 2020
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- Q57.Select the average salary of employees in each department, ordered by the average salary in descending order
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC;

-- Q58.Select departments with more than 1 employee and an average salary greater than 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1
AND AVG(salary) > 55000;

-- Q59.Select employees hired in the last 2 years, ordered by their hire date
SELECT *
FROM Employee
WHERE hire_date >= CURRENT_DATE - INTERVAL 2 YEARS
ORDER BY hire_date;

-- Q60.Select the total number of employees and the average salary for departments with more than 2 employees
SELECT department_id,
       COUNT(*) AS total_employees,
       AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Q61.Select the name and salary of employees whose salary is above the average salary of their department
SELECT name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Q62.Select the names of employees who are hired on the same date as the oldest employee in the company
SELECT name
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    ORDER BY age DESC
    LIMIT 1
);

-- Q63.Select the department names along with the total number of projects they are working on, ordered by the number of projects
SELECT d.name AS department_name,
       COUNT(p.project_id) AS total_projects
FROM Department d
LEFT JOIN Project p
ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY total_projects DESC;

-- Q64.Select the employee name with the highest salary in each department
SELECT e.name, e.department_id, e.salary
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Q65.Select the names and salaries of employees who are older than the average age of employees in their department
SELECT name, salary
FROM Employee e
WHERE age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Problem 1: SQL Joins Assignment

-- Q1.Display all students and the courses they are enrolled in. Include students who are not enrolled in any course.
SELECT s.student_name, c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id;

-- Q2.Find all courses that currently have no students enrolled.
SELECT c.course_id, c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.student_id IS NULL;

-- Q3.Display all instructors and the courses they teach, including instructors who are not assigned to any course.
SELECT i.instructor_name, c.course_name
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id = c.instructor_id;

-- Q4.Find all courses that do not have an instructor assigned.
SELECT *
FROM courses
WHERE instructor_id IS NULL;

-- Q5.Display all students and enrollment information using a RIGHT JOIN.
SELECT s.student_name, e.course_id, e.enrollment_date
FROM enrollments e
RIGHT JOIN students s
ON e.student_id = s.student_id;

-- Q6.Find students who are not enrolled in any course.
SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- Q7.Use a FULL OUTER JOIN to display all students and enrollments, including unmatched rows from both tables.
SELECT s.student_name,
       e.course_id,
       e.enrollment_date
FROM students s
FULL OUTER JOIN enrollments e
ON s.student_id = e.student_id;

-- Q8.Find all courses that have never appeared in the enrollments table.
SELECT c.course_id, c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

-- Q9.Display all instructors and courses using a FULL OUTER JOIN and identify unmatched rows.
SELECT i.instructor_name,
       c.course_name
FROM instructors i
FULL OUTER JOIN courses c
ON i.instructor_id = c.instructor_id;

-- Q10.Create a report showing student name, course name, and instructor name. Include rows even if course or instructor information is missing.
SELECT s.student_name,
       c.course_name,
       i.instructor_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id
LEFT JOIN instructors i
ON c.instructor_id = i.instructor_id;
