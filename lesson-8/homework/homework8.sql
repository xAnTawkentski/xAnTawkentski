--HomeWork 8

--Task 1
SELECT Category,
COUNT(*) AS TotalProducts
FROM Products GROUP BY Category;

--Task 2
SELECT Category,
AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING Category = 'Electronics';

--Task 3
SELECT * FROM Customers
WHERE City LIKE 'L%';

--Task 4
SELECT * FROM Products
WHERE ProductName LIKE '%er';

--Task 5
SELECT * FROM Customers
WHERE Country LIKE '%A';

--Task 6
SELECT MAX(Price) AS Highestprice
FROM Products;

--Task 7
SELECT ProductName, StockQuantity
IIF(StockQuantity < 30, 'Low Stock','Sufficient')
AS StockStatus
FROM Products;

--Task 8
SELECT Country, 
COUNT(*) AS TotalCustomers
FROM Customers 
GROUP BY Country;

--Task 9
Select min(quantity) as minquantity,
max(quantity) as maxquantity
from orders;

--Task 10
SELECT CustomerId
from orders
where year(orderdate) =2023
except
select CustomerID
from invoices;

--Task 11
SELECT ProductName From Products
union all
SELECT ProductName FROM Procuts_Discounted;

--Task 12
SELECT ProductName From Products
union
SELECT ProductName FROM Procuts_Discounted;

--Task 13
SELECT YEAR(OrderDate) AS Orderyear,
AVG(TotalAmount) AS AverageAmount
FROM ORDERS
Group by year(orderdate)
order by (orderyear);

--Task 14
SELECT Price,
CASE when Price<100
then 'low'
when price between 100 and 500 then 'mid'
when price > 500 then 'high'
end as PriceGroup
FROM Products;

--TASK 15
SELECT DISTINCT City
from customers
order by city;

--Task 16
SELECT ProductID,
SUM(SaleAmount) AS TotalSaleAmount
FROM Sales
GROUP BY ProductID;

--Task 17
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

--Task 18
SELECT ProductID
FROM Products
intersect
SELECT ProductID
FROM Products_Discounted;

--Task 19
SELECT TOP 3 CustomerID,
SUM(TotalAmount) AS TotalSpent
FROM INVOICES
GROUP BY CustomerID
ORDER BY TotalSpent;

--Task 20
SELECT ProductID,
ProductName
FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM
Products_Discounted);

--Task 21
select p.productname,
count(s.saleid) as times_sold
from products p
left join
sales s on p.productid=s.productid
group by p.productname
order by times_sold DESC;

--Task 22
select top 5 productid,
sum(quantity) as totalquantity
from orders
group by ProductID
order by totalquantity desc;



