--hw21

--task 1
select *,
ROW_NUMBER() over (order by SaleDate) as rowNum
from ProductSales;

--task 2
SELECT 
    ProductName,
    SUM(Quantity) AS TotalQuantitySold,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS ProductRank
FROM 
    ProductSales
GROUP BY 
    ProductName;


--task 3
WITH RankedSales AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
)
SELECT SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID
FROM RankedSales
WHERE rn = 1;


--task 4
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

--task 5
select 
	 SaleID,
    SaleDate,
    SaleAmount,
	Lag(saleamount) over(order by SaleDate) as PreviousSaleAmount
from ProductSales;

--task 6
WITH SalesWithPrevious AS (
    SELECT 
        SaleID,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
)
SELECT *
FROM SalesWithPrevious
WHERE SaleAmount > PreviousSaleAmount;


--task 7
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS SaleAmountDifference
FROM ProductSales;


--task 8
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
    CASE 
        WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NOT NULL 
        THEN 
            ROUND(
                ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount) * 100, 2
            )
        ELSE NULL
    END AS PercentageChange
FROM ProductSales;


--task 9
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    CASE 
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NOT NULL 
             AND LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) != 0
        THEN ROUND(SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 2)
        ELSE NULL
    END AS SaleRatio
FROM ProductSales;


--task 10
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirst
FROM ProductSales;

--task 11
with cte_prev as (
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales)
select * from cte_prev
WHERE SaleAmount > PreviousSaleAmount;


--task 12
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ClosingBalance
FROM ProductSales;


--task 13
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg_Last3Sales
FROM ProductSales;


--task 14
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER () AS AverageSaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromAverage
FROM ProductSales;


--task 15
WITH SalaryRanks AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SalaryRank
FROM SalaryRanks
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM SalaryRanks
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank;


--task 16
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary
FROM RankedSalaries
WHERE SalaryRank <= 2
ORDER BY Department, Salary DESC;

--task 17
with LowSalary as(
select EmployeeID, Name, Department, salary,
rank() over(Partition by Department order by Salary asc) as salaryRank
from Employees1)
select EmployeeID, Name, Department, Salary
from LowSalary
where salaryRank = 1
order by Department;


--task 18
select EmployeeID, Name, Department, Salary, sum(Salary) over(Partition by Department
order by HireDate) as RunningTotal
from Employees1;


--task19, 1-yechim:
select distinct Department, Sum(salary) over (partition by Department)as MaxSalary
from Employees1;

--task19, 2-yechim:
go
with cte as (
select Department, Sum(salary) over (partition by Department order by salary)as MaxSalary
from Employees1)
select * from cte
where cte.MaxSalary = (select max(MaxSalary) from cte as cte2  where cte2.Department = cte.Department);



--task 20
select distinct Department, avg(salary) over (partition by Department)as AvgSalary
from Employees1;


--task 21
select Name, Department, Salary, salary-
avg(salary) over(partition by department) as DiffSalary from Employees1;


--task 22
select Name, Department, Salary, avg(salary) over(
order by hiredate rows between 1 preceding and 1 following)
as movingAverage
from Employees1
order by HireDate, Name;



--task 23
SELECT SUM(salary) AS total_salary_last_3
FROM (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY hiredate DESC) AS rn
    FROM Employees1
) AS numbered_employees
WHERE rn <= 3;

