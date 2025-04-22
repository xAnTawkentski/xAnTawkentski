--task 1
select 
	p.ProductName,
	s.SupplierName 
from
	products p
inner join
	suppliers s on
p.ProductID = s.SupplierID;

--task 2
select d.*,
e.*
from
Departments d
inner join
Employees e
on 1=1;

--task 3
select s.SupplierName,
p.ProductName
from Products p
inner join
Suppliers s 
on s.SupplierID = p.ProductID;

--task 4
select o.orderid, c.FirstName
from Orders o
inner join
Customers c
on o.CustomerID = c.CustomerID;

--task 5
select s.*, c.*
from Courses c
inner join
Students s
on s.StudentID = c.CourseID

--task 6
select p.productname,o.orderid
from products p
inner join
orders o
on p.ProductID=o.ProductID

--task 7
select e.name,
d.departmentname
from Employees e
inner join
Departments d on
e.DepartmentID=d.DepartmentID;

--task 8
select s.name, e.courseid
from Students s
inner join
Enrollments e on
s.StudentID = e.StudentID;

--task 9
select o.orderid, p.*
from Orders o
inner join
Payments p on
o.OrderID = p.OrderID;

--task 10
select o.orderid,p.ProductName, p.price
from Orders o
inner join
Products p on
o.ProductID=p.ProductID
where p.Price > 100;

--task 11
select e.name, d.departmentname
from Employees e
cross join
Departments d
where 
e.DepartmentID <> d.DepartmentID;

--task 12
select o.orderid, o.Quantity, p.productname, p.StockQuantity
from Orders o
inner join
Products p
on o.ProductID = p.ProductID
where o.Quantity > p.StockQuantity;

--task 13
select s.productID, c.firstname
from Customers c
inner join
Sales s
on s.CustomerID = c.CustomerID
where s.SaleAmount >= 500;

--task 14
select s.name, c.coursename
from Enrollments e
inner join 
Courses c 
on c.CourseID = e.CourseID
inner join
Students s
on s.StudentID = e.EnrollmentID;

--task 15
select p.productname, s.suppliername
from Products p
inner join
Suppliers s
on p.SupplierID = s.SupplierID
where s.SupplierName LIKE '%tech%';

--task 16
select o.orderid, o.TotalAmount, p.amount
from Orders o
inner join
Payments p
on o.OrderID = p.OrderID
where p.Amount < o.TotalAmount;

--task 17
select e.name as EmployeeName, e.salary as EmployeeSalary,
m.name as ManagerName, m.salary as ManagerSalary
from Employees e
inner join Employees m
on e.EmployeeID = m.EmployeeID
where e.salary > m.salary;

--task 18
select p.productname, c.categoryname
from Products p
inner join 
Categories c
on p.Category = c.CategoryID
where c.CategoryName IN ('Electronics','Furniture');


--TASK 19
select s.CustomerID, s.SaleAmount, c.Country
from Sales s
inner join
Customers c
on s.CustomerID = c.CustomerID
where c.Country = 'USA';

--task 20
select o.OrderID, o.CustomerID, o.TotalAmount, c.Country 
from Orders o
inner join
Customers c
on o.CustomerID = c.CustomerID
where c.Country = 'Germany' and o.TotalAmount > 100;

--task 21
select e1.Name as Employee1,
e2.Name as Employee2
from Employees e1
inner join
Employees e2
on e1.EmployeeID < e2.EmployeeID
where e1.DepartmentID <> e2.DepartmentID;

--Task 22
select p.PaymentID, p.OrderID, p.Amount, o.Quantity, pr.ProductName, pr.Price
from Payments p
inner join
Orders o 
on p.OrderID = o.OrderID
inner join
Products pr
on o.ProductID = pr.ProductID
where p.Amount <> (o.Quantity * pr.Price);

--task 23
SELECT s.StudentID, s.Name
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

--task 24
select m.EmployeeID, m.name as ManagerName, m.Salary as ManagerSalary,
e.name as EmployeeName, e.salary as EmployeeSalary
from Employees e
inner join Employees m
on e.ManagerID = m.EmployeeID
where m.salary <= e.salary;

--task 25
select distinct c.FirstName, c.CustomerID
from Customers c
inner join
Orders o
on c.CustomerID = o.CustomerID
left join
Payments p
on o.OrderID = p.OrderID
where p.PaymentID is null;
