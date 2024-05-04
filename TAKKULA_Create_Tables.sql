
CREATE TABLE Campus
(
  campus_code CHAR(4)     NOT NULL,
  campus_name VARCHAR(10) NOT NULL,
  street      VARCHAR(20),
  postcode    CHAR(5),
  city        VARCHAR(10),

  CONSTRAINT PK_Campus PRIMARY KEY (campus_code),
  CONSTRAINT AK_Campus UNIQUE (campus_name)
);

CREATE TABLE Student
(
  student_number CHAR(4)    NOT NULL,
  first_name     VARCHAR(8) NOT NULL,
  surname        VARCHAR(8) NOT NULL,
  birth_date     DATE       NOT NULL,
  gender         CHAR(1)    NOT NULL,
  email          VARCHAR(20),
  street         VARCHAR(20),
  postcode       CHAR(5),
  city           VARCHAR(10),
  
  CONSTRAINT PK_Student PRIMARY KEY (student_number),
  CONSTRAINT CHK_Student_gender CHECK(gender = 'M' OR gender = 'F')
);

CREATE TABLE Teacher
(
  teacher_number  CHAR(4)      NOT NULL,
  first_name      VARCHAR(8)   NOT NULL,
  surname         VARCHAR(8)   NOT NULL,
  birth_date      DATE         NOT NULL,
  gender          CHAR(1)      NOT NULL,
  salary          DECIMAL(8,2) NOT NULL,
  email           VARCHAR(50), 
  phone           VARCHAR(10),  
  campus_code     CHAR(4),

  CONSTRAINT PK_Teacher PRIMARY KEY (teacher_number),
  CONSTRAINT FK_Teacher_Campus FOREIGN KEY (campus_code) REFERENCES Campus(campus_code),
  CONSTRAINT CHK_Teacher_salary CHECK(salary >= 0)
);

CREATE TABLE AcademicAdvisor
(
  teacher_number CHAR(4)  NOT NULL,
  campus_code    CHAR(4)  NOT NULL,
  start_date     DATE     NOT NULL,
  end_date       DATE,
  
  CONSTRAINT PK_AcademicAdvisor PRIMARY KEY (teacher_number, campus_code, start_date),
  CONSTRAINT FK_AcademicAdvisor_Teacher FOREIGN KEY (teacher_number) REFERENCES Teacher(teacher_number), 
  CONSTRAINT FK_AcademicAdvisor_Campus FOREIGN KEY (campus_code) REFERENCES Campus(campus_code),
  CONSTRAINT CHK_AcademicAdvisor_end_date CHECK(end_date IS NULL OR end_date >= start_date)
);

CREATE TABLE Course
(
  course_code      CHAR(4)     NOT NULL,
  course_name      VARCHAR(20) NOT NULL,
  credits          SMALLINT    NOT NULL,
  person_in_charge CHAR(4)     NOT NULL,
  
  CONSTRAINT PK_Course PRIMARY KEY (course_code),
  CONSTRAINT AK_Course UNIQUE (course_name),  
  CONSTRAINT FK_Course_Teacher FOREIGN KEY (person_in_charge) 
      REFERENCES Teacher(teacher_number),
  CONSTRAINT CHK_Course_credits CHECK(credits >= 0)
);

CREATE TABLE Prerequisite
(
  course_code       CHAR(4) NOT NULL,
  prerequisite_code CHAR(4) NOT NULL,

  CONSTRAINT PK_Prerequisite PRIMARY KEY (course_code, prerequisite_code),
  CONSTRAINT FK_Prerequisite_Course FOREIGN KEY (course_code) 
      REFERENCES Course(course_code),
  CONSTRAINT FK_Prerequisite_Course_prior FOREIGN KEY (prerequisite_code) 
      REFERENCES Course(course_code),
  CONSTRAINT CHK_Prerequisite_code CHECK(course_code <> prerequisite_code)    
);

CREATE TABLE CourseInstance
(
  course_code     CHAR(4) NOT NULL,
  instance_number SMALLINT NOT NULL,
  start_date      DATE,
  end_date        DATE, 
  participants    SMALLINT,  
  teacher_number  CHAR(4),

  CONSTRAINT PK_CourseInstance PRIMARY KEY (course_code, instance_number),
  CONSTRAINT FK_CourseInstance_Course FOREIGN KEY (course_code) 
      REFERENCES Course(course_code),
  CONSTRAINT FK_CourseInstance_Teacher FOREIGN KEY (teacher_number) 
      REFERENCES Teacher(teacher_number),
  CONSTRAINT CHK_CourseInstance_end_date CHECK(end_date IS NULL OR end_date >= start_date),
  CONSTRAINT CHK_CourseInstance_participants CHECK(participants IS NULL OR participants >= 0)
);

CREATE TABLE CourseGrade
(
  student_number  CHAR(4)  NOT NULL,
  course_code     CHAR(4)  NOT NULL,
  instance_number SMALLINT NOT NULL,
  grade           SMALLINT,
  grade_date      DATE,
  examiner        CHAR(4),
  
  CONSTRAINT PK_CourseGrade PRIMARY KEY (student_number, course_code, instance_number),
  CONSTRAINT FK_CourseGrade_Student FOREIGN KEY (student_number) 
      REFERENCES Student(student_number),
  CONSTRAINT FK_CourseGrade_CourseInstance  FOREIGN KEY (course_code, instance_number) 
      REFERENCES CourseInstance(course_code, instance_number),
  CONSTRAINT FK_CourseGrade_Teacher FOREIGN KEY (examiner) 
      REFERENCES Teacher(teacher_number),
  CONSTRAINT CHK_CourseGrade_grade CHECK((grade BETWEEN 0 AND 5) OR grade IS NULL) 
);

CREATE TABLE MisconductType
(
  misconduct_code CHAR(4)      NOT NULL,
  description     VARCHAR(120) NOT NULL,

  CONSTRAINT PK_Misconduct PRIMARY KEY (misconduct_code)
);

CREATE TABLE SanctionType
(
  sanction_code   CHAR(4)      NOT NULL,
  description     VARCHAR(20)  NOT NULL,
  decision_maker  VARCHAR(30)  NOT NULL,

  CONSTRAINT PK_MisconductSanction PRIMARY KEY (sanction_code)
);

CREATE TABLE MisconductIncident
(
  student_number  CHAR(4) NOT NULL,
  misconduct_code CHAR(4) NOT NULL,
  course_code     CHAR(4) NOT NULL,
  instance_number SMALLINT NOT NULL,
  sanction_code   CHAR(4) NOT NULL,
  decision_date   DATE    NOT NULL, 

  CONSTRAINT PK_MisconductIncident 
      PRIMARY KEY (student_number, misconduct_code, course_code, instance_number),
  CONSTRAINT FK_MisconductIncident_Student FOREIGN KEY (student_number) 
      REFERENCES Student(student_number),
  CONSTRAINT FK_MisconductIncident_CourseInstance FOREIGN KEY (course_code, instance_number) 
      REFERENCES CourseInstance(course_code, instance_number),
  CONSTRAINT FK_MisconductIncident_MisconductType FOREIGN KEY (misconduct_code) 
      REFERENCES MisconductType(misconduct_code),
  CONSTRAINT FK_MisconductIncident_SanctionType FOREIGN KEY (sanction_code) 
      REFERENCES SanctionType(sanction_code)    
);




