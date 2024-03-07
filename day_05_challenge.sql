-- Create the necessary tables


-- drop table if exists 05_salary;
-- create table 05_salary
-- (
-- 	emp_id		int,
-- 	emp_name	varchar(30),
-- 	base_salary	int
-- );
-- insert into 05_salary values(1, 'Rohan', 5000);
-- insert into 05_salary values(2, 'Alex', 6000);
-- insert into 05_salary values(3, 'Maryam', 7000);


-- drop table if exists 05_income;
-- create table 05_income
-- (
-- 	id			int,
-- 	income		varchar(20),
-- 	percentage	int
-- );
-- insert into 05_income values(1,'Basic', 100);
-- insert into 05_income values(2,'Allowance', 4);
-- insert into 05_income values(3,'Others', 6);


-- drop table if exists 05_deduction;
-- create table 05_deduction
-- (
-- 	id			int,
-- 	deduction	varchar(20),
-- 	percentage	int
-- );
-- insert into 05_deduction values(1,'Insurance', 5);
-- insert into 05_deduction values(2,'Health', 6);
-- insert into 05_deduction values(3,'House', 4);


-- drop table if exists 05_emp_transaction;
-- create table 05_emp_transaction
-- (
-- 	emp_id		int,
-- 	emp_name	varchar(50),
-- 	trns_type	varchar(20),
-- 	amount		numeric
-- );


/* Problem: 
Write a query to populate the 

task 1
employee transaction table
which contains emp_id, emp_name, trans_type, amount 

task 2
salary report for hr
employee, basic, allowance, others, gross, insurance, health, house, total_dedn

*/


select * from 05_salary;
select * from 05_income;
select * from 05_deduction;

-- task 1
with 
    cte1 as (
    
            (select income as trans_type, percentage, 'income' as type from 05_income)
            union all 
            (select deduction as trans_type, percentage, 'deduction' as type from 05_deduction)
    
    ),
    
    cte2 as (
    
    select * 
    from 05_salary
    cross join cte1
    order by emp_id
    
    )
    
-- query must contain emp_id, emp_name, trans_type, amount 
select emp_id, 
       emp_name, 
       trans_type,
       base_salary,
       -- percentage, 
       round(base_salary * (percentage / 100), 0) as amount 
from cte2;


-- task 2
-- CTE1: Combine income and deduction data with a type column
WITH cte1 AS (
    (SELECT income AS trans_type, percentage, 'income' AS type FROM 05_income)
    UNION ALL 
    (SELECT deduction AS trans_type, percentage, 'deduction' AS type FROM 05_deduction)
),

-- CTE2: Cross join salary data with CTE1 and order by emp_id
cte2 AS (
    SELECT * 
    FROM 05_salary
    CROSS JOIN cte1
    ORDER BY emp_id
),

-- CTE3: Calculate amount based on base_salary and percentage
cte3 AS (
    SELECT emp_id, 
           emp_name, 
           trans_type,
           base_salary,
           ROUND(base_salary * (percentage / 100), 0) AS amount 
    FROM cte2
)

-- select * from cte3;

-- CTE4: Pivot the cte3 table
, cte4 AS (
    SELECT emp_id, emp_name,
    SUM(CASE WHEN trans_type = 'Allowance' THEN amount END) AS Allowance,
    SUM(CASE WHEN trans_type = 'Basic' THEN amount END) AS Basic,
    SUM(CASE WHEN trans_type = 'Others' THEN amount END) AS Others,
    SUM(CASE WHEN trans_type = 'Insurance' THEN amount END) AS Insurance,
    SUM(CASE WHEN trans_type = 'Health' THEN amount END) AS Health,
    SUM(CASE WHEN trans_type = 'House' THEN amount END) AS House,
    SUM(CASE WHEN trans_type IN ('Allowance', 'Basic', 'Others') THEN amount END) AS Gross
    
    
    FROM cte3
    
    GROUP BY emp_id, emp_name
)

-- Final select from CTE4
SELECT *,
       (Basic + Allowance + Others - Insurance - Health - House) AS Net_Pay
       FROM cte4
       order by emp_id;

