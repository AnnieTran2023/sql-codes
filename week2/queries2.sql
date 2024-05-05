--1. List all the male students (student number, surname, first name, gender). Sort the result by student number in ascending order.
SELECT student_number, surname,first_name, gender
FROM Student
WHERE gender = 'M'

--2. List all the female students (first name, surname, student number, gender, city) who live in Espoo. Sort the result by (surname, first name, student number) in ascending order.
SELECT first_name, surname, student_number,gender,city
FROM Student
WHERE city IN ('Espoo','Esbo')
ORDER BY surname, first_name,student_number

--3. List all the students (name, city) who live in the capital city of Finland. Concatenate surname, comma, and first name as "Name". Sort the result by "Name" in ascending order.
SELECT (surname + ',' + first_name) as Name, city
FROM Student
WHERE city = 'Helsinki'
ORDER BY Name

--4. List all the students (surname, first name, city) who do not live in the capital city of Finland. Sort the result by (surname, first name) in ascending order.
SELECT surname,first_name,city
FROM Student
WHERE city != 'Helsinki'
ORDER BY surname, first_name

--5. List all the students (postcode, student number). Sort the result by (postcode, student number) in ascending order.
SELECT postcode, student_number
FROM Student
ORDER BY postcode, student_number

--6. List all the postcodes of the areas where students live, without any duplicate entries. Sort the result in ascending order.
SELECT DISTINCT postcode
FROM Student
ORDER BY postcode

--7. List all the students (city, postcode, surname, first name), who either live in the capital city of Finland within the postcode area 00400  00600 or who live in Espoo. Sort the result by (city, postcode, surname, first name) in ascending order.
SELECT city, postcode, surname, first_name
FROM Student
WHERE city in ('Espoo', 'Esbo') or (postcode >=00400 and postcode <=00600)
ORDER BY city, postcode, surname, first_name

--8. List all the students (postcode, city, surname, first name), who do not live within the postcode area 00600 or 03000. Sort the result by (postcode, city, surname, first name) in ascending order.
SELECT postcode, city, surname, first_name
FROM Student
WHERE NOT (postcode>=00600 and postcode<=03000)
ORDER BY postcode, city, surname, first_name

--9. List all the misconduct types (description) where the description starts with 'A', 'C', 'F', or 'R'. Sort the result in by description ascending order.
SELECT description
FROM MisconductType 
WHERE description LIKE 'A%'or description LIKE 'C%'or description LIKE 'F%' or description LIKE 'R%'
ORDER BY description

--10. List all the misconduct types (description) where the description does not contain any of the following words: 'data, 'research', 'test'. Sort the result by description in ascending order.
SELECT description
FROM MisconductType
WHERE description not like ('%data%') and description not like ('%research%') and description not like ('%test%')
ORDER BY description

--11. List all the teachers' surnames that end with 'ka' or 'ko'. Sort the result in ascending order.
SELECT DISTINCT surname
FROM Teacher
WHERE surname like '%ka' or surname like '%ko'
ORDER BY surname

--12. List all the course instances (course code, instance number, start date, end date) where the end date is missing. Sort the result by (course code, instance number) in ascending order.
SELECT course_code, instance_number, start_date, end_date
FROM CourseInstance
WHERE end_date is NULL
ORDER BY course_code, instance_number

--13. List all the course grade rows (course code, instance number, student number, grade) where the grade value is missing. Sort the result by (course code, instance number, student number) in ascending order
SELECT course_code,instance_number, student_number, grade
FROM CourseGrade
WHERE grade is null
ORDER BY course_code, instance_number, student_number

--14. List all the known course grades (course code, instance number, student number, grade) from the course 'a290'. Sort the result by (course code, grade, student number) in ascending order.
SELECT course_code, instance_number, student_number, grade
FROM CourseGrade
WHERE course_code = 'a290' and grade is not null
ORDER BY course_code, grade, student_number

--15. Write a query that lists those teachers whose new salary would be above 18 800 €, if they would get a rise of 500 € and an additional 15 % salary increase to the old salary. Display surname, first name, new salary, and old salary. In the query, rename the salary columns as "New salary" and "Old salary". Sort the result by (new salary, surname, first name) in descending order.
SELECT surname, first_name, (salary * 0.15 + salary + 500) as new_salary, salary as old_salary
FROM Teacher
WHERE (salary * 0.15 + salary + 500) > 18800
ORDER BY new_salary DESC, surname, first_name 

 --16. List all the students (surname, first name, student number, gender). Display either 'male' or 'female' as the gender. Sort the result by (surname, first name, student number) in ascending order.
SELECT surname, first_name, student_number,
CASE 
WHEN gender = 'F' THEN 'Female'
WHEN gender = 'M' THEN 'Male'
END AS gender
FROM Student
ORDER BY surname, first_name, student_number
