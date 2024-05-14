--1. List teachers' and students' surnames. Show the result as a single list.
SELECT surname
FROM Teacher
UNION
SELECT surname
FROM Student;

--2. List such cities where there is a campus and at least one student is living in the city.
SELECT DISTINCT c.city
FROM Campus c
INNER JOIN Student s ON c.city = s.city

--3. List such cities where there is a campus and no student is living in the city.
SELECT DISTINCT c.city
FROM Campus c
LEFT JOIN Student s ON c.city = s.city
WHERE s.city IS NULL

--4. List such years when at least one teacher was born OR at least one student was born. Display the result in descending order.

SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM Teacher
UNION
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM Student
ORDER BY birth_year DESC;

--5. List such years when at least one teacher was born AND at least one student was born.
SELECT YEAR(birth_date) AS birth_year
FROM Teacher
INTERSECT
SELECT YEAR(birth_date) AS birth_year
FROM Student

--6. List such years when at least one teacher was born AND no student was born.
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM Teacher
EXCEPT
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM Student

--7. List such years when at least one student was born AND no teacher was born. Display the result in descending order.
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM Student
EXCEPT
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM Teacher
ORDER BY birth_year DESC;
