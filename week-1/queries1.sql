--1. Write a SELECT statement that lists all the campuses. Display all columns. The order of rows and columns does not matter.
SELECT * FROM Campus

--2. Write a SELECT statement that lists all the campuses. Display city and campus name. Sort the result by (city, campus name) in ascending order.
SELECT city, campus_name
FROM Campus
ORDER BY city, campus_name

--3. What kinds of disciplinary sanctions there are at the University? List all sanctions (description and decision maker). Sort the result by sanction code in descending order.
SELECT description, decision_maker
FROM SanctionType
ORDER BY sanction_code DESC

--4. What types of academic misconduct are mentioned in the MiscondcutType table? List all the misconduct descriptions. Sort the result by description in ascending order.
SELECT description
FROM MisconductType
ORDER BY description

--5. List all the teachers (surname, first name, teacher number). Sort the result by (surname, first name, teacher number) in ascending order.
SELECT surname, first_name, teacher_number
FROM Teacher
ORDER BY surname, first_name,teacher_number

--6. List all the female students (student number, surname, first name, birth date, gender). Sort the result by student number in ascending order.
SELECT student_number,surname,first_name,birth_date,gender
FROM Student
WHERE gender = 'F'
ORDER BY student_number

--7. List all the teachers (salary, surname, first name, teacher number) whose salary is greater than 16 000. Sort the result by salary in descending order
SELECT salary,surname,first_name,teacher_number
FROM Teacher
WHERE salary > 16000
ORDER BY salary DESC

--8. Write a SELECT statement that finds Veera Vainio's teacher number.
SELECT teacher_number
FROM Teacher
WHERE first_name = 'Veera' and surname = 'Vainio'

--9. List all the grades (examiner's teacher number, course code, instance number, student number, grade) that have been given by Veera Vainio. 
SELECT Teacher.teacher_number as examiner, course_code, instance_number, student_number, grade
FROM CourseGrade
JOIN Teacher ON CourseGrade.examiner = Teacher.teacher_number
WHERE Teacher.first_name = 'Veera' and Teacher.surname = 'Vainio'
ORDER BY course_code,instance_number,student_number

--10. List all the course instances (start date, end date, course code, instance number) that have startedand ended in 2007. Sort the result by (start date, end date, course code, instance number) in ascending order.
SELECT start_date,end_date,course_code,instance_number
FROM CourseInstance
WHERE YEAR(start_date) = 2007 and YEAR(end_date) = 2007
ORDER BY start_date,end_date, course_code,instance_number

--11. List all the students (gender, birth date, surname, first name) whose surname is in the range of (A-K). Display girls after all boys in the list. Boys should be listed in ascending order by birth date.
SELECT gender,birth_date,surname,first_name
FROM Student
WHERE surname >= 'A' and surname <= 'L'
ORDER BY gender DESC, birth_date
