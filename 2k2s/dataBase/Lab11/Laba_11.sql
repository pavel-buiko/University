----------1. ������������ ��, ��������������� ������ ��������� SELECT � ������ ��������. ------------
declare 
  faculty_rec faculty%rowtype;
begin 
  select * into faculty_rec from faculty where faculty = 'TOV';
  dbms_output.put_line(faculty_rec.faculty ||' '||faculty_rec.faculty_name);
end;

--2. ������������ ��, ��������������� ������ ��������� SELECT � �������� ������ ��������.
--����������� ����������� WHEN OTHERS ������ ���������� � ���������� ������� SQLERRM, SQLCODE ��� ���������������� �������� �������. ---
declare 
faculty_result faculty%rowtype;
begin
select * into faculty_result from faculty;
dbms_output.put_line(faculty_result.faculty || ' ' || faculty_result.faculty_name);
exception
when others 
then dbms_output.put_line('caught: ' || sqlcode|| ' '||sqlerrm);

end;

--3. ������������ ��, ��������������� ������ ����������� WHEN TO_MANY_ROWS ������ ���������� ���
--���������������� �������� �������.
declare
    faculty_rec faculty%rowtype;
begin
    select * into faculty_rec from faculty;
    dbms_output.put_line(faculty_rec.faculty || '  ' || faculty_rec.faculty_name);
exception
    when too_many_rows
    then dbms_output.put_line('caught: ' || sqlcode || ' ' || sqlerrm );
end;



--4. ������������ ��, ��������������� ������������� � ��������� ���������� NO_DATA_FOUND.
--������������ ��, ��������������� ���������� ��������� �������� �������.
DECLARE
    faculty_rec faculty%rowtype;
    v_rowcount  INTEGER;
BEGIN
    SELECT *
    INTO faculty_rec
    FROM faculty
    WHERE faculty = 'EEE';

    v_rowcount := SQL%ROWCOUNT;  -- �������� ���������� ������������ �����

    IF SQL%FOUND THEN
        -- ������� ���������� � ����������, ���� ������� ������ �������
        dbms_output.put_line(faculty_rec.faculty || '  ' || faculty_rec.faculty_name);
        dbms_output.put_line('Rows affected: ' || v_rowcount);  -- ������� ���������� �����
    ELSE
        -- ���� �� ������� �� ����� ������, ������� ���������
        dbms_output.put_line('No data found for faculty EEE.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Rows affected: ' || v_rowcount);
        dbms_output.put_line('Caught: ' || SQLCODE || ' ' || SQLERRM);
END;





--5. ������������ ��, ��������������� ���������� ���������� INSERT, UPDATE, DELETE,
--���������� ��������� ����������� � ���� ������. ����������� ����������.
SELECT * FROM Faculty;

BEGIN
  INSERT INTO faculty (faculty, faculty_name)
  VALUES ('IDiP', 'Duplicate faculty');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Duplicate value');
END;

BEGIN
  DELETE FROM faculty WHERE faculty = 'LHF';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' ' || SQLERRM);
END;

BEGIN
  UPDATE faculty
  SET faculty = 'LHS'
  WHERE faculty_name = 'New Faculty Name';

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' ' || SQLERRM);
END;

--6. �������� ��������� ����, ��������������� ������� TEACHER � ����������� ������ ������� LOOP-�����.
--��������� ������ ������ ���� �������� � ����������, ����������� � ����������� ����� %TYPE

declare 
cursor cur is SELECT * from teacher;
c_teacher  teacher.teacher%type;
c_teacher_name teacher.teacher_name%type;
c_pulpit teacher.pulpit%type;
begin

open cur;
loop
fetch cur into c_teacher,c_teacher_name,c_pulpit;
exit when cur%notfound;
dbms_output.put_line(cur%rowcount ||' '|| c_teacher || ' ' || c_teacher_name || ' ' || c_pulpit );
end loop;
close cur;
end;

--7. �������� ��, ��������������� ������� SUBJECT � ����������� ������ ������� �WHILE-�����.
--��������� ������ ������ ���� �������� � ������ (RECORD), ����������� � ����������� ����� %ROWTYPE.

declare 
    cursor curs_subject is select * from subject;
    rec_subject subject%rowtype; --��������� ������ ������ ���� �������� � ������ (RECORD), ����������� � ����������� ����� %ROWTYPE.
begin
    open curs_subject;
    dbms_output.put_line('rowcount = ' || curs_subject%rowcount);
    fetch curs_subject into rec_subject;
    while curs_subject%found
    loop
    dbms_output.put_line(' ' || curs_subject%rowcount || ' ' || rec_subject.subject || ' ' ||
                        rec_subject.subject_name || '   /' || rec_subject.pulpit);
    fetch curs_subject into rec_subject;
    end loop;
    dbms_output.put_line('rowcount = ' || curs_subject%rowcount);
    close curs_subject;
