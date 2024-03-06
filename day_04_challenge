-- drop table if exists 04_data;
-- create table 04_data
-- (
-- 	id			int,
-- 	name		varchar(20),
-- 	location	varchar(20)
-- );
-- insert into 04_data values(1,null,null);
-- insert into 04_data values(2,'David',null);
-- insert into 04_data values(3,null,'London');
-- insert into 04_data values(4,null,null);
-- insert into 04_data values(5,'David',null);


-- EXPECTED OUTPUT - 1
-- ID    NAME    LOCATION
-- 1     David   London

-- EXPECTED OUTPUT - 2
-- ID    NAME    LOCATION
-- 5     David   London


select * from 04_data;

-- Solution 1: Fetching using min
select min(id), min(name), min(location) from 04_data;

-- Solution 2: Fetching using max
select max(id), max(name), max(location) from 04_data;
