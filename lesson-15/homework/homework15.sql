--task 1
select * from employees
where salary = (select min(salary) from employees);


--task 2
select * from products
where price > (select avg(price) from products);


--task 3
SELECT *
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);



--task 4
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);


--task 5
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products AS p2
    WHERE p2.category_id = products.category_id
);


--task 6
select * from employees
where department_id in 
	( select Top 1 department_id from employees
	group by department_id order by avg(salary) desc);


--task 7
select * from employees e
where salary > 
	(select avg(salary) from employees
	where department_id = e.department_id );


--task 8
SELECT *
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM grades g1
    WHERE grade = (
        SELECT MAX(grade)
        FROM grades g2
        WHERE g2.course_id = g1.course_id
    )
);



--task 9
SELECT *
FROM products p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);

--task 10
SELECT *
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);
