--homework18

--task 1
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18, 2)
);
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(s.SaleDate) = MONTH(GETDATE()) AND YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;


--task 2
CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(ISNULL(s.Quantity, 0)) AS TotalQuantitySold,
	SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName;


--task 3
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18, 2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;


--task 4
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(ISNULL(s.Quantity, 0)) AS TotalQuantity,
        SUM(ISNULL(s.Quantity, 0) * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName, p.Price
);



--task 5

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;

    -- 1 yoki undan kichik sonlar tub emas
    IF @Number <= 1
        RETURN 'No';

    -- 2 – tub son (eng kichik tub son)
    IF @Number = 2
        RETURN 'Yes';

    -- 2 dan katta sonlar uchun tekshirish
    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END

    IF @IsPrime = 1
        RETURN 'Yes';
    ELSE
        RETURN 'No';
END;

--task 6
CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Result TABLE (Number INT)
AS
BEGIN
    DECLARE @Current INT = @Start;

    WHILE @Current <= @End
    BEGIN
        INSERT INTO @Result (Number)
        VALUES (@Current);

        SET @Current = @Current + 1;
    END

    RETURN;
END;


--task 7
-- N-chi eng yuqori maoshni ko‘rish uchun
-- N o‘rniga istalgan son qo‘ying (masalan, 3 - 3-chi eng yuqori maosh)
DECLARE @N INT = 3;

SELECT
    Salary
FROM (
    SELECT DISTINCT Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM Employee
) AS DistinctSalaries
WHERE Rank = @N;


--task 8
SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC;


