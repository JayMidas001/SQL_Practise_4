DROP DATABASE IF EXISTS `Test_4`;
CREATE DATABASE `Test_4`;
USE `Test_4`;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO employees (employee_id, first_name, department, salary) 
VALUES
    (1, 'Ada', 'Sales', 250000),
    (2, 'John', 'IT', 180000),
    (3, 'Mary', 'Sales', 220000),
    (4, 'James', 'HR', 150000),
    (5, 'Grace', 'IT', 200000),
    (6, 'Joseph', 'HR', 170000),
    (7, 'Peter', 'Marketing', 120000),
    (8, 'Sarah', 'Sales', 300000),
    (9, 'David', 'IT', 200000),
    (10, 'Esther', 'HR', 150000);
    
SELECT first_name, department, salary, AVG(salary) OVER() AS company_avg_salary
FROM employees;
    
SELECT first_name, department, salary, AVG(salary) OVER( PARTITION BY department) AS department_avg_salary
FROM employees;
    
SELECT first_name, department, salary, ROW_NUMBER () OVER(ORDER BY salary DESC)
FROM employees;
        
SELECT first_name, department, salary, RANK () OVER(ORDER BY salary DESC)
FROM employees;
    
SELECT first_name, department, salary, DENSE_RANK () OVER(ORDER BY salary DESC)
FROM employees;    
    
SELECT first_name, department, salary, RANK () OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;
    
SELECT first_name, salary, LEAD(salary, 1) OVER (ORDER BY salary)
FROM employees;


SELECT first_name, salary, LAG(salary, 1) OVER (ORDER BY salary)
FROM employees;


SELECT
    first_name,
    department,
    salary,
    SUM(salary) OVER(
        PARTITION BY department
        ORDER BY salary
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM employees;

SELECT first_name, department, salary
FROM (
    SELECT
        first_name,
        department,
        salary,
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY salary DESC
        ) AS row_num
    FROM employees
) AS ranked_employees
WHERE row_num = 1;