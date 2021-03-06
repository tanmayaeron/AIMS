CREATE TABLE courses(
    course_id char(5) NOT NULL PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    L float8 NOT NULL,
    T float8 NOT NULL,
    P float8 NOT NULL,
    S float8 NOT NULL,
    C float8 NOT NULL
);

GRANT ALL
ON courses
TO deanoffice;

GRANT SELECT 
ON courses
TO faculty, student;

CREATE TABLE prereq(
    course_id char(5) NOT NULL,
    prereq_Id char(5) NOT NULL,
    PRIMARY KEY(course_id,prereq_Id),
    FOREIGN KEY(course_id) REFERENCES courses(course_id),
    FOREIGN KEY(prereq_Id) REFERENCES courses(course_id)
);

GRANT ALL
ON prereq
TO deanoffice;

GRANT SELECT 
ON prereq
TO faculty, student;

CREATE TABLE students(
    id char(11) NOT NULL,
    name varchar(40) NOT NULL,
    dept char(3) NOT NULL,
    batch INTEGER NOT NULL,
    PRIMARY KEY(id)
);

GRANT SELECT 
ON students
TO deanoffice,faculty,student;

CREATE TABLE instructor(
    id INTEGER NOT NULL,
    name varchar(40) NOT NULL,
    dept varchar(4) NOT NULL,
    PRIMARY KEY(id)
);

GRANT ALL 
ON instructor
TO deanoffice;

GRANT SELECT
ON instructor
TO student, faculty;

CREATE TABLE timeslots(
    slot_type char(6) NOT NULL,
    PRIMARY KEY(slot_type)
);

GRANT SELECT
ON timeslots
TO faculty,student,deanoffice;




CREATE TABLE batches(
    batch char(7) NOT NULL,
    adv_id INTEGER,
    PRIMARY KEY(batch),
    FOREIGN KEY(adv_id) REFERENCES instructor(id)
);

GRANT ALL
ON batches
TO deanoffice;

GRANT SELECT
ON batches
TO faculty, student; 

CREATE TABLE course_offering(
    id INTEGER,
    course_id char(5) NOT NULL,
    year INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    insid INTEGER NOT NULL,
    slot char(6) NOT NULL,
    classroom varchar(5),
    CGPA float8,
    PRIMARY KEY(id),
    FOREIGN KEY(course_id) REFERENCES courses(course_id),
    FOREIGN KEY(insid) REFERENCES instructor(id),
    FOREIGN KEY(slot) REFERENCES timeslots(slot_type)
);

GRANT ALL 
ON course_offering
TO deanoffice,faculty;

GRANT SELECT
ON course_offering
TO student;

CREATE TABLE enrol(
    student_id char(11) NOT NULL,
    offering_id INTEGER NOT NULL,
    PRIMARY KEY (student_id, offering_id),
    FOREIGN KEY(student_id) REFERENCES students(id),
    FOREIGN KEY(offering_id) REFERENCES course_offering(id)
);

GRANT ALL
ON enrol
TO deanoffice;

GRANT SELECT
ON enrol
TO faculty,student;

CREATE TABLE batch_constraint(
    id INTEGER NOT NULL,
    batch char(7) NOT NULL,
    PRIMARY KEY (batch, id)
);

GRANT ALL ON
batch_constraint
TO deanoffice,faculty;

GRANT SELECT ON
batch_constraint
TO student;

