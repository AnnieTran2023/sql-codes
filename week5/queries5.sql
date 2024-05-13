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

--11. List all the teachers (teacher number, surname, first name, month name of the grade date) who have evaluated a course in May. Rename the last column as "Grade month". Sort the result by teacher number in ascending order.

SELECT t.teacher_number, t.surname, t.first_name, DATENAME(MONTH,cg.grade_date) as "Grade Month"
FROM Teacher AS t
JOIN CourseGrade AS cg ON t.teacher_number = cg.examiner
WHERE DATENAME(MONTH,cg.grade_date) = 'May'
ORDER BY teacher_number

--12. How are the average grade and the total number of grades distributed between female and male students? Display gender, average grade (with 2 decimal places) and the number of grades. Rename the last two columns as "Average grade" and "Number of grades". Sort by "Average grade" in descending order.

SELECT s.gender, CAST((SUM(cg.grade)*1.00/COUNT(grade)) AS decimal(5,2)) AS "Average grade", COUNT(grade) AS "Number of grades"
FROM CourseGrade as cg
JOIN Student as s ON s.student_number = cg.student_number
WHERE grade is not null
GROUP BY gender
ORDER BY "Average grade" DESC

--13. Create a Cartesian product using the tables Campus and AcademicAdvisor, without any duplicate entries. Display campus name and teacher number. Sort the result by (campus name, teacher number) in ascending order.

SELECT DISTINCT campus_name, teacher_number
FROM Campus 
CROSS JOIN AcademicAdvisor 
ORDER BY campus_name, teacher_number

--14. List the courses that students have failed due to an academic misconduct incident. Display course code, instance number, course name, student number, surname, first name, and misconduct description.

SELECT mi.course_code, instance_number, course_name, mi.student_number, surname, first_name, mt.description
FROM MisconductIncident as mi
JOIN MisconductType as mt ON mi.misconduct_code = mt.misconduct_code
JOIN Course as c ON c.course_code = mi.course_code
JOIN Student as s ON s.student_number = mi.student_number

--15. List all the students (student number, surname, first name, disciplinary sanction, misconduct description) who have got a written warning due to an academic misconduct incident.

SELECT mi.student_number, surname, first_name, st.description, mt.description
FROM MisconductIncident as mi
JOIN Student as s ON S.student_number = MI.student_number
JOIN MisconductType as mt ON mi.misconduct_code = mt.misconduct_code
JOIN SanctionType as st ON st.sanction_code = mi.sanction_code
WHERE st.description = 'Written warning'

--16. What is the prevalence of academic misconduct at Takkula University? Find out the percentage of students who have been penalized due to an academic misconduct incident. Display the percentage with one decimal place. Rename the column as "Misconduct %".

SELECT CAST(ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM Student),1) AS decimal(5,1)) as "Misconduct %"
FROM MisconductIncident

--17. List all the courses (course name, teacher number, teacher name) where the person in charge has also been the teacher of an instance of the course. Concatenate surname and first name "Person in charge teaching". Sort the result by (surname, first name, teacher number) in ascending order.

SELECT c.course_name,
	CONCAT(t.surname, ', ', t.first_name) AS teacher_name,
       c.person_in_charge AS teacher_number
      
FROM Course AS c
JOIN Teacher AS t ON c.person_in_charge = t.teacher_number
JOIN CourseInstance AS ci ON c.course_code = ci.course_code AND c.person_in_charge = ci.teacher_number
ORDER BY t.surname, t.first_name, c.person_in_charge;
 

