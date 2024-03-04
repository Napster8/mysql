-- Create hackers table
-- CREATE TABLE hackers (
--     hacker_id INT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL
-- );

-- -- Insert values into hackers table
-- INSERT INTO hackers (hacker_id, name)
-- VALUES (5580, 'Rose'),
--       (8439, 'Angela'),
--       (27205, 'Frank'),
--       (52243, 'Patrick'),
--       (52348, 'Lisa'),
--       (57645, 'Kimberly'),
--       (77726, 'Bonnie'),
--       (83082, 'Michael'),
--       (86870, 'Todd'),
--       (90411, 'Joe');

-- -- Create difficulty table
-- CREATE TABLE difficulty (
--     difficulty_level INT PRIMARY KEY,
--     score INT NOT NULL
-- );

-- Insert values into difficulty table

-- INSERT INTO difficulty (difficulty_level, score)
-- VALUES (1, 20),
--       (2, 30),
--       (3, 40),
--       (4, 60),
--       (5, 80),
--       (6, 100),
--       (7, 120);

-- -- Create challenges table
-- CREATE TABLE challenges (
--     challenge_id INT PRIMARY KEY,
--     hacker_id INT,
--     difficulty_level INT,
--     FOREIGN KEY (hacker_id) REFERENCES hackers(hacker_id),
--     FOREIGN KEY (difficulty_level) REFERENCES difficulty(difficulty_level)
-- );

-- INSERT INTO challenges (challenge_id, hacker_id, difficulty_level)
-- VALUES (4810, 77726, 4),
--       (21089, 27205, 1),
--       (36566, 5580, 7),
--       (66730, 52243, 6),
--       (71055, 52243, 2);


-- -- Create submissions table
-- CREATE TABLE submissions (
--     submission_id INT PRIMARY KEY,
--     hacker_id INT,
--     challenge_id INT,
--     score INT
-- );

-- -- Insert values into submissions table
-- INSERT INTO submissions (submission_id, hacker_id, challenge_id, score) VALUES
-- (1, 1, 1, 70),
-- (2, 2, 2, 95),
-- (3, 3, 3, 50),
-- (4, 4, 4, 45),
-- (5, 5, 5, 85),
-- (6, 6, 6, 110);


-- Problem Statement - Top Competitors

-- hackers table columns are hacker_id(int), name(string)
-- challenges table columns are challenge_id(int), hacker_id(int), difficulty_level(int)
-- difficulty table columns are difficulty_level(int), score(int)
-- submissions table columns are submission_id(int), hacker_id(int), challenge_id, score(int)

-- Note: 
-- score columnn (lies between 20 to 120)
-- difficulty_level (lies between 1 and 7)

-- Query that prints hacker_id, name of hackers who 
-- achieved full scores for more than one challenge.
-- order you output in descending order by the 
-- total no of chalenges in wich the hacker earned full score and then sort by hacker_id

-- Step wise solution
-- Selecting hacker_id and name from the hackers table
-- Joining submissions table with challenges, difficulty, and hackers tables
-- Filtering records where the score in submissions matches the difficulty score
-- Grouping by hacker_id and name to count occurrences
-- Filtering groups where the count of hacker_id is greater than 1
-- Ordering the result by count in descending order and hacker_id

-- Top Competitors Solution
select hackers.hacker_id, hackers.name
from submissions
join challenges on challenges.challenge_id = submissions.challenge_id
join difficulty on challenges.difficulty_level = difficulty.difficulty_level
join hackers on submissions.hacker_id = hackers.hacker_id
where submissions.score = difficulty.score
group by hackers.hacker_id, name
having count(hackers.hacker_id) > 1
order by count(hackers.hacker_id) desc, hackers.hacker_id;
