--FUNCTIONS MUST BE CREATED BY deanoffice
--Every faculty should be able to calculate student's cgpa
--SO, FACULTY MUST BE GIVEN SELECT ON STUDENT TRANSCRIPTS

CREATE OR REPLACE FUNCTION grade_to_points
(
    grade varchar(2)
)
RETURNS integer
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
declare
    points integer;
begin
    if grade='A' THEN
        points := 10;
    end if;
    if grade='A-' THEN
        points := 9;
    end if;
    if grade='B' THEN
        points := 8;
    end if;
    if grade='B-' THEN
        points := 7;
    end if;
    if grade='C' THEN
        points := 6;
    end if;
    if grade='C-' THEN
        points := 5;
    end if;
    if grade='D' THEN
        points := 4;
    end if;
    if grade='F' THEN
        points := 0;
    end if;

    return points;
end;
$$;


CREATE OR REPLACE FUNCTION cgpa_calculation
(
    student_id char(11)
)
RETURNS numeric(4, 2)
LANGUAGE plpgsql
SECURITY INVOKER
AS $$
declare
    cgpa numeric(4, 2) := 00.00;
    grade_points float8 := 0;
    transcript_table_name text;
    cur REFCURSOR;
    rec record;
    course_credits float8;
    total_credits float8 := 0;
    get_credits_command text;
    points float8; 
begin

    grade_points :=0;
    transcript_table_name := 'transcript_' || student_id;

    --for all courses in the student's transcript
    open cur FOR EXECUTE 'SELECT * FROM ' || transcript_table_name||' where grade!=''F''';
    LOOP
        FETCH cur INTO rec;
        EXIT when not found;

        --get course credits from courses table
        get_credits_command := 'SELECT courses.C FROM courses, course_offering O WHERE O.id = ' || rec.off_id || ' and O.course_id = courses.course_id;';
        EXECUTE get_credits_command INTO course_credits;

        --update grade points and total credits
        points := grade_to_points(rec.grade);
        grade_points := grade_points + (course_credits * points);
        total_credits := total_credits + course_credits;
    end LOOP;

    if total_credits=0 then
        return 0;
    end if;

    --calculate cgpa
    cgpa := CAST(grade_points AS decimal) / total_credits;
    return cgpa;
end;
$$;