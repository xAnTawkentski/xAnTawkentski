--homework 17
--task 1

WITH AllCombinations AS (
    SELECT 
        R.Region,
        D.Distributor
    FROM 
        (SELECT DISTINCT Region FROM #RegionSales) AS R
    CROSS JOIN 
        (SELECT DISTINCT Distributor FROM #RegionSales) AS D
),
SalesReport AS (
    SELECT 
        A.Region,
        A.Distributor,
        ISNULL(RS.Sales, 0) AS Sales
    FROM AllCombinations A
    LEFT JOIN #RegionSales RS
        ON A.Region = RS.Region AND A.Distributor = RS.Distributor
)
SELECT *
FROM SalesReport
ORDER BY Distributor, Region;

--task 2
SELECT 
    e.id AS ManagerId,
    e.name AS ManagerName,
    COUNT(emp.id) AS DirectReports
FROM Employee e
JOIN Employee emp ON emp.managerId = e.id
GROUP BY e.id, e.name
HAVING COUNT(emp.id) >= 5;

--task 3
SELECT 
    p.product_name,
    SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

--task 4
SELECT 
    CustomerID,
    Vendor
FROM (
    SELECT 
        CustomerID,
        Vendor,
        SUM(OrderCount) AS TotalOrders,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SUM(OrderCount) DESC) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) ranked
WHERE rnk = 1;

--task 5
DECLARE @Check_Prime INT = 17;  -- Bu yerga istalgan sonni qo‘ying
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


--task 6
SELECT COUNT(DISTINCT Locations) AS NumberOfLocations
FROM Device;

SELECT TOP 1 Locations, COUNT(*) AS TotalSignals
FROM Device
GROUP BY Locations
ORDER BY TotalSignals DESC;

--task 7
SELECT 
    EmpID,
    EmpName,
    Salary
FROM 
    Employee e
WHERE 
    Salary > (
        SELECT AVG(Salary)
        FROM Employee
        WHERE DeptID = e.deptid
    );

--task 8

WITH Matched AS (
  SELECT 
    t.TicketID,
    COUNT(*) AS MatchedCount
  FROM Tickets t
  JOIN WinningNumbers w ON t.Number = w.Number
  GROUP BY t.TicketID
),
Winnings AS (
  SELECT 
    TicketID,
    CASE 
      WHEN MatchedCount = 3 THEN 100
      WHEN MatchedCount IN (1, 2) THEN 10
      ELSE 0
    END AS Prize
  FROM (
    SELECT 
      TicketID,
      COALESCE(MatchedCount, 0) AS MatchedCount
    FROM (
      SELECT DISTINCT TicketID FROM Tickets
    ) all_tickets
    LEFT JOIN Matched USING (TicketID)
  ) sub
)
SELECT SUM(Prize) AS TotalWinnings
FROM Winnings;


--task 9
WITH UserPlatform AS (
  SELECT 
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS used_mobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_desktop,
    SUM(Amount) AS total_amount
  FROM Spending
  GROUP BY User_id, Spend_date
),
Classified AS (
  SELECT 
    Spend_date,
    CASE 
      WHEN used_mobile = 1 AND used_desktop = 1 THEN 'Both'
      WHEN used_mobile = 1 THEN 'Mobile'
      WHEN used_desktop = 1 THEN 'Desktop'
    END AS Platform,
    total_amount,
    User_id
  FROM UserPlatform
),
Aggregated AS (
  SELECT 
    Spend_date,
    Platform,
    SUM(total_amount) AS Total_Amount,
    COUNT(*) AS Total_users
  FROM Classified
  GROUP BY Spend_date, Platform
)
-- include all combinations, even with 0s
SELECT 
    d.Spend_date,
    p.Platform,
    COALESCE(a.Total_Amount, 0) AS Total_Amount,
    COALESCE(a.Total_users, 0) AS Total_users
FROM 
    (SELECT DISTINCT Spend_date FROM Spending) d
CROSS JOIN 
    (SELECT 'Mobile' AS Platform 
     UNION ALL 
     SELECT 'Desktop' 
     UNION ALL 
     SELECT 'Both') p
LEFT JOIN 
    Aggregated a 
    ON d.Spend_date = a.Spend_date AND p.Platform = a.Platform
ORDER BY 
    d.Spend_date, 
    CASE p.Platform 
        WHEN 'Mobile' THEN 1
        WHEN 'Desktop' THEN 2
        WHEN 'Both' THEN 3
    END;


--task 10
WITH NumberSeries AS (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4
    -- Agar miqdor 4 tadan katta bo‘lsa, bu yerga yana qo‘shimcha raqamlar qo‘shish mumkin
)

SELECT 
    g.Product, 
    1 AS Quantity
FROM 
    Grouped g
JOIN 
    NumberSeries ns ON ns.n <= g.Quantity
ORDER BY 
    g.Product, ns.n;
