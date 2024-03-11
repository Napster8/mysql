-- drop table if exists 08_job_skills;
-- create table 08_job_skills
-- (
-- 	row_id		int,
-- 	job_role	varchar(20),
-- 	skills		varchar(20)
-- );
-- insert into 08_job_skills values (1, 'Data Engineer', 'SQL');
-- insert into 08_job_skills values (2, null, 'Python');
-- insert into 08_job_skills values (3, null, 'AWS');
-- insert into 08_job_skills values (4, null, 'Snowflake');
-- insert into 08_job_skills values (5, null, 'Apache Spark');
-- insert into 08_job_skills values (6, 'Web Developer', 'Java');
-- insert into 08_job_skills values (7, null, 'HTML');
-- insert into 08_job_skills values (8, null, 'CSS');
-- insert into 08_job_skills values (9, 'Data Scientist', 'Python');
-- insert into 08_job_skills values (10, null, 'Machine Learning');
-- insert into 08_job_skills values (11, null, 'Deep Learning');
-- insert into 08_job_skills values (12, null, 'Tableau');

-- Problem Statement: Fill the job role column


-- select * from 08_job_skills;

-- select *,
--         case when job_role is not null then 1 else 0 end as segment 
-- from 08_job_skills;


with cte1 as (
            select *,
                    case when job_role is not null then 1 else 0 end as part,
                    sum(case when job_role is not null then 1 else 0 end) over (order by row_id) as segment 
            from 08_job_skills
)
  
-- Calculate 'job_role_update' using the first non-null 'job_role' within each 'segment'
select *,
        first_value(job_role) over(partition by segment order by row_id) as job_role_update
from cte1;        

