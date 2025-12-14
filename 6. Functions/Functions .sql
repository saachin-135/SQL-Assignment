


-- 1. CREATE TABLE
CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(30),
    score INT,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);

-- 2. INSERT DATA
INSERT INTO Student_Performance 
(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101, 'Aarav Mehta', 'Data Science', 88, 92, 'Dr. Sharma', '2023-06-12', 'Mumbai'),
(102, 'Riya Singh', 'Data Science', 76, 85, 'Dr. Sharma', '2023-07-01', 'Delhi'),
(103, 'Kabir Khanna', 'Python', 91, 96, 'Ms. Nair', '2023-06-20', 'Mumbai'),
(104, 'Tanvi Patel', 'SQL', 84, 89, 'Mr. Iyer', '2023-05-30', 'Bengaluru'),
(105, 'Ayesha Khan', 'Python', 67, 81, 'Ms. Nair', '2023-07-10', 'Hyderabad'),
(106, 'Dev Sharma', 'SQL', 73, 78, 'Mr. Iyer', '2023-05-28', 'Pune'),
(107, 'Arjun Verma', 'Tableau', 95, 98, 'Ms. Kapoor', '2023-06-15', 'Delhi'),
(108, 'Meera Pillai', 'Tableau', 82, 87, 'Ms. Kapoor', '2023-06-18', 'Kochi'),
(109, 'Nikhil Rao', 'Data Science', 79, 82, 'Dr. Sharma', '2023-07-05', 'Chennai'),
(110, 'Priya Desai', 'SQL', 92, 94, 'Mr. Iyer', '2023-05-27', 'Bengaluru'),
(111, 'Siddharth Jain', 'Python', 85, 90, 'Ms. Nair', '2023-07-02', 'Mumbai'),
(112, 'Sneha Kulkarni', 'Tableau', 74, 83, 'Ms. Kapoor', '2023-06-09', 'Pune'),
(113, 'Rohan Gupta', 'SQL', 89, 91, 'Mr. Iyer', '2023-05-25', 'Delhi'),
(114, 'Anita Joshi', 'Data Science', 93, 97, 'Dr. Sharma', '2023-06-03', 'Bengaluru'),
(115, 'Yuvraj Rao', 'Python', 71, 84, 'Ms. Nair', '2023-07-12', 'Hyderabad');




-- ASSIGNMENT SOLUTIONS
-- ============================

-- Q1: Ranking students based on score (highest first)
SELECT 
    name,
    score,
    RANK() OVER (ORDER BY score DESC) AS score_rank
FROM Student_Performance;


-- Q2: Score + previous student’s score
SELECT 
    name,
    score,
    LAG(score, 1) OVER (ORDER BY score DESC) AS previous_score
FROM Student_Performance;


-- Q3: Convert names to uppercase + extract month name
SELECT 
    UPPER(name) AS name_upper,
    MONTHNAME(join_date) AS join_month
FROM Student_Performance;


-- Q4: Next student’s attendance (ordered by attendance)
SELECT 
    name,
    attendance,
    LEAD(attendance, 1) OVER (ORDER BY attendance) AS next_attendance
FROM Student_Performance;


-- Q5: NTILE – 4 performance groups
SELECT 
    name,
    score,
    NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM Student_Performance;


-- Q6: Row number by course based on attendance (highest first)
SELECT 
    name,
    course,
    attendance,
    ROW_NUMBER() OVER (PARTITION BY course ORDER BY attendance DESC) AS rank_in_course
FROM Student_Performance;


-- Q7: Days enrolled (from join_date to 2025-01-01)
SELECT 
    name,
    DATEDIFF('2025-01-01', join_date) AS days_enrolled
FROM Student_Performance;


-- Q8: Format join_date as "Month Year"
SELECT 
    name,
    DATE_FORMAT(join_date, '%M %Y') AS formatted_join_date
FROM Student_Performance;


-- Q9: Replace ‘Mumbai’ with ‘MUM’
SELECT 
    name,
    REPLACE(city, 'Mumbai', 'MUM') AS updated_city
FROM Student_Performance;


-- Q10: Highest score per course using FIRST_VALUE()
SELECT 
    name,
    course,
    score,
    FIRST_VALUE(score) OVER (PARTITION BY course ORDER BY score DESC) AS highest_in_course
FROM Student_Performance;
