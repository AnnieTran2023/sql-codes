--1. Find out the total number of course participants per each course. Display "Number of participants" and course code. Sort the result by (number of participants in descending order, course code in ascending order).

SELECT SUM(participants) as "Number of paticipants", course_code
FROM CourseInstance
GROUP BY course_code
ORDER BY "Number of paticipants" DESC, course_code ASC

--2. How many passing grades does each student have? Display "Number of grades" and student number. Sort the result by (number of grades in descending order, student number in ascending order).

SELECT COUNT(grade) as "Number of grades", student_number
FROM CourseGrade
WHERE grade >= 1
GROUP BY student_number
ORDER BY "Number of grades" DESC, student_number ASC

--3. What is the average grade for each student? Display 'Average grade' and student number. Sort the result by student number in ascending order.

a) First version: display the average grade as an integer (no rounding etc.)
​​SELECT student_number, AVG(grade) as "Average grade"
FROM CourseGrade
GROUP BY student_number
ORDER BY student_number ASC

b) Second version: display the correct average grade with two decimal places.
SELECT student_number, ROUND(AVG(grade)*1.00,2) as "Average grade"
FROM CourseGrade
GROUP BY student_number
ORDER BY student_number ASC

--4. How many course instances has each teacher given? Display teacher number and the number of course instances. Rename the second column as "Number of course instances". Sort the result by teacher number.

SELECT teacher_number, COUNT(instance_number) as "Number of course instances"
FROM CourseInstance
WHERE teacher_number is not NULL
GROUP BY teacher_number
ORDER BY teacher_number

--5. How many different courses has each teacher given? Display teacher number and "Number of different courses". Sort the result by (number of different courses in descending order, teacher number in ascending order)

SELECT teacher_number, COUNT(DISTINCT course_code) as "Number of different courses"
FROM CourseInstance
WHERE teacher_number is not NULL
GROUP BY teacher_number
ORDER BY "Number of different courses" DESC, teacher_number ASC


--6. List all the teachers who have given more than one course instance. Display teacher number and "Number of course instances". Sort the result by teacher number.

SELECT teacher_number, COUNT(instance_number) as "Number of course instances"
FROM CourseInstance
WHERE teacher_number is not null
GROUP BY teacher_number
HAVING COUNT(instance_number) > 1

--7. List for each student the student number, average grade, highest grade, and lowest grade. In the query, rename the columns as "Average grade", "Highest grade", and "Lowest grade". Sort the result by (average grade, student number).
NOTE: Display the correct average grade with two decimal places.

SELECT student_number, ROUND(AVG(grade)*1.00,2) as "Average grade", MAX(grade) as "Highest grade", MIN(grade) as "Lowest grade"
FROM CourseGrade
GROUP BY student_number
ORDER BY  "Average grade", student_number


--8. List the same information as in the previous task, but this time only for those students, whose grade average is above 3.

SELECT student_number, ROUND(AVG(grade)*1.00,2) as "Average grade", MAX(grade) as "Highest grade", MIN(grade) as "Lowest grade"
FROM CourseGrade
GROUP BY student_number HAVING AVG(grade) > 3
ORDER BY  "Average grade", student_number

--9. In which course instances is the number of participants above the average? Display number of participants, course code, and instance number. Sort the result by (number of participants in descending order, course code in ascending order, instance number in ascending order).

SELECT participants, course_code, instance_number
FROM CourseInstance
WHERE participants > (
	SELECT AVG(participants)
	FROM CourseInstance
)
ORDER BY participants DESC, course_code ASC, instance_number ASC


--10. List all the students (surname, first name, student number) who have not passed any courses. Sort the result in ascending order by (surname, first name, student number).
Hint: The table CouseGrade contains facts on all the passing grades. The table Student contains facts on all the students.

SELECT surname, first_name, student_number
FROM Student
WHERE student_number NOT IN (
	SELECT student_number
	FROM CourseGrade 
	WHERE grade is not null 
)
ORDER BY surname, first_name, student_number

--11. List all the teachers (surname, first name, teacher number, salary) who earn more than all of those teachers who work at campus that has campus code 'c222'. Sort the result by (surname, first name, teacher number) in ascending order.

SELECT surname, first_name, teacher_number, salary
FROM Teacher
WHERE salary > (
	SELECT MAX(salary)
	FROM Teacher
	WHERE campus_code = 'c222'
)
ORDER BY surname, first_name, teacher_number

--12. List all the courses (course code, course name) that at least one student has passed this far. Sort the result by course code in ascending order.

SELECT course_code, course_name
FROM Course
WHERE course_code IN (
	SELECT course_code
	FROM CourseGrade
	WHERE grade > 1
)
ORDER BY course_code

--13. List all the courses (course code, course name) that no student has passed this far. Sort the result by course code in ascending order.

SELECT course_code, course_name
FROM Course
WHERE course_code not IN (
	SELECT course_code
	FROM CourseGrade
	WHERE grade > 1
)
ORDER BY course_code

--14. List all the teachers (teacher number, surname, first name) who have not given any courses this far. Sort the result in ascending order by (surname, first name, teacher number).
Hint: What about missing information? See the SQL DML Quick Reference Guide for details.

SELECT teacher_number, surname, first_name
FROM Teacher
WHERE teacher_number not in (
	SELECT person_in_charge
	FROM Course
	WHERE person_in_charge IS NOT NULL
)
ORDER BY surname, first_name, teacher_number


