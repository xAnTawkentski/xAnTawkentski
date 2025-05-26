--hw20
--task 1
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate >= '2024-03-01'
      AND s2.SaleDate < '2024-04-01'
);


--task 2
SELECT Product
FROM (
    SELECT Product, SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) AS RevenuePerProduct
WHERE TotalRevenue = (
    SELECT MAX(Total)
    FROM (
        SELECT SUM(Quantity * Price) AS Total
        FROM #Sales
        GROUP BY Product
    ) AS TotalPerProduct
);

--task 3
SELECT MAX(SaleAmount)
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
    WHERE Quantity * Price < (
        SELECT MAX(Quantity * Price)
        FROM #Sales
    )
) AS Sub;


--task 4
SELECT DISTINCT
    FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
    (
        SELECT SUM(Quantity)
        FROM #Sales AS s2
        WHERE FORMAT(s2.SaleDate, 'yyyy-MM') = FORMAT(s1.SaleDate, 'yyyy-MM')
    ) AS TotalQuantity
FROM #Sales AS s1
ORDER BY SaleMonth;


--task 5
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName <> s1.CustomerName
);


--task 6
SELECT Name, Apple, Orange, Banana
FROM (
    SELECT Name, Fruit
    FROM Fruits
) AS SourceTable
PIVOT (
    COUNT(Fruit)
    FOR Fruit IN ([Apple], [Orange], [Banana])
) AS PivotTable;



--task 7
WITH FamilyTree (ParentID, ChildID) AS (
    -- Boshlang'ich (anchor) qism
    SELECT ParentID, ChildID
    FROM Family

    UNION ALL

    -- Rekursiv qism
    SELECT ft.ParentID, f.ChildID
    FROM FamilyTree ft
    JOIN Family f ON ft.ChildID = f.ParentID
)
-- Natijani ko'rsatish
SELECT * FROM FamilyTree
ORDER BY ParentID, ChildID;


--task 8
SELECT CustomerID, OrderID, DeliveryState, Amount
FROM #Orders
WHERE DeliveryState = 'TX'
  AND CustomerID IN (
      SELECT DISTINCT CustomerID
      FROM #Orders
      WHERE DeliveryState = 'CA'
  );
 

 --task 9
UPDATE #residents
SET address = address + ' name=' + fullname
WHERE address NOT LIKE '%name=%';


--task 10
WITH RoutePaths (Route, ArrivalCity, Cost) AS (
    SELECT 
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    SELECT 
        CAST(rp.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)),
        r.ArrivalCity,
        rp.Cost + r.Cost
    FROM RoutePaths rp
    JOIN #Routes r ON rp.ArrivalCity = r.DepartureCity
    WHERE rp.Route NOT LIKE '%' + r.ArrivalCity + '%'
)

-- Ikkala natijani subquery orqali ajratamiz va UNION qilamiz
SELECT * FROM (
    SELECT TOP 1 Route, Cost
    FROM RoutePaths
    WHERE ArrivalCity = 'Khorezm'
    ORDER BY Cost ASC
) AS Cheapest

UNION ALL

SELECT * FROM (
    SELECT TOP 1 Route, Cost
    FROM RoutePaths
    WHERE ArrivalCity = 'Khorezm'
    ORDER BY Cost DESC
) AS MostExpensive;


--task 11
SELECT
    ID,
    Vals,
    ROW_NUMBER() OVER (PARTITION BY Vals ORDER BY ID) AS RankInGroup
FROM #RankingPuzzle
ORDER BY ID;


--task 12
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    SalesAmount,
    SalesMonth,
    SalesYear
FROM #EmployeeSales es
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = es.Department
)
ORDER BY Department, SalesAmount DESC;


--task 13
 SELECT es1.EmployeeID, es1.EmployeeName, es1.Department, es1.SalesAmount, es1.SalesMonth, es1.SalesYear
FROM #EmployeeSales es1
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales es2
    WHERE es2.SalesMonth = es1.SalesMonth
      AND es2.SalesYear = es1.SalesYear
      AND es2.SalesAmount > es1.SalesAmount
);


--task 14
-- 1. Avvalo mavjud oylar ro‘yxatini aniqlaymiz
-- 2. So‘ng NOT EXISTS orqali xodimlar har bir oyda sotuv qilganmi-yo‘qmi — tekshiramiz

SELECT DISTINCT es1.EmployeeID, es1.EmployeeName
FROM #EmployeeSales es1
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth
        FROM #EmployeeSales
    ) AS AllMonths
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es2
        WHERE es2.EmployeeID = es1.EmployeeID
          AND es2.SalesMonth = AllMonths.SalesMonth
    )
);



--task 15
SELECT Name
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);


--task 16
SELECT ProductID, Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);


--task 17
select name from Products
where category in (SELECT DISTINCT category from Products
	where Name = 'Laptop');


--task 18
select name, price from Products
where price > ( select min(price) from Products
	where category = 'electronics');


--task 19
SELECT p.ProductID, p.Name, p.Category, p.Price
FROM Products p
JOIN (
    SELECT Category, AVG(Price) AS AvgPrice
    FROM Products
    GROUP BY Category
) AS AvgCategoryPrice
ON p.Category = AvgCategoryPrice.Category
WHERE p.Price > AvgCategoryPrice.AvgPrice;


--task 20
SELECT ProductID, Name
FROM Products
WHERE ProductID IN (
    SELECT DISTINCT ProductID
    FROM Orders
);


--task 21
SELECT p.Name
FROM Products p
JOIN (
    SELECT ProductID, SUM(Quantity) AS TotalQuantity
    FROM Orders
    GROUP BY ProductID
) AS ProductTotals ON p.ProductID = ProductTotals.ProductID
WHERE ProductTotals.TotalQuantity > (
    SELECT AVG(TotalQuantity)
    FROM (
        SELECT SUM(Quantity) AS TotalQuantity
        FROM Orders
        GROUP BY ProductID
    ) AS AvgTable
);


--task 22
SELECT ProductID, Name
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM Orders
);


--task 23
SELECT TOP 1 p.ProductID, p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQuantity DESC;
