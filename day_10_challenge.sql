-- drop table if exists 10_auto_repair;
-- create table 10_auto_repair
-- (
-- 	client			varchar(20),
-- 	auto			varchar(20),
-- 	repair_date		int,
-- 	indicator		varchar(20),
-- 	value			varchar(20)
-- );
-- insert into 10_auto_repair values('c1','a1',2022,'level','good');
-- insert into 10_auto_repair values('c1','a1',2022,'velocity','90');
-- insert into 10_auto_repair values('c1','a1',2023,'level','regular');
-- insert into 10_auto_repair values('c1','a1',2023,'velocity','80');
-- insert into 10_auto_repair values('c1','a1',2024,'level','wrong');
-- insert into 10_auto_repair values('c1','a1',2024,'velocity','70');
-- insert into 10_auto_repair values('c2','a1',2022,'level','good');
-- insert into 10_auto_repair values('c2','a1',2022,'velocity','90');
-- insert into 10_auto_repair values('c2','a1',2023,'level','wrong');
-- insert into 10_auto_repair values('c2','a1',2023,'velocity','50');
-- insert into 10_auto_repair values('c2','a2',2024,'level','good');
-- insert into 10_auto_repair values('c2','a2',2024,'velocity','80');

/*
Output should look like this
This table stores velocity levels with good, wrong, and regular classifications.

level  | velocity   | good  | wrong     | regular
-------|------------|--------|----------|--------
50     | 0          | 1      | 0        | 0
70     | 0          | 0      | 1        | 0
80     | 1          | 0      | 0        | 1
90     | 2          | 0      | 0        | 0

*/

-- testing
select * from 10_auto_repair where indicator = 'level';
select * from 10_auto_repair where indicator = 'velocity';

-- Part 1 Self Joining
SELECT v.value as velocity, i.value as levels, count(*) as valuecount
FROM 10_auto_repair i
JOIN 10_auto_repair v ON i.client = v.client
                      AND i.auto = v.auto
                      AND i.repair_date = v.repair_date
WHERE i.indicator = 'level' AND v.indicator = 'velocity'
GROUP BY v.value, i.value
ORDER BY v.value, i.value;



SELECT
  velocity,
  SUM(CASE WHEN levels = 'good' THEN valuecount ELSE 0 END) AS good,
  SUM(CASE WHEN levels = 'wrong' THEN valuecount ELSE 0 END) AS wrong,
  SUM(CASE WHEN levels = 'regular' THEN valuecount ELSE 0 END) AS regular
  
FROM (
  SELECT
    v.value AS velocity,
    i.value AS levels,
    COUNT(*) AS valuecount
  FROM 10_auto_repair i
  JOIN 10_auto_repair v ON i.client = v.client
                        AND i.auto = v.auto
                        AND i.repair_date = v.repair_date
  WHERE i.indicator = 'level' AND v.indicator = 'velocity'
  GROUP BY v.value, i.value
) AS subquery
GROUP BY velocity
ORDER BY velocity;
