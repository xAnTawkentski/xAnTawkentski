--Task 1
Select 
id,
SUBSTRING(Name,1,CHARINDEX(',',NAme)-1) as Name,
SUBSTRING(Name,CHARINDEX(',',Name )+1,len(Name)) as Surename
from TestMultipleColumns;


--Task 2
SELECT *
FROM TestPercent
WHERE Strs LIKE '%\%%' ESCAPE '\';


--Task 3
Select value from   string_split ((
select STRING_AGG(Vals,'.') from Splitter),'.');



--Task 4
declare @str varchar(100)='1234ABC123456XYZ1234567890ADS'
declare @num int = 1
while @num < len(@str)
begin
  declare @val varchar(30) = substring(@str,@num,1)
  if @val like '[0-9]'
    begin
    set @str = replace(@str,@val,'X')
    --select @str
    end
  set @num += 1
end
select @str;


--Task 5
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;


--Task 6
Select len(texts) from CountSpaces
SELECT LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS space_count
FROM CountSpaces;


--Task 7
Select E.Id,e.Name,E.Salary,M.Name,M.Salary from Employee  as E
inner join Employee as M
on E.ManagerId=m.Id and E.Salary>m.Salary;


--Task 8
Select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,HIRE_DATE,DATEDIFF(year,HIRE_DATE,GETDATE()) as YearofService from Employees
where DATEDIFF(year,HIRE_DATE,GETDATE())>10 and DATEDIFF(year,HIRE_DATE,GETDATE())<15;


--Medium Tasks

--Medium Task 1
create table #test ( numbers varchar(10), letters varchar(10))

declare @txt varchar(50) = 'rtcfvty34redt'

declare @num int = 1

while @num < len(@txt)
  begin
    declare @val varchar(10) = substring(@txt,@num,1)
    if @val not like '[0-9]'
      begin
        insert into #test (letters )values (@val)
        
      end
    else
      begin
      insert into #test (numbers )values (@val)
      end
    set @num += 1
  end
select string_agg(numbers,'') as numbers,string_agg(letters,'') as letter from #test;



 --Medium task 2
 select * from weather as w1
 inner join weather as w2
 on w1.RecordDate=w2.RecordDate 
 WHERE w1.Temperature<w2.Temperature;

 --Medium TASK 3
 select player_id,min(event_date) as firstdate from Activity 
 group by player_id;


--Medium TASK 4
SELECT 
  SUBSTRING(
    fruit_list,
    CHARINDEX(',', fruit_list) + 1 + CHARINDEX(',', fruit_list) + 1,
    CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - CHARINDEX(',', fruit_list) - 1
  ) AS thrid_fruit
FROM fruits;


--Medium TAsk 5 
WITH Characters AS (
    SELECT SUBSTRING('sdgfhsdgfhs@121313131', number, 1) AS value
    FROM master.dbo.spt_values
    WHERE type = 'P' AND number <= LEN('sdgfhsdgfhs@121313131')
)
SELECT value
FROM Characters;


--Medium TAsk 6
Select p1.id,REPLACE(p1.code,0,p2.code) as Rcode from p1
inner join p2
on p1.id=p2.id;


--Medium TAsk 7
Select EMPLOYEE_ID,
       FIRST_NAME,
	   LAST_NAME,
	   HIRE_DATE,
	   DATEDIFF(year,HIRE_DATE,GETDATE()) as YearofService ,
	   case 
	   when DATEDIFF(year,HIRE_DATE,GETDATE()) < 1 then 'New Hire'
	   when DATEDIFF(year,HIRE_DATE,GETDATE())  between 1 and 4 then 'Junior'
	   when DATEDIFF(year,HIRE_DATE,GETDATE())  between 5 and 9 then 'Mid-Level'
	   when DATEDIFF(year,HIRE_DATE,GETDATE())  between 10 and 19 then 'Senior'
	   else 'Veteran' end as Employment_stage
	   from Employees;
