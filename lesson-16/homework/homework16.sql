--task 1
with Numbers_CTE as
(select 1 as number
union all
select number+1
from Numbers_cte
where number < 1000)
select number from numbers_cte option(maxrecursion 1000);

--task 2
select
	e.EmployeeID,
	e.FirstName,
	s.Total_Sales
from 
	Employees e
join (select
			EmployeeID,
			sum(salesamount) as Total_Sales
	 from Sales
	 group by
		EmployeeID)
 s on e.EmployeeID = s.EmployeeID;

 --task3
 with AvgSalary_Cte as
 (
 select avg(salary) as AvgSalary
 from Employees)
 select * from AvgSalary_Cte;

 --task 4
select
	p.productid,
	p.productname,
	s.MaxSale
from
	Products p
join (
	select ProductID, Max(SalesAmount)
	as MaxSale
	from Sales
	group by ProductID)
s On s.ProductID = p.ProductID;

--task 5

with Number_Cte as (
	select 1 as num
	union all
	select num*2
	from Number_cte
	where num*2 < 1000000)
select num
from Number_Cte;

--task 6
with SalesCountCte as
(
	select employeeid,count(*) as SalesCount
	from Sales
	group by EmployeeID)
select
	e.employeeID,
	e.FirstName
from
	salesCountCte s
join
	Employees e
on s.EmployeeID = e.EmployeeID
where
	s.SalesCount > 5;

	--task 7
with ProductSales as
(
select s.productid, sum(salesamount) as total_sales
from Sales s
group by s.ProductID)

select p.ProductID, p.ProductName, ps.total_sales
from ProductSales ps
join
Products p
on p.ProductID = ps.ProductID
where ps.total_sales > 500;

--task 8
with AvgCte as(
select avg(salary) as AvgSalary
from Employees
)
select e.employeeid, e.firstname, e.salary
from Employees e
join
AvgCte a on e.Salary > a.AvgSalary;

--medium task 1
select top 5 e.EmployeeID, e.firstname, s.total_orders
from (
	select EmployeeID,
count(*) as total_orders
	from sales
	group by EmployeeID) as s
join Employees e on
e.EmployeeID = s.EmployeeID
order by s.total_orders desc;

--medium task 2
select p.categoryid, sum(s.Total_Sales) from
(select productid, sum(salesamount) as Total_Sales
from Sales
group by ProductID) as s
join Products p
on p.ProductID = s.ProductID
group by p.CategoryID;

--medium task 3
with cte as(
	select 1 num, 1 as factorial
	union all
	select (num+1), (num+1)*factorial from cte
	where num+1<10)
	select * from cte
where num in (select number from Numbers1);



--medium task 4
WITH RecursiveSplit AS (
    SELECT 
        Id,
        SUBSTRING(String, 1, 1) AS Character,
        1 AS Position,
        String
    FROM Example
    WHERE LEN(String) >= 1

    UNION ALL

    SELECT 
        Id,
        SUBSTRING(String, Position + 1, 1) AS Character,
        Position + 1,
        String
    FROM RecursiveSplit
    WHERE Position + 1 <= LEN(String)
)
SELECT 
    Id,
    Position,
    Character
FROM RecursiveSplit
ORDER BY Id, Position;


--medium task 5
WITH MonthlyTotals AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SalesMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesWithDifference AS (
    SELECT 
        SalesMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SalesMonth) AS PreviousMonthSales
    FROM MonthlyTotals
)
SELECT 
    SalesMonth,
    TotalSales,
    PreviousMonthSales,
    TotalSales - ISNULL(PreviousMonthSales, 0) AS SalesDifference
FROM SalesWithDifference
ORDER BY SalesMonth;


--medium task 6
select s.EmployeeID, e.FirstName, s.TotalSales
from Employees e
join (
	select employeeid, sum(salesamount) as TotalSales
from sales
group by
EmployeeID) s on e.EmployeeID = s.EmployeeID
where s.TotalSales > 45000;



