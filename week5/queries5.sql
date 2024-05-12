--1. What course instances does each teacher teach? Display surname, first name, teacher number, course code, and instance number. Sort the result by (surname, first name, course code, instance number).

SELECT t.surname, t.first_name, t.teacher_number, ci.course_code, ci.instance_number
FROM teacher as t
JOIN CourseInstance as ci ON ci.teacher_number = t.teacher_number
ORDER BY t.surname, t.first_name, ci.course_code, ci.instance_number

--2. Who is the person in charge of each course? Display course code, course name, and name of the person in charge. Concatenate surname and first name as "Person in charge". Sort the result by course code in ascending order.

SELECT c.course_code, c.course_name, CONCAT(t.first_name, ', ',t.surname) as "Person in charge"
FROM Course as c
JOIN Teacher as t ON C.person_in_charge = t.teacher_number
ORDER BY c.course_code

--3. What is the grade point average (= average grade) for each student? Display surname, first name, student number, and average grade (with two decimal places, named as "Grade point average"). Sort the result by (surname, first name, student number).

SELECT s.surname, s.first_name, s.student_number, CAST(AVG(cs.grade) AS DECIMAL(4,2)) as "average grade"
FROM CourseGrade as cs
JOIN Student as s ON s.student_number = cs.student_number
GROUP by s.surname, s.first_name, s.student_number
ORDER BY s.surname, s.first_name, s.student_number

--4. Time dimension considerations
a) List all the current academic advisors (surname, first name, teacher number, start date, end date). Sort the result by (surname, first name, teacher number) in ascending order.

SELECT t.surname, t.first_name, t.teacher_number, aa.start_date, aa.end_date
FROM AcademicAdvisor as aa
JOIN Teacher as t ON aa.teacher_number = t.teacher_number
WHERE end_date is null
ORDER BY t.surname, t.first_name, t.teacher_number

b) List all the current and past academic advisors (surname, first name, teacher number, start date, end date). Sort the result by (surname, first name, teacher number) in ascending order.

SELECT t.surname, t.first_name, t.teacher_number, aa.start_date, aa.end_date
FROM AcademicAdvisor as aa
JOIN Teacher as t ON aa.teacher_number = t.teacher_number
ORDER BY t.surname, t.first_name, t.teacher_number

--5. What types of academic misconduct have occurred at Takkula University this far? List misconduct description. Sort the result by misconduct type in ascending order. This time, use a join, not any subquery.

SELECT mt.description as "Misconduct occurred this far"
FROM MisconductType as mt
JOIN MisconductIncident AS mi ON mt.misconduct_code = mi.misconduct_code
WHERE mi.decision_date is not null

--6. List all the students (surname, first name, student number, course code, grade) who live in Helsinki and have at least one course grade greater than 2. Sort the result by (surname, first name, student number, course code). NB! You are required to show only such rows where grade is > 2.

SELECT s.surname, s.first_name, s.student_number, cg.course_code, cg.grade
FROM Student as S
JOIN CourseGrade as cg ON s.student_number = cg.student_number
WHERE s.city = 'Helsinki' and grade >= 2
ORDER BY s.surname, s.first_name, s.student_number, cg.course_code

--7. List all the teachers (course code, course name, teacher number, surname, first name) who have given the course that has the course code 'a730'. Sort the result by teacher number in ascending order.

SELECT DISTINCT ci.course_code, c.course_name, t.teacher_number, t.surname, t.first_name
FROM CourseInstance as ci
JOIN Teacher as t ON ci.teacher_number = t.teacher_number
JOIN Course as c ON C.course_code = CI.course_code
WHERE c.course_code = 'a730'
ORDER BY teacher_number

--8. List all the passing grades (course name, grade, surname, first name, student number) for female students. Sort by the result by (course name, grade in descending order, surname, first name, student number in ascending order).

SELECT c.course_name, cg.grade, s.surname, s.first_name, s.student_number
FROM CourseGrade as cg
JOIN Course as c ON C.course_code = cg.course_code
JOIN Student as s ON s.student_number = cg.student_number
WHERE s.gender = 'F' and grade is not null
ORDER BY course_name, grade DESC, surname, first_name, student_number

--9. In which courses have female students achieved grade 5? Display course code, course name, and the number of grade 5's achieved by female students. Rename the last column as "Grade five". Sort the result by course code in ascending order.

SELECT c.course_code, c.course_name, COUNT(*) as "Number of grade 5"
FROM CourseGrade as cg
JOIN Course as c ON C.course_code = cg.course_code
JOIN Student as s ON s.student_number = cg.student_number
WHERE s.gender = 'F' and grade = 5
GROUP BY  c.course_code, c.course_name
ORDER BY c.course_code

--10. List all the students (surname, first name, student number) of those students, who have grade 3 from any course. Do not allow any duplicate entries in the result. Sort by (surname, first name, student number) in ascending order.

SELECT DISTINCT s.surname, s.first_name, s.student_number
FROM Student as s
JOIN CourseGrade AS cg ON s.student_number = cg.student_number
WHERE grade = 3
ORDER BY s.surname, s.first_name, s.student_number
