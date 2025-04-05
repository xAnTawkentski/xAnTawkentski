--Tasks 1 to 4 solutions
CREATE DATABASE HOMEWORK2
CREATE TABLE Employees (
EmpID int,
Name varchar(50),
Salary decimal(10,2));
 
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali', 25.000);
INSERT INTO Employees (EmpID, Name, Salary) VALUES
(2, 'Vali', 30000),
(3, 'Sali', 35000),
(4, 'Bali', 40000),
(5, 'Mali', 45000),
(6, 'Rani', 50000);

UPDATE Employees SET salary=25000 WHERE EmpID=1;
DELETE Employees WHERE EmpID=2;

--Task 5
CREATE TABLE Test (
	ID int,
	Name varchar(20),
	Salary float
)

INSERT INTO Test VALUES
	(1, 'Sarah', 2500),
	(2, 'John', 3000);
DELETE FROM Test where id=1;
TRUNCATE TABLE Test;
DROP TaBLE Test;
	

--Task 6 to 8 solutions
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

ALTER TABLE Employees
ADD Department VARCHAR(50);

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
SELECT * FROM Employees;

--Task 9-10 solutions
CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50));
TRUNCATE TABLE Employees;

--Task 11
INSERT INTO Departments (DepartmentID)
SELECT EmpID FROM Employees;


--TASK 12
UPDATE Employees SET Department = 'Management' WHERE Salary > 5000
SELECT * FROM StaffMembers;

--Task 13
TRUNCATE TABLE Employees;

--Task 14
ALTER TABLE Employees
DROP COLUMN Department;

--Task 15
EXEC sp_rename 'Employees','StaffMembers';

--Task 16
DROP TABLE Departments;

--Task 17
CREATE TABLE Products (
	ProductID int PRIMARY KEY,
	ProducName VARCHAR(50),
	Category VARCHAR(50),
	Price DECIMAL(10,2)
);

--Task 18
ALTER TABLE Products
ADD CONSTRAINT CHK_Price
CHECK (Price > 0);

--Task 19
ALTER TABLE Products
ADD StockQuantity int DEFAULT(50);

--Task 20
EXEC sp_rename
'dbo.products.category','ProductCategory','COLUMN';

--Task 21
INSERT INTO Products 
VALUES(1, 'Samsung', 'Phone', 800, 2000)

--Task 22
SELECT * INTO Products_Backup
FROM Products;

--Task 23
EXEC sp_rename 'Products','Invertory';

--Task 24
ALTER TABLE Invertory
DROP CONSTRAINT CHK_Price;

ALTER TABLE Invertory
ALTER COLUMN Price FLOAT;

--Task 25
ALTER TABLE Invertory
ADD ProductCode int IDENTITY(1000, 5);
