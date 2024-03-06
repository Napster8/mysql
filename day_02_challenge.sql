# Create the necessary tables for the problem

drop table if exists 02_mountain_huts;
create table 02_mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into 02_mountain_huts values (1, 'Dakonat', 1900);
insert into 02_mountain_huts values (2, 'Natisa', 2100);
insert into 02_mountain_huts values (3, 'Gajantut', 1600);
insert into 02_mountain_huts values (4, 'Rifat', 782);
insert into 02_mountain_huts values (5, 'Tupur', 1370);

drop table if exists 02_trails;
create table 02_trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into 02_trails values (1, 3);
insert into 02_trails values (3, 2);
insert into 02_trails values (3, 5);
insert into 02_trails values (4, 5);
insert into 02_trails values (1, 5);


/*
A ski resort company is planning to construct a new ski slope using a pre-existing network of
mountain huts and trails between them. 
A new slope has to begin at one of the mountain huts,
have a middle station at another hut connected with the first one by a direct trail, and end at
the third mountain hut which is also connected by a direct trail to the second hut. The altitude
of the three huts chosen for constructing the ski slope has to be strictly decreasing.

You are given two SQL tables, mountain_huts and trails, with the following structure:

* Each entry in the table trails represents a direct connection between huts with IDs hut1 and
hut2. 
* Note that all trails are bidirectional.
* Create a query that finds all triplets(startpt,middlept,endpt) representing the mountain huts
that may be used for construction of a ski slope.
* Output returned by the query can be ordered in any way.

*/

select * from 02_mountain_huts;
select * from 02_trails;


WITH cte1 AS (
            SELECT
                02_trails.hut1 AS hut1_id,
                02_mountain_huts1.name AS hut1_name, 
                02_mountain_huts1.altitude AS hut1_alt,
                02_trails.hut2 AS hut2_id,
                02_mountain_huts2.name AS hut2_name, 
                02_mountain_huts2.altitude AS hut2_alt 
            FROM 
                02_trails
            JOIN 
                02_mountain_huts AS 02_mountain_huts1 ON 02_trails.hut1 = 02_mountain_huts1.id
            JOIN 
                02_mountain_huts AS 02_mountain_huts2 ON 02_trails.hut2 = 02_mountain_huts2.id
        ),

    cte2 AS (
        SELECT *, 
            CASE 
                WHEN hut1_alt > hut2_alt THEN 'straight'
                ELSE 'reverse'
            END AS conditions
        FROM cte1
    ),

    cte3 AS (
        SELECT
            -- when condition is straight
            CASE WHEN conditions = 'straight' THEN hut1_id
                 ELSE hut2_id
            END AS h1_id,
            
            CASE WHEN conditions = 'straight' THEN hut1_name
                 ELSE hut2_name
            END AS h1,
        
            -- when condition is reversed
            CASE WHEN conditions = 'reverse' THEN hut1_id
                 ELSE hut2_id
            END AS h2_id,
            
            CASE WHEN conditions = 'reverse' THEN hut1_name
                 ELSE hut2_name
            END AS h2
        
        
        FROM cte2
    )

-- self join
select c1.h1 as h1, c1.h2 as h2, c2.h2 as h3
from cte3 c1
join cte3 c2 on c1.h2_id = c2.h1_id
