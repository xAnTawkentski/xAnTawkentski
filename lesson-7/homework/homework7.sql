--HOMEWORK 7

--Task 1
SELECT MIN(Price) AS MinPrice
FROM Products;

--Task 2
SELECT MAX(Salary) AS MaxPrice
FROM Employees;

--Task 3
SELECT COUNT(*) AS CtRow
FROM Customers;

--Task 4
SELECT COUNT(DISTINCT Category)AS UniqueCategoryCount
FROM Products;

--Task 5
SELECT SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE ProductID = 7;


--Task 6
SELECT AVG(Age) AS AgeEmp
FROM Employees;

--Task 7
SELECT DepartmentName, COUNT(*)
AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

--Task 8
SELECT category,
MIN(Price) AS MinPrice,
MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

--Task 9
Select CustomerID,
SUM(SaleAmount) AS CustSales
FROM Sales
GROUP BY CustomerID;

--Task 10
SELECT DepartmentName, COUNT(*) 
AS EmpCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

--Task 11
SELECT ProductID,
SUM(SaleAmount) AS SumSales,
AVG(SaleAmount) AS AvgSales
FROM Sales
GROUP BY ProductID;

--Task 12
SELECT COUNT(EmployeeID)
AS CountHR
FROM Employees
WHERE DepartmentName = 'HR';

--Task 13
SELECT DeptID,
MAX(Salary) AS MaxSalary,
MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DeptID;

--Task 14
SELECT DeptID,
AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID;

--Task 15
SELECT DeptID,
AVG(Salary) AS AvgSalary,
COUNT(*) AS CountEmp
FROM Employees
GROUP BY DeptID;

--Task 16
SELECT Category,
AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

--Task 17
SELECT YEAR(SaleDate) AS SaleYear,
SUM(SaleAmount) AS SumSale
FROM SALES
GROUP BY YEAR(SaleDate);

--Task 18
SELECT COUNT(*) AS Cust3More
FROM (
	SELECT CustomerID
	FROM Orders
	GROUP BY CustomerID
	HAVING COUNT(OrderID) >= 3
) AS subquery;

--Task 19
SELECT DeptID, SUM(Salary) AS SumSalary
FROM Employees
GROUP BY DeptID
HAVING SUM(Salary) > 500000;

--Task 20
CREATE TABLE Sales2(
SaleID INT PRIMARY KEY,
ProductID INT,CustomerID INT,
Category Varchar(50),
SaleAmount DECIMAL(10,2))

INSERT INTO Sales2 Values
(1, 1, 1, 'Fruits', 150.00),
(2, 2, 2, 'Fruits', 200.00), 
(3, 3, 3, 'Fruits', 250.00), 
(4, 4, 4, 'Vegetables', 300.00), 
(5, 5, 5, 'Vegetables', 350.00), 
(6, 6, 6, 'Fruits', 400.00), 
(7, 7, 7, 'Vegetables', 450.00), 
(8, 8, 8, 'Vegetables', 500.00), 
(9, 9, 9, 'Fruits', 550.00), 
(10, 10, 10, 'Vegetables', 1600.00)


SELECT Category, AVG(SaleAmount)
AS AvgSaleAmount
FROM Sales2
Group By Category
Having AVG(SaleAmount) > 200;

--Task 21
SELECT CustomeriD,
SUM(SaleAmount) AS TotalSales
FROM Sales2
GROUP BY CustomerID
HAVING SUM(SaleAmount)>1500;

--Task 22
SELECT DepartmentName,
SUM(Salary) AS SumSalary,
AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

--Task 23
SELECT CustomerID,
MAX(TotalAmount) AS OrderMax,
MIN(TotalAmount) AS OrderMin
FROM Orders
GROUP BY CustomerID
HAVING MAX(TotalAmount) >= 50;

--Task 24
SELECT
	MONTH(SaleDate) AS SaleMonth,
	SUM(SaleDate) AS TotalSales,
	COUNT (DISTINCT ProductID) AS ProductsSold
FROM Sales
GROUP BY MONTH(SaleDate)
HAVING COUNT(DISTINCT ProductID) > 8;

--Task 25
SELECT 
	YEAR(OrderDate) AS OrderYear,
	MIN(Quantity) AS MinQuantity,
	MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);
