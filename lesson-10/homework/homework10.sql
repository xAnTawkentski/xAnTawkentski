--homework 10


--task 1
select e.Name, e.salary, d.departmentname
from Employees e
inner join
Departments d
on e.DepartmentID = d.DepartmentID
where e.Salary > 50000;

--task 2
select c.FirstName, c.lastname, o.orderdate
from Customers c
inner join
Orders o
on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 2023;

--task 3
select e.name, d.DepartmentName
from Employees e
left join
Departments d
on e.DepartmentID = d.DepartmentID;

--task 4
select s.suppliername, p.productname
from Suppliers s
left join
Products p
on s.SupplierID = p.SupplierID;

--task 5
select o.orderid, o.orderdate, p.paymentdate, p.amount
from Orders o
full join
Payments p
on o.OrderID = p.OrderID;

--task 6
select e.name as EmployeeName, m.name as ManagerName
from Employees e
inner join 
Employees m
on e.ManagerID = m.EmployeeID;

--task 7
select s.Name, c.CourseName
from Students s
inner join 
Enrollments e
on s.StudentID = e.StudentID
inner join
Courses c
on c.CourseID = e.CourseID
where c.CourseName = 'Math 101';

--task 8
select c.FirstName, c.LastName, o.Quantity
from Customers c
inner join
Orders o
on c.CustomerID = o.CustomerID
where o.Quantity > 3;

--task 9
select e.Name, d.DepartmentName
from Employees e
inner join
Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Human Resources';

--task 10
select d.DepartmentName, count(e.EmployeeID) as EmployeeCount
from Departments d
inner join Employees e
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having count(e.EmployeeID) > 10;

--task 11
select p.productid, p.productname
from Products p
left join Sales s
on p.ProductID = s.ProductID
where s.ProductID is null;

--task 12
select c.FirstName, c.LastName, count(o.orderid) as TotalOrder
from Customers c
inner join
Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerID, c.FirstName, c.LastName;

--task 13
select e.name, d.departmentname
from Employees e
inner join
Departments d
on e.DepartmentID = d.DepartmentID;

--task 14
select e1.name as Employee1, e2.name as Employee2, e1.ManagerID
from Employees e1
inner join Employees e2
on e1.ManagerID = e2.ManagerID
where e1.EmployeeID < e2.EmployeeID
and e1.ManagerID is not null;

--task 15
select o.orderid, o.orderdate, c.FirstName, c.LastName
from Orders o
inner join
Customers c
on c.CustomerID = c.CustomerID
where year(o.OrderDate) = 2022;

--task 16
select e.name, e.salary, d.departmentname
from Employees e
inner join 
Departments d
on e.DepartmentID = d.DepartmentID
where e.Salary > 60000;

--task 17
select o.OrderID, o.OrderDate, p.paymentdate, p.amount
from Orders o
inner join
Payments p
on o.OrderID = p.OrderID

--task 18
select p.ProductID, p.productname
from Products p
left join
Orders o
on p.ProductID = o.ProductID
where o.ProductID is null;

--task 19
select Name, Salary
from Employees
where salary > (select avg(salary) from Employees);

--task 20
select  o.orderID, o.orderDate
from Orders o
left join
Payments p
on o.OrderID = p.OrderID
where o.OrderDate < '2020-01-01'
and p.PaymentDate is null;

--task 21
select p.productid, p.productname
from Products p
left join
Categories c
on p.Category = c.CategoryID
where c.CategoryID is null;

--task 22
select e1.name as Employee1, e2.name as Employee2, e1.managerID, e1.salary
from Employees e1
inner join
Employees  e2
on e1.ManagerID = e2.ManagerID
where e1.EmployeeID < e2.EmployeeID
and e1.Salary > 60000
and e2.Salary > 60000;

--task 23
select e.name as EmployeeName, d.departmentname
from Employees e
inner join
Departments d
on e.DepartmentID = d.DepartmentID
where d.DepartmentName like'M%';

--task 24
select s.saleid, p.productname, s.saleamount
from Sales s
inner join
Products p
on s.ProductID = p.ProductID
where s.SaleAmount > 500;

--task 25
select s.StudentID, s.Name
from Students s
where s.StudentID not in (
select e.StudentID
from Enrollments e
inner join
Courses c
on e.CourseID = c.CourseID
where c.CourseName = 'Math 101'
);

--task 26
select o.orderid, o.orderdate, p.paymentid
from Orders o
left join
Payments p
on o.OrderID = p.PaymentID
where p.PaymentID is null;

--task 27
select p.ProductID, p.ProductName, c.CategoryName
from Products p
inner join
Categories c
on p.Category = c.CategoryID
where c.CategoryName in ('Electronics','Furniture');


