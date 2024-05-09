--1. How many rows there are in the CourseGrade table?
SELECT COUNT(*) AS Number_of_rows
FROM CourseGrade

--2. What is the total number of grades in the CourseGrade table?
SELECT COUNT(grade) AS Number_of_grades
FROM CourseGrade

--3. How many teachers earn more than 16 000?
SELECT COUNT(*) AS Teachers_who_earn_more_than_16000
FROM Teacher
WHERE salary > 16000

--4. Display teachers' maximum salary, minimum salary, average salary, and the total of all salaries. Display the result with appropriate column headings
SELECT MIN(salary) as min_salary, MAX(salary) as max_salary, AVG(salary) as average_salary, SUM(salary) as total_salary
FROM Teacher

--5. What is the average grade for all the students? Write the following three versions of the query:
a) Display the rough average (with no conversions or rounding)
SELECT AVG(grade) as average_grade
FROM CourseGrade

b) Display the correct average with 2 decimal places (see below for instruction).
SELECT CAST(AVG(grade*1.0) AS DECIMAL(4,2)) as average_grade
FROM CourseGrade

c) Display the correct average with no decimal places (see below for instruction).
SELECT CAST(AVG(grade*1.0) AS DECIMAL(4,0)) as average_grade
FROM CourseGrade

--6. How many times has the grade 3 been given this far?
SELECT COUNT(grade) as number_of_grade_3
FROM CourseGrade
WHERE grade = 3

--7. What is the average grade (with 2 decimal places) for the student whose student number is 'o473'?
SELECT CAST(AVG(grade*1.0) AS DECIMAL(4,2)) as o473_average_grade
FROM CourseGrade
WHERE student_number = 'o473'

--8. How many students' first name starts with the letter 'K'?
SELECT COUNT(*) AS First_names_starting_with_K
FROM Student
WHERE first_name LIKE 'K%'

--9. How many different surnames of teachers there are that start with the letter 'T'?
SELECT COUNT(DISTINCT surname) AS different_surnames_starting_with_T
FROM Teacher
WHERE surname LIKE 'T%'
