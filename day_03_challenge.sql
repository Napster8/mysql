-- Create the required table

-- DROP TABLE IF EXISTS 03_footer;
-- CREATE TABLE 03_footer 
-- (
-- 	id 			INT PRIMARY KEY,
-- 	car 		VARCHAR(20), 
-- 	length 		INT, 
-- 	width 		INT, 
-- 	height 		INT
-- );

-- INSERT INTO 03_footer  VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
-- INSERT INTO 03_footer  VALUES (2, NULL, NULL, NULL, 20);
-- INSERT INTO 03_footer  VALUES (3, NULL, 12, 8, 15);
-- INSERT INTO 03_footer  VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
-- INSERT INTO 03_footer  VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

-- SELECT * FROM 03_footer;

/* Sql query that returns the footer values from input table, 
all last non null values show in expected output.*/


-- Solution 1
WITH 
cte1 AS (SELECT car FROM 03_footer WHERE car IS NOT NULL ORDER BY id DESC LIMIT 1),
cte2 AS (SELECT length FROM 03_footer WHERE length IS NOT NULL ORDER BY id DESC LIMIT 1),
cte3 AS (SELECT width FROM 03_footer WHERE width IS NOT NULL ORDER BY id DESC LIMIT 1),
cte4 AS (SELECT height FROM 03_footer WHERE height IS NOT NULL ORDER BY id DESC LIMIT 1)

SELECT 1 AS id,
    cte1.car AS car_value,
    cte2.length AS length_value,
    cte3.width AS width_value,
    cte4.height AS height_value
FROM cte1
JOIN cte2 ON 1=1
JOIN cte3 ON 1=1
JOIN cte4 ON 1=1;

-- Solution 2 - Solving by CROSS JOIN

WITH 
cte1 AS (SELECT car FROM 03_footer WHERE car IS NOT NULL ORDER BY id DESC LIMIT 1),
cte2 AS (SELECT length FROM 03_footer WHERE length IS NOT NULL ORDER BY id DESC LIMIT 1),
cte3 AS (SELECT width FROM 03_footer WHERE width IS NOT NULL ORDER BY id DESC LIMIT 1),
cte4 AS (SELECT height FROM 03_footer WHERE height IS NOT NULL ORDER BY id DESC LIMIT 1)

SELECT 
    cte1.car AS car_value,
    cte2.length AS length_value,
    cte3.width AS width_value,
    cte4.height AS height_value
FROM cte1
CROSS JOIN cte2
CROSS JOIN cte3
CROSS JOIN cte4;
