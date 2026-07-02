-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert data into Department table
INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert data into Employee table
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

-- Insert data into Project table
INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);

-- Problem 1: Basic Queries

-- Query 1: Select all columns from Employee table
SELECT *
FROM Employee;

-- Q2: Select only name and salary columns
SELECT name, salary
FROM Employee;

-- Q3: Select employees older than 30
SELECT *
FROM Employee
WHERE age > 30;
            
-- Q4: Select names of all departments
SELECT name
FROM Department;

-- Q5: Select employees who work in IT department
SELECT e.*
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
WHERE d.name = 'IT';

-- Problem 2: String Matching Queries

-- Q6.Select employees whose names start with 'J'
SELECT *
FROM Employee
WHERE name LIKE 'J%';

-- Q7.Select employees whose names end with 'e'
SELECT *
FROM Employee
WHERE name LIKE '%e';

-- Q8.Select employees whose names contain 'a'
SELECT *
FROM Employee
WHERE name LIKE '%a%';

-- Q9.Select employees whose names are exactly 9 characters long
SELECT *
FROM Employee
WHERE name LIKE '_________';

-- Q10.Select employees whose names have 'o' as the second character
SELECT *
FROM Employee
WHERE name LIKE '_o%';

-- Problem 3: Date Queries

-- Q11.Select employees hired in the year 2020
SELECT *
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- Q12.Select employees hired in January of any year
SELECT *
FROM Employee
WHERE MONTH(hire_date) = 1;

-- Q13.Select employees hired before 2019
SELECT *
FROM Employee
WHERE YEAR(hire_date) < 2019;

-- Q14.Select employees hired on or after March 1, 2021
SELECT *
FROM Employee
WHERE hire_date >= '2021-03-01';

-- Q15.Select employees hired in the last 2 years
SELECT *
FROM Employee
WHERE hire_date >= CURRENT_DATE - INTERVAL 2 YEAR;

-- Problem 4: Aggregate Queries

-- Q16.Select the total salary of all employees
SELECT SUM(salary) AS total_salary
FROM Employee;

-- Q17.Select the average salary of employees
SELECT AVG(salary) AS average_salary
FROM Employee;

-- Q18.Select the minimum salary in the Employee table
SELECT MIN(salary) AS minimum_salary
FROM Employee;

-- Q19.Select the number of employees in each department
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id;

-- Q20.Select the average salary of employees in each department
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id;

-- Problem 5: Group By Queries

-- Q21.Select the total salary for each department
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;

-- Q22.Select the average age of employees in each department
SELECT department_id, AVG(age) AS average_age
FROM Employee
GROUP BY department_id;

-- Q23.Select the number of employees hired in each year
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date);

-- Q24.Select the highest salary in each department
SELECT department_id, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;

-- Q25.Select the department with the highest average salary
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 1;

-- Q26.Select departments with more than 2 employees
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Q27.Select departments with an average salary greater than 55000
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Q28.Select years with more than 1 employee hired
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- Q29.Select departments with a total salary expense less than 100000
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- Q30.Select departments with the maximum salary above 75000
SELECT department_id, MAX(salary) AS maximum_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;

-- Problem 7: Order By Queries

-- Q31.Select all employees ordered by their salary in ascending order
SELECT *
FROM Employee
ORDER BY salary ASC;

-- Q32.Select all employees ordered by their age in descending order
SELECT *
FROM Employee
ORDER BY age DESC;

-- Q33.Select all employees ordered by their hire date in ascending order
SELECT *
FROM Employee
ORDER BY hire_date ASC;

-- Q34.Select employees ordered by their department and then by their salary
SELECT *
FROM Employee
ORDER BY department_id ASC, salary ASC;

-- Q35.Select departments ordered by the total salary of their employees
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary DESC;

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
