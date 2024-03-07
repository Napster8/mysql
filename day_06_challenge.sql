-- CREATE Table for the problem
-- drop table if exists  06_student_tests;
-- create table 06_student_tests
-- (
-- 	test_id		int,
-- 	marks		int
-- );
-- insert into 06_student_tests values(100, 55);
-- insert into 06_student_tests values(101, 55);
-- insert into 06_student_tests values(102, 60);
-- insert into 06_student_tests values(103, 58);
-- insert into 06_student_tests values(104, 40);
-- insert into 06_student_tests values(105, 50);

-- select * from 06_student_tests;

/*PROBLEM STATEMENT:
You are given a table having the marks of one student in every test. 
You have to output the tests in which the student has improved his performance. 
For a student to improve his performance he has to score more than the previous test.
Provide 2 solutions, 

1. one including the first test score.
2. second excluding it."								
*/								


-- Solution 1: Includes the first test score.
with cte as
    (
    SELECT *, 
           LAG(marks) OVER (ORDER BY test_id ASC) AS prev_marks 
    FROM 06_student_tests
    )

select * from cte
where marks > prev_marks or prev_marks is null


-- Solution 2: Excludes the first test score.
with cte as
    (
    SELECT *, 
           LAG(marks) OVER (ORDER BY test_id ASC) AS prev_marks 
    FROM 06_student_tests
    )

select * from cte
where marks > prev_marks;




