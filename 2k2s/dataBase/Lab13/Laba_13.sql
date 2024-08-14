--1. Разработайте локальную процедуру GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE).
--Процедура должна выводить список преподавателей из таблицы TEACHER (в стандартный серверный вывод),
--работающих на кафедре заданной кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE) 
IS
  CURSOR PTEACHERS IS SELECT * FROM TEACHER WHERE PULPIT = PCODE;
  PTEACHER PTEACHERS%ROWTYPE;
BEGIN
  OPEN PTEACHERS;
  LOOP
    FETCH PTEACHERS INTO PTEACHER;
    EXIT WHEN PTEACHERS%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(PTEACHER.TEACHER_NAME||' '||PTEACHER.PULPIT);
  END LOOP;
  
  CLOSE PTEACHERS;
END;

BEGIN
  GET_TEACHERS('TL');
END;

-- Создание процедуры GET_TEACHERS2

  CREATE OR REPLACE PROCEDURE GET_TEACHERS2 (PCODE TEACHER.PULPIT%TYPE) IS
  BEGIN
    FOR teacher_rec IN (
      SELECT teacher_name, birthday, salary
      FROM teacher
      WHERE pulpit = PCODE
    ) LOOP
      DBMS_OUTPUT.PUT_LINE('Teacher Name: ' || teacher_rec.teacher_name || 
                           ', Birthday: ' || TO_CHAR(teacher_rec.birthday, 'DD-MM-YYYY') || 
                           ', Salary: ' || teacher_rec.salary);
    END LOOP;
  END GET_TEACHERS2;

BEGIN
  -- Включаем вывод на сервере
  DBMS_OUTPUT.PUT_LINE('Executing GET_TEACHERS2 procedure:');
  -- Вызов процедуры GET_TEACHERS2 с параметром 'PCODE'
  GET_TEACHERS2('ISiT'); 

END;

select * from pulpit;

--2. Разработайте локальную функцию GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) RETURN NUMBER.
--Функция должна выводить количество преподавателей из таблицы TEACHER,
--работающих на кафедре заданной кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
CREATE OR REPLACE FUNCTION GET_NUM_TEACHERS(PCODE TEACHER.PULPIT%TYPE) RETURN NUMBER
IS
COUNT_TEACHERS NUMBER;
BEGIN
  select count(*) into count_teachers from teacher where pulpit = pcode;
  return count_teachers;
END;

begin
  dbms_output.put_line('count of teachers '||get_num_teachers('TL'));
end;


-------------------- Task 3 --------------------
--GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--Процедура должна выводить список преподавателей из таблицы TEACHER (в стандартный серверный вывод),
--работающих на факультете, заданным кодом в параметре. 

create or replace procedure GET_TEACHERS_BY_FACULTY (FCODE FACULTY.FACULTY%TYPE)
is
  cursor fteachers is select teacher.teacher_name, teacher.pulpit from teacher
  inner join pulpit on pulpit.pulpit = teacher.pulpit 
  where pulpit.faculty = fcode;
 
  fteacher fteachers%rowtype;
begin
  open fteachers;
  loop
    fetch fteachers into fteacher;
    exit when fteachers%notfound;
    dbms_output.put_line(fteacher.teacher_name||' '||fteacher.pulpit);
  end loop;
  close fteachers;
end;

begin
  get_teachers_by_faculty('IDiP');
end;  


--GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--Процедура должна выводить список преподавателей из таблицы TEACHER (в стандартный серверный вывод),
--работающих на факультете, заданным кодом в параметре. 

create or replace procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
is
  cursor sub is select * from subject where pulpit = pcode;
  psubject sub%rowtype;
begin 
  open sub;
  loop
    fetch sub into psubject;
    exit when sub%notfound;
    dbms_output.put_line(psubject.subject_name||' '||psubject.pulpit);
  end loop;
  close sub;
end;

begin
  get_subjects('TL');
end;



-------------------- Task 4 --------------------
--GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--RETURN NUMBER
--Функция должна выводить количество преподавателей из таблицы TEACHER, работающих на факультете,
--заданным кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.

