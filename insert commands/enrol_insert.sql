--CS201
SELECT request_enrolment(3, '2019csb0003', 1, 2019);
SELECT request_enrolment(3, '2019csb0004', 1, 2019);
SELECT request_enrolment(3, '2019csb0002', 1, 2019); --garde 0
SELECT request_enrolment(3, '2019csb0001', 1, 2019);
SELECT request_enrolment(3, '2019csb0005', 1, 2019);

--CS202
-- 2019csb0005 has not enrolled in offering 4(cs202)
SELECT request_enrolment(4, '2019csb0003', 1, 2019);
SELECT request_enrolment(4, '2019csb0004', 1, 2019);
SELECT request_enrolment(4, '2019csb0002', 1, 2019); --grade 10
SELECT request_enrolment(4, '2019csb0001', 1, 2019);

SELECT request_enrolment(4, '2019eeb0006', 1, 2019);
--EE201
SELECT request_enrolment(0, '2019eeb0006', 1, 2019);

--HS103


--EE202
SELECT request_enrolment(6, '2019eeb0006', 1, 2019); --grade 10
SELECT request_enrolment(18, '2019eeb0006', 1, 2019); --grade 10

--GE104
SELECT request_enrolment(8, '2019eeb0006', 1, 2019); --grade 10

-- HS101

-- credit limit for student 2019eeb0006 would exceed 
-- hence he wont be able to register
--SELECT request_enrolment(15, '2019eeb0006', 1, 2019);

--cs203
SELECT request_enrolment(10, '2019csb0005',2, 2019); --grade 10
SELECT request_enrolment(10, '2019csb0002', 2, 2019); --grade 10

--cs301
SELECT request_enrolment(5, '2019csb0005', 1, 2020);

--2019CSB0005 WILL HAVE VERY LESS CREDITS AFTER END OF TWO SEMESTERS (4+4=8 CREDITS), HENCE BY 1.25 RULE, CREDIT LIMIT = 5
--Enrolled in CS301, should not be able to enroll in PH101
--TICKET TO BE RAISED FOR THIS STUDENT
--SELECT request_enrolment(20, '2019csb0005', 1, 2020);

--2019EEB0006 WILL ENROLL IN ALL POSSIBLE COURSES IN SEMESTER 1, 2019, EXCEPT HS101 (CREDITS = 17)
--WHEN HE/SHE TRIES TO ENROLL IN HS101, CREDIT LIMIT EXCEEDS AND HE/SHE CANT ENROLL
--SELECT request_enrolment(14, '2019eeb0006', 1, 2019);

--2019CSB0002 FAILED IN CS201, SHOULD NOT BE ABLE TO ENROLL IN CS301
--SELECT request_enrolment(5, '2019csb0002', 1, 2020);

-- A student cannot enrol cs201 and ee201 offering (3, 0) at once
-- example
--SELECT request_enrolment(0, '2019csb0003', 1, 2019);

-- In semester 1, A 2019csb student cannot register for hs101
-- branch constraint
--example
--SELECT request_enrolment(14, '2019csb0003', 1, 2019);

--2019CSB0001 can't graduate due to low CGPA
--2019eeb0006 can graduate
--2019csb0005 can't graduate due to low credits

--2019CSB0001 can't enrol in CS302 due to low CGPA
 


--GE204 FOR CSV
-- Path :- 'D:\IITRopar\Sem 5\CS301 DBMS\AIMS\insert commands\grade_ge204.csv'
-- CALL add_grades(9, 'D:\IITRopar\Sem 5\CS301 DBMS\AIMS\insert commands\grade_ge204.csv');


--SELECT request_enrolment(9, '2019eeb0006', 2, 2019);
--SELECT request_enrolment(9, '2019eeb0007', 2, 2019);
--SELECT request_enrolment(9, '2019eeb0008', 2, 2019);
--SELECT request_enrolment(9, '2019eeb0009', 2, 2019);
--SELECT request_enrolment(9, '2019eeb0010', 2, 2019);
--
--pc: 7
--pe: 6
--sc: 3
--oe: 4