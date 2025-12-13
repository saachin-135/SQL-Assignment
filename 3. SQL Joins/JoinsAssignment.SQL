Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

Payments
CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATE,
    Amount INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT
);

Customers 
INSERT INTO Customers VALUES
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller', 'Houston'),
(5, 'Robert White', 'Miami');

Orders
INSERT INTO Orders VALUES
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 6, '2024-10-12', 400);

Payments
INSERT INTO Payments VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

Employees
INSERT INTO Employees VALUES
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);


Q1. Retrieve all customers who have placed at least one order.

(Use INNER JOIN)

SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

Q2. Retrieve all customers and their orders, including customers who have not placed any orders.

(Use LEFT JOIN)

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

Q3. Retrieve all orders and corresponding customers, including orders placed by unknown customers.

(Use RIGHT JOIN)

SELECT o.OrderID, o.OrderDate, o.Amount,
       c.CustomerID, c.CustomerName, c.City
FROM Orders o
RIGHT JOIN Customers c
ON c.CustomerID = o.CustomerID;

Q4. Display all customers and orders, whether matched or not.

(Use FULL OUTER JOIN – PostgreSQL syntax)

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID;

Q5. Find customers who have not placed any orders.

(Use LEFT JOIN + NULL filter)

SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

Q6. Retrieve customers who made payments but did not place any orders.

(Use LEFT JOIN between Customers & Payments then exclude Orders)

SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

Q7. Generate all possible combinations between Customers and Orders.

(CROSS JOIN)

SELECT c.CustomerID, c.CustomerName,
       o.OrderID, o.OrderDate
FROM Customers c
CROSS JOIN Orders o;

Q8. Show all customers along with order and payment amounts in one table.

(Join 3 tables)

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.Amount AS OrderAmount,
       p.PaymentID, p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON c.CustomerID = p.CustomerID;

Q9. Retrieve all customers who have both placed orders AND made payments.
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID;