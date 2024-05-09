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

--10. Write a SELECT statement that generates a list of default email addresses for students. The default domain name is 'takkula.fi'. The default email format is as follows: firstname.surname@takkula.fi No uppercase letters allowed. Rename the column as "Default email". Sort the result by "Default email" in ascending order.
SELECT CONCAT(LOWER(first_name),'.', LOWER(surname),'@takkula.fi') as Default_email
FROM Student
ORDER BY Default_email ASC

--11. List the following facts on each student: name of birth month, surname, first name, and student number. Do not display any other items. Sort the result by (month number, surname, first name, student number) in ascending order.
SELECT DATENAME(MONTH, birth_date) AS month_name, surname, first_name, student_number
FROM Student
ORDER BY MONTH(birth_date), surname,first_name,student_number

--12. How many students were born in May?
SELECT COUNT(*) AS Students_born_in_May
FROM Student
WHERE MONTH(birth_date) = 5

--13. List for each course instance the quarter of the year when the course instance was started. Display also the start date, course code, and instance number. Sort the result by (quarter, start date, course code) in ascending order.
SELECT DATENAME(QUARTER, start_date) as quater, start_date, course_code, instance_number
FROM CourseInstance
ORDER BY quater,start_date , course_code, instance_number

--14. List all the students (birth month, day of birth month, surname, first name, student number). Rename birth month as "Month" and day of birth month as "Day". Sort the result by ("Month", "Day", surname, first name, student number).
SELECT MONTH(birth_date) as Month, DAY(birth_date) as Day, surname, first_name, student_number
FROM Student
ORDER BY Month, Day, surname, first_name, student_number

--15. How many students were born on Sunday?
SELECT COUNT(*) as students_born_on_Sunday
FROM Student
WHERE DATENAME(WEEKDAY, birth_date) = 'Sunday'

--16. Display the current date and weekday. Rename the date as "Current date" and weekday as "Weekday". Hint: Use SYSDATETIME() and the LEFT function to show the date with 10 characters only.
​​SELECT 
    LEFT(CONVERT(VARCHAR, SYSDATETIME(), 10), 10) AS "Current date",
    DATENAME(WEEKDAY, SYSDATETIME()) AS "Weekday";

--17. Use the appropriate function to compute the length of each course in days. List the course length, course code, instance number. Rename the length of course as "Course length". Do not list any courses with an unknown length. Sort the result by (course length, course code, instance number) in ascending order.
SELECT DATEDIFF(DAY, start_date, end_date) as "Course length", course_code, instance_number
FROM CourseInstance
WHERE start_date is not null and end_date is not null
ORDER BY [Course length], course_code, instance_number

--18. Calculate the age in years for each student. Rename age as "Age". Display age, surname, first name, and student number. Sort the result by ("Age" in descending order, surname ASC, first name ASC, student number ASC).
SELECT DATEDIFF(MONTH, birth_date, GETDATE()) AS age, surname, first_name, student_number
FROM Student
ORDER BY age DESC, surname ASC, first_name ASC, student_number ASC;

--19. List all the students (student number, surname, first name, email) whose email server's domain name is not 'takkula.fi'. Do not use LIKE. Sort the result by student number in ascending order.
​​SELECT student_number, surname, first_name, email 
FROM Student
WHERE (RIGHT(email, LEN(email) - CHARINDEX('@', email)) != 'takkula.fi') or email is null
ORDER BY student_number ASC;

--20. List all the different domain names from students' email addresses. Rename the column as "Domain name". Sort the result by "Domain name" in ascending order.
SELECT DISTINCT RIGHT(email, LEN(email) - CHARINDEX('@', email)) AS "Domain name"
FROM Student
WHERE email is not null
ORDER BY "Domain name" ASC

--21. What is the average course instance length in whole days?
SELECT CAST(AVG((DATEDIFF(DAY, start_date, end_date)*1.0)) AS DECIMAL(2,0)) as "Average course instance length"
FROM CourseInstance

