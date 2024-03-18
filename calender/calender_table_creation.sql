-- Generate 1 row
SELECT 
    CAST('2000-01-01' AS DATE) AS cal_date,
    YEAR('2000-01-01') AS cal_year,
    DAYOFYEAR('2000-01-01') AS cal_year_day,
    QUARTER('2000-01-01') AS cal_quarter,
    MONTH('2000-01-01') AS cal_month,
    DAY('2000-01-01') AS cal_month_day,
    MONTHNAME('2000-01-01') AS cal_month_name,
    WEEK('2000-01-01') + 1 AS cal_week,
    DAYOFWEEK('2000-01-01') AS cal_week_day,
    DAYNAME('2000-01-01') AS cal_week_day_name;

-- How Recursive CTE works    
WITH recursive cte AS (
    SELECT 1 AS id
    UNION ALL
    SELECT id + 1 AS id
    FROM cte
    WHERE id < 10
)

SELECT id FROM cte;



-- 40 years 
select 365 * 40; -- 15000

-- Change the upper limit of recursion depth
SET @@cte_max_recursion_depth = 20000;

-- Using recursive cte 
WITH recursive cte AS (
    SELECT 
        CAST('2000-01-01' AS DATE) AS cal_date,
        YEAR('2000-01-01') AS cal_year,
        DAYOFYEAR('2000-01-01') AS cal_year_day,
        QUARTER('2000-01-01') AS cal_quarter,
        MONTH('2000-01-01') AS cal_month,
        DAY('2000-01-01') AS cal_month_day,
        MONTHNAME('2000-01-01') AS cal_month_name,
        WEEK('2000-01-01') + 1 AS cal_week,
        DAYOFWEEK('2000-01-01') AS cal_week_day,
        DAYNAME('2000-01-01') AS cal_week_day_name
    
    UNION
    
    SELECT 
        cal_date + INTERVAL 1 DAY,
        YEAR(cal_date + INTERVAL 1 DAY),
        DAYOFYEAR(cal_date + INTERVAL 1 DAY),
        QUARTER(cal_date + INTERVAL 1 DAY),
        MONTH(cal_date + INTERVAL 1 DAY),
        DAY(cal_date + INTERVAL 1 DAY),
        MONTHNAME(cal_date + INTERVAL 1 DAY),
        WEEK(cal_date + INTERVAL 1 DAY) + 1,
        DAYOFWEEK(cal_date + INTERVAL 1 DAY),
        DAYNAME(cal_date + INTERVAL 1 DAY)
    FROM cte
    WHERE cal_date < '2031-01-01'
)

SELECT * FROM cte;


-- Save thi into a TABLE

-- Create and insert into the calendar table

CREATE TABLE calendar_table AS
WITH RECURSIVE cte AS (
    SELECT 
        CAST('2000-01-01' AS DATE) AS cal_date,
        YEAR('2000-01-01') AS cal_year,
        DAYOFYEAR('2000-01-01') AS cal_year_day,
        QUARTER('2000-01-01') AS cal_quarter,
        MONTH('2000-01-01') AS cal_month,
        DAY('2000-01-01') AS cal_month_day,
        MONTHNAME('2000-01-01') AS cal_month_name,
        WEEK('2000-01-01') + 1 AS cal_week,
        DAYOFWEEK('2000-01-01') AS cal_week_day,
        DAYNAME('2000-01-01') AS cal_week_day_name
    
    UNION
    
    SELECT 
        cal_date + INTERVAL 1 DAY,
        YEAR(cal_date + INTERVAL 1 DAY),
        DAYOFYEAR(cal_date + INTERVAL 1 DAY),
        QUARTER(cal_date + INTERVAL 1 DAY),
        MONTH(cal_date + INTERVAL 1 DAY),
        DAY(cal_date + INTERVAL 1 DAY),
        MONTHNAME(cal_date + INTERVAL 1 DAY),
        WEEK(cal_date + INTERVAL 1 DAY) + 1,
        DAYOFWEEK(cal_date + INTERVAL 1 DAY),
        DAYNAME(cal_date + INTERVAL 1 DAY)
    FROM cte
    WHERE cal_date < '2031-01-01'
)

-- Select and insert into the calendar_table
SELECT * FROM cte;



select * from calendar_table



