
--task 1
create procedure BonusAmount
as
begin

select e.employeeid, concat(e.firstname, e.lastname) as fullname,
e.department, e.salary, e.salary * d.bonuspercentage as BonusAmount
into #employeeBonus
from Employees e
join DepartmentBonus d on e.Department=d.Department
end

--task 2
CREATE PROCEDURE UpdateDepartmentSalaries
    @DeptName NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- Ish haqlarini yangilash
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @DeptName;

    -- Yangilangan xodimlarni qaytarish
    SELECT *
    FROM Employees
    WHERE Department = @DeptName;
END;


--task 3
merge into products_current as pc
using products_new as pn
on pc.productId = pn.productId
when matched then
	update set pc.productname = pn.productname,
		 pc.price = pn.price
when not matched by target then
	insert (productid,productname,price) values
(pn.productid, pn.productname,pn.price)
when not matched by source then delete;

select * from Products_Current
  

--task 4
SELECT 
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN t.id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t
ORDER BY t.id;


--task 5
SELECT 
    s.user_id,
    ROUND(
        IFNULL(SUM(c.action = 'confirmed') / COUNT(c.action), 0)
    , 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;


--TASK 6
SELECT * FROM employees
WHERE SALARY = (SELECT MIN(SALARY) AS MinSalary from employees);


--task 7
create procedure GetProductSalesSummary @ProductID int
as
begin
select p.productname, sum(s.quantity) as TotalQuantitySold,
sum(s.quantity*p.price) as TotalSalesAmount, min(s.saledate) as firstsaledate,
max(s.saledate) as lastsaledate
from Products p
left join Sales s on p.ProductID =s.ProductID
where p.productid = @ProductID
group by p.productname
end;

exec GetProductSalesSummary @ProductID = 1
	
