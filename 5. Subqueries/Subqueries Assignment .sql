CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id VARCHAR(10),
    salary INT
);

CREATE TABLE Departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE
);

INSERT INTO Employees VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

INSERT INTO Departments VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

INSERT INTO Sales VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');
-- Q1: Employees earning more than avg salary
SELECT name
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Q2: Employees in highest average salary department
SELECT name
FROM Employees
WHERE department_id = (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- Q3: Employees who made at least one sale
SELECT name
FROM Employees
WHERE emp_id IN (SELECT emp_id FROM Sales);

-- Q4: Employee with highest sale amount
SELECT name
FROM Employees
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    ORDER BY sale_amount DESC
    LIMIT 1
);

-- Q5: Employees earning more than Shubham
SELECT name
FROM Employees
WHERE salary > (
    SELECT salary FROM Employees WHERE name = 'Shubham'
);
-- Q6: Employees in same department as Abhishek
SELECT name
FROM Employees
WHERE department_id = (
    SELECT department_id FROM Employees WHERE name = 'Abhishek'
);

-- Q7: Departments with at least one employee earning > 60000
SELECT DISTINCT department_id
FROM Employees
WHERE salary > 60000;

-- Q8: Department of employee with highest sale
SELECT department_name
FROM Departments
WHERE department_id = (
    SELECT department_id
    FROM Employees
    WHERE emp_id = (
        SELECT emp_id FROM Sales ORDER BY sale_amount DESC LIMIT 1
    )
);

-- Q9: Employees who made sales greater than avg sale amount
SELECT name
FROM Employees
WHERE emp_id IN (
    SELECT emp_id FROM Sales
    WHERE sale_amount > (SELECT AVG(sale_amount) FROM Sales)
);

-- Q10: Total sales by employees earning more than avg salary
SELECT SUM(sale_amount)
FROM Sales
WHERE emp_id IN (
    SELECT emp_id FROM Employees
    WHERE salary > (SELECT AVG(salary) FROM Employees)
);
-- Q11: Employees who made NO sales
SELECT name
FROM Employees
WHERE emp_id NOT IN (SELECT emp_id FROM Sales);

-- Q12: Departments with avg salary > 55000
SELECT department_id
FROM Employees
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Q13: Departments where total sales > 10000
SELECT department_id
FROM Employees e
JOIN Sales s ON e.emp_id = s.emp_id
GROUP BY department_id
HAVING SUM(sale_amount) > 10000;

-- Q14: Employee with second-highest sale
SELECT name
FROM Employees
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    ORDER BY sale_amount DESC
    LIMIT 1 OFFSET 1
);

-- Q15: Employees whose salary > highest sale amount
SELECT name
FROM Employees
WHERE salary > (SELECT MAX(sale_amount) FROM Sales);


