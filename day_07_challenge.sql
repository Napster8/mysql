-- -- drop table if exists Day_Indicator;

-- create table 07_day_indicator
-- (
-- 	id 		varchar(10),	
-- 	day_indicator 	varchar(7),
-- 	dates			date
-- );

-- insert into 07_day_indicator values ('AP755', '1010101', STR_TO_DATE('04-Mar-2024', '%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('04-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('05-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('06-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('07-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('08-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('09-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('AP755', '1010101', STR_TO_DATE('10-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('04-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('05-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('06-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('07-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('08-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('09-Mar-2024','%d-%b-%Y'));
-- insert into  07_day_indicator values ('XQ802', '1000110', STR_TO_DATE('10-Mar-2024','%d-%b-%Y'));





/*
In the given input table DAY_INDICATOR field indicates the day of the week with the first character being Monday, 
followed by Tuesday and so on.
Write a query to filter the dates column to showcase only those days where day_indicator character for that day of the week is 1
*/

select * from 07_day_Indicator;

-- Solution 1: Hardcoded

WITH cte1 as (
            SELECT *, 
                    DAYNAME(dates) AS day_of_week, 
                    IF(DAYOFWEEK(dates) = 1, 7, DAYOFWEEK(dates) - 1) AS iso_day_of_week 
            FROM 07_day_Indicator
), 

    cte2 as (
            SELECT *,
                    CASE
                        WHEN iso_day_of_week = 1 and MID(day_indicator, 1, 1) = 1 then 'keep1'
                        WHEN iso_day_of_week = 2 and MID(day_indicator, 2, 1) = 1 then 'keep2'
                        WHEN iso_day_of_week = 3 and MID(day_indicator, 3, 1) = 1 then 'keep3'
                        WHEN iso_day_of_week = 4 and MID(day_indicator, 4, 1) = 1 then 'keep4'
                        WHEN iso_day_of_week = 5 and MID(day_indicator, 5, 1) = 1 then 'keep5'
                        WHEN iso_day_of_week = 6 and MID(day_indicator, 6, 1) = 1 then 'keep6'
                        WHEN iso_day_of_week = 7 and MID(day_indicator, 7, 1) = 1 then 'keep7'
                        else null
                    END as inp
            from cte1
            HAVING inp is not null
)

select id, day_indicator, dates from cte2;

-- Solution 2
WITH cte1 as (
            SELECT *, 
                    DAYNAME(dates) AS day_of_week, 
                    IF(DAYOFWEEK(dates) = 1, 7, DAYOFWEEK(dates) - 1) AS iso_day_of_week 
            FROM 07_day_Indicator
), 

    cte2 as (
            SELECT *,
                    CASE
                        WHEN iso_day_of_week = iso_day_of_week and MID(day_indicator, iso_day_of_week, 1) = 1 then 'keep'
                        else null
                    END as inp
            from cte1
            HAVING inp is not null
)

select id, day_indicator, dates from cte2
