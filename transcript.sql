-- TWO FUNCTIONS :-
-- MUST BE CREATED BY DEANOFFICE ONLY
-- 1. TRANSCRIPT GENERATION FOR A SINGLE STUDENT (To be implemented)
-- 2. TRANSCRIPT GENERATION FOR ALL STUDENTS

--Two implementation :- using enrol table, or going offering wise (better optimisation on latter)

--GRADE TABLE NAME TO BE ADDED

CREATE OR REPLACE PROCEDURE transcript_generation
(
    sem integer,
    ye integer
)
LANGUAGE plpgsql
AS $$
declare
    --cursor for offerings in the given semester and year
    offering_cursor CURSOR FOR (SELECT * FROM course_offering O WHERE O.semester = sem and O.year = ye);
    grade_table_cursor REFCURSOR;
    offering_table_row record;
    grade_table_name text;
    grade_table_row record;
    transcript_table_name text;
    transcript_entry_command text;
    temp_command text;
    
begin
    open offering_cursor;
    LOOP
        FETCH offering_cursor INTO offering_table_row;
        EXIT when not found;

        --GRADE TABLE NAME TO BE ADDED
        grade_table_name = '_'||offering_table_row.id||'_grades';

        --open grade table cursor
        temp_command := 'SELECT student_id, grade FROM ' || grade_table_name || ';';
        open grade_table_cursor FOR EXECUTE temp_command;
        LOOP
            FETCH grade_table_cursor INTO grade_table_row;
            EXIT when not found;

            --make entry in transcript
            transcript_table_name := 'transcript_' || grade_table_row.student_id;
            transcript_entry_command := 'INSERT INTO ' || transcript_table_name;
            transcript_entry_command := transcript_entry_command || ' VALUES (';
            transcript_entry_command := transcript_entry_command || offering_table_row.id || ', ''';
            transcript_entry_command := transcript_entry_command || grade_table_row.grade || ''');';
            EXECUTE transcript_entry_command;
        end LOOP;
        close grade_table_cursor;
    end LOOP;
end;
$$;

GRANT EXECUTE
ON PROCEDURE transcript_generation
TO deanoffice;
