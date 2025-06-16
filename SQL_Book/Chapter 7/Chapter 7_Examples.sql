CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    job_id VARCHAR(10),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, name, department_id, job_id, salary) VALUES
(101, 'Alice Johnson', 1, 'J001', 55000),
(102, 'Bob Smith', 2, 'J002', 48000),
(103, 'Charlie Davis', 1, 'J003', 60000),
(104, 'David Brown', 3, 'J004', 72000),
(105, 'Emma Wilson', 2, 'J001', 45000),
(106, 'Fiona Clark', 4, 'J005', 80000),
(107, 'George Miller', 1, 'J003', 61000),
(108, 'Hannah White', 4, 'J006', 85000),
(109, 'Ian Thompson', 3, 'J002', 70000),
(110, 'Julia Lewis', 2, 'J004', 52000);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

INSERT INTO departments (department_id, department_name, location) VALUES
(1, 'Sales', 'New York'),
(2, 'Marketing', 'Chicago'),
(3, 'IT', 'San Francisco'),
(4, 'HR', 'Boston'),
(5, 'Operations', 'Los Angeles'),
(6, 'Finance', 'New York'),
(7, 'Logistics', 'Chicago'),
(8, 'R&D', 'San Francisco'),
(9, 'Legal', 'Boston'),
(10, 'Customer Support', 'Los Angeles');


SELECT * FROM employees;

SELECT * FROM departments;

SELECT name  
FROM employees  
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Sales'); 

SELECT name  
FROM employees  
WHERE department_id IN (SELECT department_id FROM departments WHERE location = 'New York'); 


CREATE TABLE job_openings (
    department_id INT,
    job_id VARCHAR(10),
    status VARCHAR(10),
    PRIMARY KEY (department_id, job_id)
);

INSERT INTO job_openings (department_id, job_id, status) VALUES
(1, 'J003', 'Open'),
(4, 'J006', 'Open');


SELECT name  
FROM employees  
WHERE (department_id, job_id) IN (SELECT department_id, job_id FROM job_openings WHERE status = 'Open'); 

SELECT AVG(salary) 
FROM employees;

SELECT *
FROM employees;

SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;


SELECT e.name  
FROM employees e  
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id); 

SELECT  
    e.name, 
    e.department_id, 
    e.salary, 
    dept_avg.avg_department_salary, 
    CASE  
        WHEN e.salary > dept_avg.avg_department_salary THEN 'Above Average' 
        ELSE 'Below Average' 
    END AS salary_comparison 
FROM employees e 
JOIN ( 
    SELECT department_id, AVG(salary) AS avg_department_salary 
    FROM employees 
    GROUP BY department_id 
) dept_avg ON e.department_id = dept_avg.department_id; 


SELECT name  
FROM employees  
WHERE salary > (SELECT AVG(salary) FROM employees); 

SELECT department_name, avg_salary  
FROM (SELECT department_id, AVG(salary) AS avg_salary  
      FROM employees  
      GROUP BY department_id) AS dept_avg  
JOIN departments d ON dept_avg.department_id = d.department_id; 
