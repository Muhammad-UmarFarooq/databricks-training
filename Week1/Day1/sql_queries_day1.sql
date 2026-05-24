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