exception
      when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);   
end;
--8. �������� ��, ��������������� ��������� ������ ���������:
--��� ��������� (������� AUDITORIUM) � ������������ ������ 20, �� 21-30, �� 31-60, �� 61 �� 80, �� 81 � ����.
--��������� ������ � ����������� � ��� ������� ����������� ����� �� ������� �������.

declare 
    cursor curs (capacity auditorium.auditorium_capacity%type, capacity1 auditorium.auditorium_capacity%type)
        is select auditorium, auditorium_capacity, auditorium_type
        from auditorium
        where auditorium_capacity >= capacity and auditorium_capacity <= capacity1;
    --aum curs%rowtype;
begin
    dbms_output.put_line('capacity < 20 :');
    for aum in curs(0,20)
    loop dbms_output.put_line(aum.auditorium||' '); 
    end loop;
    
    dbms_output.put_line('21 < capacity < 30 :');
    for aum in curs(21,30)
    loop dbms_output.put_line(aum.auditorium||' '); 
    end loop;
     
    dbms_output.put_line('31 < capacity < 60 :');
    for aum in curs(31,60)
    loop dbms_output.put_line(aum.auditorium||' '); 
    end loop;
     
    dbms_output.put_line('61 < capacity < 80 :');
    for aum in curs(61,80)
    loop dbms_output.put_line(aum.auditorium||' '); 
    end loop;
     
    dbms_output.put_line('81 < capacity:');
    for aum in curs(81,1000)
    loop dbms_output.put_line(aum.auditorium||' '); 
    end loop;
exception
      when others
        then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

--9. �������� A�. �������� ��������� ���������� � ������� ���������� ���� refcursor.
--����������������� �� ���������� ��� ������� c �����������. 


DECLARE
    -- ��������� ���������� ��� ������� ���� REFCURSOR
    cur_refcursor SYS_REFCURSOR;
    -- ��������� ���������� ��� �������� ������, ������� ����� ����������� �� �������
    d_faculty faculty.faculty%TYPE;
    d_faculty_name faculty.faculty_name%TYPE;

BEGIN
    -- ��������� ������ � �����������
    OPEN cur_refcursor FOR
        SELECT faculty, faculty_name
        FROM faculty
        WHERE faculty = 'HTiT';

    -- ��������� ������ �� ������� � ����������
    LOOP
        FETCH cur_refcursor INTO d_faculty, d_faculty_name;
        EXIT WHEN cur_refcursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Faculty: ' || d_faculty || ', Faculty Name: ' || d_faculty_name);
    END LOOP;

    -- ��������� ������
    CLOSE cur_refcursor;

END;


--10. �������� A�. ��������� ����������� ���� ��������� (������� AUDITORIUM) ������������ �� 40 �� 80 �� 10%.
--����������� ����� ������ � �����������, ���� FOR, ����������� UPDATE CURRENT OF. 

DECLARE
    CURSOR cur_auditoriums (min_capacity NUMBER, max_capacity NUMBER) IS
        SELECT auditorium, auditorium_capacity
        FROM auditorium
        WHERE auditorium_capacity >= min_capacity
          AND auditorium_capacity <= max_capacity
        FOR UPDATE OF auditorium_capacity;  -- ��� ���������� ������� ������ � �������
    v_new_capacity NUMBER;
BEGIN
    -- ��������� ������ ��� ��������� � ������������ �� 40 �� 80 �������
    OPEN cur_auditoriums(40, 80);
    -- ���� ��������� ������� �� �������
    FOR aud_rec IN cur_auditoriums LOOP
        -- ��������� ����� ����������� (��������� �� 10%)
        v_new_capacity := aud_rec.auditorium_capacity * 0.9;
        -- ��������� ������� ������ � �������
        UPDATE auditorium
        SET auditorium_capacity = v_new_capacity
        WHERE CURRENT OF cur_auditoriums;
        -- ������� ���������� � ����������� ����������
        DBMS_OUTPUT.PUT_LINE('Updated auditorium ' || aud_rec.auditorium ||
                             ': Old capacity = ' || aud_rec.auditorium_capacity ||
                             ', New capacity = ' || v_new_capacity);
    END LOOP;
    -- ��������� ������
    CLOSE cur_auditoriums;
    -- ��������� ��������� � ���� ������
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- ��������� ����������
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' ' || SQLERRM);
        ROLLBACK; -- ����� ���������, ���� ��������� ������
END;
