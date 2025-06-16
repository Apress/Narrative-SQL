
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT
);


INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'John', 70000, 1),
(2, 'Alice', 80000, 2),
(3, 'Bob', 60000, 1),
(4, 'Emma', 90000, 3),
(5, 'Michael', 55000, 2);



CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO departments (id, name) VALUES
(1, 'IT'),
(2, 'Sales'),
(3, 'Marketing');


SELECT * FROM  employees;

SELECT * FROM  departments;


SELECT name  
FROM employees  
WHERE salary = (SELECT MAX(salary) FROM employees); 

SELECT name  
FROM employees  
WHERE department_id IN (SELECT id FROM departments WHERE name = 'Sales'); 

SELECT emp.name  
FROM employees AS emp  
WHERE emp.salary > ( 
    SELECT AVG(sub_emp.salary)  
    FROM employees AS sub_emp  
    WHERE sub_emp.department_id = emp.department_id 
); 


