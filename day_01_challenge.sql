-- use 30_days_sql

-- Create the table
-- CREATE TABLE day01_sql_01 (
--     brand1 VARCHAR(50),
--     brand2 VARCHAR(50),
--     year INT,
--     custom1 INT,
--     custom2 INT,
--     custom3 INT,
--     custom4 INT
-- );

-- -- Insert the data
-- INSERT INTO day01_sql_01 (brand1, brand2, year, custom1, custom2, custom3, custom4) VALUES
-- ('apple', 'samsung', 2020, 1, 2, 1, 2),
-- ('samsung', 'apple', 2020, 1, 2, 1, 2),
-- ('apple', 'samsung', 2021, 1, 2, 5, 3),
-- ('samsung', 'apple', 2021, 5, 3, 1, 2),
-- ('google', NULL, 2020, 5, 9, NULL, NULL),
-- ('oneplus', 'nothing', 2020, 5, 9, 6, 3);


-- Problem 01:
-- - For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
--     - if custom1 = custom3 and custom2 = custom4 : then keep only one pair

-- - For pairs of brands in the same year 
--     - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs

-- - For brands that do not have pairs in the same year : keep those rows as well



-- Step 1: Create a Common Table Expression (CTE) named 'cte'
WITH cte AS (
    SELECT *,
        CASE 
            WHEN brand1 < brand2 THEN CONCAT(brand1, brand2, year)
            ELSE CONCAT(brand2, brand1, year)
        END AS pair 
    FROM day01_sql_01
),

-- Step 2: Create another CTE named 'cte_2'
cte_2 AS (
    SELECT *, 
        ROW_NUMBER() OVER (PARTITION BY pair ORDER BY pair) AS rn
    FROM cte
)

-- Step 3: Select rows from 'cte_2' based on specified conditions
SELECT * 
FROM cte_2
WHERE rn = 1 OR (custom1 != custom3 AND custom2 != custom4);
