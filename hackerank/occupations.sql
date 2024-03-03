-- CREATE TABLE grades (
--     Grade INT PRIMARY KEY,
--     Min_Mark INT,
--     Max_Mark INT
-- );

-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (1, 0, 9);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (2, 10, 19);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (3, 20, 29);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (4, 30, 39);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (5, 40, 49);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (6, 50, 59);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (7, 60, 69);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (8, 70, 79);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (9, 80, 89);
-- INSERT INTO grades (Grade, Min_Mark, Max_Mark) VALUES (10, 90, 100);

-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (1, 'John Doe', 85);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (2, 'Jane Smith', 92);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (3, 'Alice Johnson', 78);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (4, 'Bob Williams', 89);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (5, 'Eva Brown', 95);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (6, 'Chris Davis', 80);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (7, 'Sophia Taylor', 88);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (8, 'Michael White', 75);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (9, 'Olivia Lee', 93);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (10, 'Daniel Clark', 86);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (11, 'Mia Wilson', 90);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (12, 'David Martinez', 79);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (13, 'Ava Harris', 91);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (14, 'Ethan Turner', 84);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (15, 'Grace Jackson', 87);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (16, 'Liam Anderson', 94);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (17, 'Emma Garcia', 82);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (18, 'Noah Taylor', 77);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (19, 'Chloe Brown', 96);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (20, 'Logan Miller', 83);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (21, 'Sophie Turner', 8);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (22, 'Aiden Harris', 15);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (23, 'Zoe Smith', 25);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (24, 'Caleb Johnson', 35);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (25, 'Nora Davis', 45);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (26, 'Eli Brown', 55);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (27, 'Hannah Taylor', 65);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (28, 'Owen White', 75);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (29, 'Isabella Lee', 85);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (30, 'Jackson Clark', 95);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (31, 'Lucy Wilson', 5);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (32, 'Leo Martinez', 18);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (33, 'Penelope Harris', 28);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (34, 'Wyatt Turner', 38);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (35, 'Scarlett Jackson', 48);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (36, 'Mason Anderson', 58);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (37, 'Aria Garcia', 68);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (38, 'Grayson Taylor', 78);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (39, 'Lily Miller', 88);
-- INSERT INTO `students` (`ID`, `Name`, `Marks`) VALUES (40, 'Oliver Smith', 98);




-- Query 1 Does not work for some reason but is logically the same
SELECT 
    CASE 
        WHEN grades.grade >= 8 THEN students.name
        ELSE NULL
    END AS student_name,  -- Use a clear alias to avoid ambiguity
    students.marks,
    grades.grade
FROM 
    students
JOIN 
    grades ON students.marks >= grades.min_mark AND students.marks <= grades.max_mark
ORDER BY grades.grade DESC, student_name ASC, students.marks ASC;

-- Query 2 works
SELECT CASE
            WHEN Grades.Grade < 8 THEN 'NULL'
            ELSE Students.Name
            END,
Grades.Grade, Students.Marks
FROM Students
INNER JOIN Grades
ON Students.Marks BETWEEN Grades.Min_Mark and Grades.Max_Mark
ORDER BY Grades.Grade DESC, Students.Name ASC, Students.Marks ASC;