create or replace function GET_NUM_TEACHERS_BY_FAC (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER
is
  count_teachers number;
begin
  select count(*) into count_teachers from teacher
  inner join pulpit on teacher.pulpit = pulpit.pulpit 
  where pulpit.faculty = fcode;
  return count_teachers;
end;

begin
  dbms_output.put_line('count of teachers '||GET_NUM_TEACHERS_BY_FAC('IDiP'));
end; 



/*GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER Функция должна выводить
количество дисциплин из таблицы SUBJECT, закрепленных за кафедрой, заданной кодом 
кафедры параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры. */

CREATE OR REPLACE FUNCTION GET_NUM_SUBJECT(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER 
IS 
COUNT_SUBJECT NUMBER;
   BEGIN
   SELECT COUNT(*) INTO COUNT_SUBJECT  FROM SUBJECT 
   WHERE SUBJECT.PULPIT = PCODE;
   RETURN COUNT_SUBJECT;
END;
   
 begin
  dbms_output.put_line('count of subjects '||GET_NUM_SUBJECT('ISiT'));
end; 

SELECT COUNT(*) FROM SUBJECT
WHERE PULPIT = 'ISiT';
--5. Разработайте пакет TEACHERS, содержащий процедуры и функции:
create or replace package TEACHERS as
  PROCEDURE GET_TEACHERS_BY_FACULTY(FCODE FACULTY.FACULTY%TYPE);
  PROCEDURE GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE);
  FUNCTION GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER;
  FUNCTION GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER;
end TEACHERS;

create or replace package body TEACHERS as

    function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) return number is tcount_number number;
    begin 
        select count(*)into tcount_number from teacher join pulpit on teacher.pulpit = pulpit.pulpit where pulpit.faculty = FCODE;
        return tcount_number;
    end GET_NUM_TEACHERS;
  
    function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) return number is s_number number;
    begin 
        select count(*) into s_number from subject where subject.pulpit = PCODE;
        return s_number;
    end GET_NUM_SUBJECTS;
          
    procedure GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) is 
    cursor subject_cursor is select subject, pulpit from subject where pulpit = PCODE;
    c_subject subject.subject%type;
    c_pulpit subject.pulpit%type;
    begin 
        open subject_cursor;
        fetch subject_cursor into c_subject, c_pulpit;
        loop
            dbms_output.put_line(' ' || c_subject || ' ---> ' || c_pulpit);
            fetch subject_cursor into c_subject, c_pulpit;
            exit when subject_cursor%notfound;
        end loop;
        close subject_cursor;
    end GET_SUBJECTS;

    procedure GET_TEACHERS_BY_FACULTY (FCODE FACULTY.FACULTY%TYPE) 
    is cursor teacher_cursor 
        is select teacher.teacher_name, pulpit.faculty from teacher inner join pulpit on teacher.pulpit = pulpit.pulpit where pulpit.faculty = FCODE;

    teach_curs teacher.teacher_name%type;
    facult_cursor pulpit.faculty%type;
begin 
    open teacher_cursor;
    fetch teacher_cursor into teach_curs, facult_cursor;
    
    loop 
        dbms_output.put_line(' ' || teach_curs || ' ---> ' || facult_cursor);
        fetch teacher_cursor into teach_curs, facult_cursor;
        exit when teacher_cursor%notfound;
    end loop;
    close teacher_cursor;    
end GET_TEACHERS_BY_FACULTY;

END TEACHERS;
--6. Разработайте анонимный блок и продемонстрируйте выполнение процедур и функций пакета TEACHERS.
SET SERVEROUTPUT ON;
select * from pulpit;

DECLARE
  -- Переменные для хранения результатов функций
  num_teachers NUMBER;
  num_subjects NUMBER;
BEGIN
  -- Вызов процедуры GET_TEACHERS_BY_FACULTY
  DBMS_OUTPUT.PUT_LINE('Teachers by Faculty:');
  TEACHERS.GET_TEACHERS_BY_FACULTY('TOV');

  -- Вызов процедуры GET_SUBJECTS
  DBMS_OUTPUT.PUT_LINE('Subjects by Pulpit:');
  TEACHERS.GET_SUBJECTS('ISiT '); 

  -- Вызов функции GET_NUM_TEACHERS и вывод результата
  num_teachers := TEACHERS.GET_NUM_TEACHERS('HTiT'); 
  DBMS_OUTPUT.PUT_LINE('Number of Teachers in Faculty HTiT: ' || num_teachers);

  -- Вызов функции GET_NUM_SUBJECTS и вывод результата
  num_subjects := TEACHERS.GET_NUM_SUBJECTS('LMiLZ'); 
  DBMS_OUTPUT.PUT_LINE('Number of Subjects in Pulpit LMiLZ: ' || num_subjects);
END;