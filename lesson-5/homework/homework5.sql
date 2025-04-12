--Task 1
SELECT ProductName AS Name FROM Products;

--Task 2
SELECT * FROM Customers AS Client;

--Task 3
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

--Task 4
SELECT * FROM Products
INTERSECT
SELECT * FROM Products_Discounted;

--Task 5
SELECT DISTINCT
FirstName, Country
FROM Customers;

--Task 6
SELECT 
	ProductID,
	ProductName,
	Price,
	CASE
		WHEN Price > 1000
THEN 'High'
		ELSE 'Low'
	END AS PriceLevel
FROM Products;

--Task 7
SELECT 
	ProductID,
	ProductName,
	StockQuantity,
	IIF(StockQuantity > 100, 'Yes','No')
	AS InStock FROM Products_Discounted;

--Task 8
SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM OutOfStock;

--Task 9
SELECT * FROM Products
EXCEPT 
SELECT * FROM Products_Discounted;

--Task 10
SELECT
	ProductID,
	ProductName,
	Price,
	IIF(Price > 1000,
'Expensive','Affordable')
AS PriceTag
FROM Products;

--Task 11
SELECT * FROM Employees
WHERE Age < 25 OR Salary > 60000;

--Task 12
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentName = 'HR' OR
EmployeeID = 5;

--Task 13
SELECT * FROM Products
INTERSECT
SELECT * FROM Products_Discounted;

--Task 14
SELECT 
	SaleID,
	SaleAmount,
	CASE
		WHEN SaleAmount > 500 THEN 'Top Tier'
		WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
		ELSE 'Low Tier'
	END AS Tier
FROM Sales;

--Task 15
SELECT CustomerID
FROM Orders
EXCEPT
SELECT CustomerID
FROM Invoices;

--Task 16
SELECT 
    CustomerID,
    Quantity,
    CASE 
        WHEN Quantity = 1 THEN 3
        WHEN Quantity BETWEEN 2 AND 3 THEN 5
        ELSE 7
    END AS DiscountPercentage
FROM Orders;
