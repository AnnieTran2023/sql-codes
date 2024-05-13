--1. List all the courses (surname, first name, teacher number, course name) that have been given by the teacher whose teacher number is 'h303'. Sort the result by course name in ascending order.

SELECT DISTINCT surname, first_name, ci.teacher_number, course_name
FROM CourseInstance as ci
JOIN Course as c ON c.course_code = ci.course_code
JOIN Teacher as t ON ci.teacher_number = t.teacher_number
WHERE t.teacher_number = 'h303'
ORDER BY course_name

--2. List all the teachers (surname, first name, teacher number, course name). If a teacher is in charge of a course, then also the course name should be shown. Sort the result by (surname, first name, teacher number, course name) in ascending order.

SELECT t.surname, t.first_name, t.teacher_number, c.course_name
FROM Teacher AS t
LEFT JOIN Course AS c ON t.teacher_number = c.person_in_charge
ORDER BY t.surname, t.first_name, t.teacher_number, c.course_name;

--3. List all the course instances (course code, instance number, start date, surname, first name, teacher number) that have started in 2008. Concatenate surname and first name as "Teacher". Sort the result by (course code, instance number) in ascending order.

SELECT t.surname, t.first_name, t.teacher_number, c.course_name
FROM Teacher AS t
LEFT JOIN Course AS c ON t.teacher_number = c.person_in_charge
ORDER BY t.surname, t.first_name, t.teacher_number, c.course_name;

--4. List all the teachers (campus name, surname, first name, teacher number, course name). If the teacher is in charge of a course, then also the course name should be shown. Sort the result by (campus name, surname, first name, teacher number, course name) in ascending order.

SELECT c.campus_name, t.surname, t.first_name, t.teacher_number, co.course_name
FROM Teacher as t
LEFT JOIN Campus as c ON C.campus_code = t.campus_code
LEFT JOIN Course as co ON T.teacher_number = co.person_in_charge
ORDER BY c.campus_name, t.surname, t.first_name, t.teacher_number, co.course_name

--5. List the number of teachers per each campus (campus name, "Number of teachers"). Sort the result by campus name in ascending order.

SELECT campus_name, COUNT(teacher_number) as "Number of teachers"
FROM Campus as c
LEFT JOIN Teacher as t ON C.campus_code = T.campus_code
GROUP BY campus_name
ORDER BY campus_name

--6. Time dimension considerations: List all the teachers (surname, first name, teacher number, start date, end date) who have been working as academic advisors in 2010 (at least for one day). Sort the result by (surname, first name, teacher number) in ascending order.

select surname, first_name, aa.teacher_number, start_date, end_date
from teacher as t
join AcademicAdvisor as aa on t.teacher_number = aa.teacher_number
where year(start_date) = 2010 and datediff(day,start_date,end_date) > 1
order by surname, first_name, aa.teacher_number

--7. List all the teachers (surname, first name, teacher number, course name). If the teacher is in charge of a course, display also the name of the course; otherwise leave the course name column totally empty. Sort the result by (surname, first name, teacher number) in ascending order

select distinct surname, first_name, t.teacher_number, concat(c.course_name, ' ')
from teacher as t
left join CourseInstance as ci on t.teacher_number = ci.teacher_number
left join course as c on c.person_in_charge = t.teacher_number 
order by surname, first_name, teacher_number


--8. List all the teachers (surname, first name, teacher number, "Comment") without any duplicate entries. If the teacher is also an academic advisor, show the text 'academic advisor' in the "Comment" column, otherwise leave the column totally empty. Sort the result by (surname, first name, teacher number) in ascending order

select distinct surname, first_name, t.teacher_number, 
	(case when aa.teacher_number is null then ' ' else 'Academic advisor' end) as Comment
from teacher as t
left join AcademicAdvisor as aa on aa.teacher_number = t.teacher_number
order by surname, first_name, t.teacher_number
