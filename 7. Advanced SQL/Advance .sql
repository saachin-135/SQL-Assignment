-- =====================================
-- ADVANCED SQL ASSIGNMENT
-- PW Skills
-- =====================================


-- ===============================
-- DATASET (Given in Question)
-- ===============================

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');


-- ===============================
-- Q6: CTE – Total revenue per product (> 3000)
-- Revenue = Price * Quantity
-- ===============================

WITH ProductRevenue AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductID, p.ProductName
)
SELECT *
FROM ProductRevenue
WHERE Revenue > 3000;


-- ===============================
-- Q7: Create View vw_CategorySummary
-- Category, TotalProducts, AveragePrice
-- ===============================

CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;


-- ===============================
-- Q8: Create Updatable View + Update Price
-- ===============================

CREATE VIEW vw_ProductBasic AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products;

-- Update ProductID = 1 price using view
UPDATE vw_ProductBasic
SET Price = 1300
WHERE ProductID = 1;


-- ===============================
-- Q9: Stored Procedure
-- Accept category name and return products
-- ===============================

CREATE PROCEDURE GetProductsByCategory(IN cat_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT ProductID, ProductName, Category, Price
    FROM Products
    WHERE Category = cat_name;
END;
$$;


-- ===============================
-- Q10: AFTER DELETE Trigger
-- Archive deleted products
-- ===============================

CREATE OR REPLACE FUNCTION archive_deleted_product()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ProductArchive
    VALUES (
        OLD.ProductID,
        OLD.ProductName,
        OLD.Category,
        OLD.Price,
        NOW()
    );
    RETURN OLD;
END;
$$;

CREATE TRIGGER trg_after_delete
AFTER DELETE ON Products
FOR EACH ROW
EXECUTE FUNCTION archive_deleted_product();
