
--task 1
select concat (employee_id,'-', first_name, ' ', last_name)
as Employee_info
from Employees
where EMPLOYEE_ID=100;

--task 2
update Employees
set PHONE_NUMBER =
REPLACE(phone_number, '124','999')
where PHONE_NUMBER like '%124%';

--task 3
select first_name as FirstName,
LEN(first_name) as NameLenght
from Employees
where left(first_name, 1) in ('A','J','M')
ORDER BY first_name;

--task 4
select manager_id, sum(salary) as TotalSalary
from Employees
group by MANAGER_ID;

--task 5
select year1, 
	(select max(v) 
	from (values (max1), (max2), (max3))
	as MaxValue(v))
as highest_value
from TestMax;

--task 6
select * from cinema
where id % 2 = 1 and description <> 'boring';

--task 7
select * from SingleOrder
order by IIF(id=0,1,0),id;

--task 8
select coalesce(ssn, passportid, itin)
as first_non_null
from person


--medium task 1

select left(
			FullName, CHARINDEX(' ',FullName,1)-1
			)as FirstName,

substring(
			FullName,
			charindex(' ',FullName,1)+1,
			charindex(' ',FullName,charindex(' ',FullName)+1)-charindex(' ',FullName) -1
			)as MiddleName,

SUBSTRING(
	FullName,
	charindex(' ',FullName, charindex(' ',FullName) + 1) +1,
	len(FullName)
	) as LastName
from Students;


--medium task 2
select * from Orders
where DeliveryState = 'tx'
and CustomerID in (
	select distinct CustomerID
from Orders
where DeliveryState = 'CA');



--medium task 3

SELECT STRING_AGG([string], CHAR(13) + CHAR(10)) WITHIN GROUP (
					ORDER BY sequencenumber
					) AS full_query
FROM DMLTable;


--medium task 4

select first_name,LAST_NAME, FIRST_NAME + ' '+LAST_NAME as fullname,
len(first_name + last_name) - len(replace(FIRST_NAME+LAST_NAME,'a','')) as aHarfi
from Employees
where (len(FIRST_NAME+LAST_NAME) - len(replace(FIRST_NAME+last_name,'a',''))) >= 3;


--medium task 5
SELECT
    JOB_ID,
    COUNT(*) AS total_employees,
    CAST(SUM(CASE 
                WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 3 THEN 1 
                ELSE 0 
             END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS percentage_over_3_years
FROM Employees
GROUP BY JOB_ID;


--medium task 6

select JobDescription,
max(MissionCount) as MaxYear,
min (MissionCount) as MinYear
from Personal
group by JobDescription


--Difficult Tasks 1
DECLARE @input_string VARCHAR(100) = 'tf56sd#%OqH';

SELECT 
    -- Kichik harflar
    (SELECT STRING_AGG(SUBSTRING(@input_string, number, 1), '') 
     FROM master.dbo.spt_values 
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@input_string) 
     AND SUBSTRING(@input_string, number, 1) LIKE '[a-z]') AS lowercase_letters,
    
    -- Katta harflar
    (SELECT STRING_AGG(SUBSTRING(@input_string, number, 1), '') 
     FROM master.dbo.spt_values 
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@input_string) 
     AND SUBSTRING(@input_string, number, 1) LIKE '[A-Z]') AS uppercase_letters,
    
    -- Raqamlar
    (SELECT STRING_AGG(SUBSTRING(@input_string, number, 1), '') 
     FROM master.dbo.spt_values 
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@input_string) 
     AND SUBSTRING(@input_string, number, 1) LIKE '[0-9]') AS numbers,
    
    -- Boshqa belgilar
    (SELECT STRING_AGG(SUBSTRING(@input_string, number, 1), '') 
     FROM master.dbo.spt_values 
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@input_string) 
     AND SUBSTRING(@input_string, number, 1) NOT LIKE '[a-zA-Z0-9]') AS other_characters;




