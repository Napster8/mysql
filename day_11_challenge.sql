-- Create TABLE


-- drop table if exists 11_hotel_ratings;
-- create table 11_hotel_ratings
-- (
-- 	hotel 		varchar(30),
-- 	years		int,
-- 	rating 		DECIMAL(5, 1)
-- );
-- insert into 11_hotel_ratings values('Radisson Blu', 2020, 4.8);
-- insert into 11_hotel_ratings values('Radisson Blu', 2021, 3.5);
-- insert into 11_hotel_ratings values('Radisson Blu', 2022, 3.2);
-- insert into 11_hotel_ratings values('Radisson Blu', 2023, 3.8);
-- insert into 11_hotel_ratings values('InterContinental', 2020, 4.2);
-- insert into 11_hotel_ratings values('InterContinental', 2021, 4.5);
-- insert into 11_hotel_ratings values('InterContinental', 2022, 1.5);
-- insert into 11_hotel_ratings values('InterContinental', 2023, 3.8);

-- Testing
select * from 11_hotel_ratings;

-- Problem Statement: 
-- Write a query that excludes the outlier records as shown 
-- in the output


-- Solution 1: Z-Score Method 
-- Z-Score =  (Value - Mean) / STD Deviation
-- Measures exactly how many standard deviations above or below the mean a data point is.
with cte1 as (
                select hotel, 
                       round(avg(rating), 2) as avg_rating,
                       round(stddev(rating),2) as std_dev
                from 11_hotel_ratings
                group by hotel
            )
            
select years, h.hotel, rating, avg_rating, std_dev, round( (  (rating - avg_rating)  / std_dev), 2) as z_score
from 11_hotel_ratings h
join cte1 on cte1.hotel = h.hotel
having ABS(z_score) < 1.5;


-- IQR Method

WITH cte1 AS (
    SELECT
        hotel,
        MIN(rating) AS min_rating,
        MAX(rating) AS max_rating
    FROM
        11_hotel_ratings
    GROUP BY
        hotel
),
cte2 AS (
    SELECT
        hotel,
        min_rating + (max_rating - min_rating) / 4 AS q1,
        min_rating + 2 * (max_rating - min_rating) / 4 AS q2,
        min_rating + 3 * (max_rating - min_rating) / 4 AS q3,
        max_rating AS q4
    FROM
        cte1
)

SELECT
    years,h.hotel,rating,q1,q3,
    -- max_rating - min_rating AS "max-min",
    -- (max_rating - min_rating) / 4 AS "interval",
    q3-q1 as "iqr = q3-q1",
    q1 - 1.5 * (q3-q1) as lower_bound,
    q3 + 1.5 * (q3-q1) as upper_bound,
    CASE
        WHEN rating <= q1 THEN 'Q1'
        WHEN rating <= q2 THEN 'Q2'
        WHEN rating <= q3 THEN 'Q3'
        ELSE 'Q4'
    END AS quartile_flag
FROM
    11_hotel_ratings h
JOIN cte1 ON cte1.hotel = h.hotel
JOIN cte2 ON cte2.hotel = h.hotel
HAVING rating >= lower_bound and rating <= upper_bound;
