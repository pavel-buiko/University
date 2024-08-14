--1. �������� � ������� TEACHERS ��� ������� BIRTHDAY � SALARY, ��������� �� ����������.

select * from teacher;
alter table teacher add (birthday date, salary int);

update teacher set birthday = to_date('31.05.1966', 'DD.MM.YYYY'),
                    salary = 10
                    where pulpit like 'P%';

update teacher set birthday = to_date('10.10.1970', 'DD.MM.YYYY'),
                    salary = 100000
                    where pulpit like 'IS%';

update teacher set birthday = to_date('28.06.1965', 'DD.MM.YYYY'),
                    salary = 1
                    where pulpit like 'O%';
                    
update teacher set birthday = to_date('15.06.1995', 'DD.MM.YYYY'),
                    salary = 13
                    where pulpit like 'T%';

update teacher set birthday = to_date('15.06.1995', 'DD.MM.YYYY'),
                    salary = 17
                    where salary is null and birthday is null;
commit;



--2. �������� ������ �������������� � ���� ������� �.�. ��� ��������������, ���������� � �����������.
SELECT 
    TRIM(TO_CHAR(SUBSTR(TEACHER_NAME, 1, INSTR(TEACHER_NAME, ' ') - 1))) || ' ' ||
    SUBSTR(TEACHER_NAME, INSTR(TEACHER_NAME, ' ') + 1, 1) || '.' ||
    SUBSTR(SUBSTR(TEACHER_NAME, INSTR(TEACHER_NAME, ' ') + 2), 1, 1) || '.' as ���
FROM 
    TEACHER
WHERE 
    TO_CHAR(birthday, 'D') = '1'; -- ����������� (1)

SELECT * FROM teacher
WHERE TEACHER_NAME LIKE 'Prokopchuk%';
--3. �������� �������������, � ������� ��������� ������ ��������������,
--������� �������� � ��������� ������ � �������� �� ���� �������� � ������� �DD/MM/YYYY�.
CREATE OR REPLACE VIEW teachers_next_month_birthdays AS
SELECT 
  teacher_name, 
  TO_CHAR(birthday, 'DD/MM/YYYY') AS birthday 
FROM 
  teacher 
WHERE 
  TO_CHAR(birthday, 'MM') = TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MM');

SELECT * FROM teachers_next_month_birthdays;

--4. �������� �������������, � ������� ��������� ���������� ��������������, ������� �������� � ������ ������, �������� ������ ������� ������.

CREATE OR REPLACE VIEW teachers_birthdays_per_month AS
SELECT 
  TO_CHAR(birthday, 'Month') AS month_name, 
  COUNT(*) AS num_teachers 
FROM 
  teacher 
GROUP BY 
  TO_CHAR(birthday, 'Month');
  
  
select * from teachers_birthdays_per_month;


--5. ������� ������ � ������� ������ ��������������,
-- ������� ������ ��� ������� �������������� � ������� � ��������� ����
DECLARE
  CURSOR c_teachers_with_anniversary IS
    SELECT 
      teacher_name,
      birthday,
      EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday) AS age_next_year
    FROM
      teacher
    WHERE 
      MOD(EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday), 10) = 0; -- �������� �� ������ (������� 10)

  v_teacher_name teacher.teacher_name%TYPE;
  v_birthday teacher.birthday%TYPE;
  v_age_next_year NUMBER;

BEGIN
  OPEN c_teachers_with_anniversary;
  LOOP
    FETCH c_teachers_with_anniversary INTO v_teacher_name, v_birthday, v_age_next_year;
    EXIT WHEN c_teachers_with_anniversary%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Teacher: ' || v_teacher_name || ', Birthday: ' || v_birthday || ', Age next year: ' || v_age_next_year);
  END LOOP;
  CLOSE c_teachers_with_anniversary;
END;

--� ������� � ��������� ���� ������ � ���������, ������� ��� �����������.
DECLARE
  CURSOR c_teachers_with_30th_anniversary IS
    SELECT 
      teacher_name,
      birthday,
      EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday) AS age_next_year
    FROM 
      teacher
    WHERE 
      EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday) = 60; -- �������� �� 30-������ ������

  v_teacher_name teacher.teacher_name%TYPE;
  v_birthday teacher.birthday%TYPE;
  v_age_next_year NUMBER;

BEGIN
  OPEN c_teachers_with_30th_anniversary;
  LOOP
    FETCH c_teachers_with_30th_anniversary INTO v_teacher_name, v_birthday, v_age_next_year;
    EXIT WHEN c_teachers_with_30th_anniversary%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Teacher: ' || v_teacher_name || ', Birthday: ' || v_birthday || ', Age next year: ' || v_age_next_year);
  END LOOP;
  CLOSE c_teachers_with_30th_anniversary;
END;



--6. ������� ������ � ������� ������� ���������� ����� �� �������� � ����������� ���� �� �����, ������� ������� �������� �������� ��� ������� ���������� � ��� ���� ����������� � �����.
declare
    cursor c_pulp is select pulpit, faculty from pulpit;
    -- ���������� ������ `c_pulp` ��� ������� ���� ������ � ����������� �� ������� `pulpit`.
    
    cursor c_fac is select faculty from faculty;
    -- ���������� ������ `c_fac` ��� ������� ���� ����������� �� ������� `faculty`.
    
    avgsal number(6);
    -- ��������� ���������� `avgsal` ���� number(6) ��� �������� �������� �������� ��������.
    
begin
    dbms_output.put_line('--------------------pulpits----------------:');
    -- ������� ������-��������� ��� ������� ������.
    
    for r_pulp in c_pulp
    loop
        -- ��� ������ ������ (������� � ���������) � ������� `c_pulp` ����������� ��������� ���:
        select floor(avg(salary)) into avgsal from teacher where pulpit = r_pulp.pulpit;
        -- ��������� ������� �������� ��� ������� ������� � ���������� � � ���������� `avgsal`.
        
        dbms_output.put_line(rpad(r_pulp.pulpit, 20) || ' ' || avgsal);
        -- ������� �������� ������� � ������� ��������, ���������� ������ � ������� `rpad`.
    end loop;
    
    dbms_output.put_line('------------------faculties:----------------');
    -- ������� ������-��������� ��� ������� �����������.
    
    for r_fac in c_fac
    loop
        -- ��� ������ ������ (���������) � ������� `c_fac` ����������� ��������� ���:
        select floor(avg(salary)) into avgsal from teacher where pulpit in (select pulpit from pulpit where faculty = r_fac.faculty);
        -- ��������� ������� �������� ��� ���� ������ �������� ���������� � ���������� � � ���������� `avgsal`.
        
        dbms_output.put_line(rpad(r_fac.faculty, 20) || ' ' || avgsal);
        -- ������� �������� ���������� � ������� ��������, ���������� ������ � ������� `rpad`.
    end loop;
    
    select floor(avg(salary)) into avgsal from teacher;
    -- ��������� ������� �������� ��� ���� ������� � ������� `teacher` � ���������� � � ���������� `avgsal`.
    
    dbms_output.put_line(rpad('all', 20) || avgsal);
    -- ������� ������ 'all' � ����� ������� ��������, ���������� ������ � ������� `rpad`.
end;

--7. ������� ������������� ���� ��� ������� ���������� ������� ���� ����������.
--�������� ��������� �������� � �������� �� 0 ����� ���������� ZERO_DIVIDE. ������������� ���������������� ������ ��� �������� �������� 0.
declare
    numerator   number := 10; -- ���������
    denominator number := 0;  -- �����������
    result      number;
begin
    if denominator = 0 then
        raise_application_error(-20001, '������: ������� �� 0 ����������.'); --user exception
    else
        result := numerator / denominator;
        dbms_output.put_line('��������� �������: ' || result);
    end if;
exception
    when ZERO_DIVIDE then
        dbms_output.put_line('����������: ������� �� 0.');
end;


--8. ������� ������������� ���� � �������� SELECT�INTO ��� ������ ������������ ������������� �� ��������� ����.
--�������� ��������� ���������� NO_DATA_FOUND � ������� ���������� '������������� �� ������!'. ���������, ��� ���������� ��� ��������������� ����������.
DECLARE
  v_teacher_name VARCHAR2(100);
  v_teacher CHAR(10) := 'XUZ';
  v_teacher NUMBER := 111; 
BEGIN
  SELECT teacher_name INTO v_teacher_name FROM teacher WHERE teacher= v_teacher;
  
  DBMS_OUTPUT.PUT_LINE('�������������: ' || v_teacher_name);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('������������� �� ������!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('��������� ������: ' || SQLERRM);
END;

--9. ������� �������� � ��������� ����. �������� � ��� ���������� � ������� �������, ������� � ����� ������ -20 001 � ������� PRAGMA EXCEPTION_INIT.
--������������� ���������� �� ��������� �����, ���������� ��� � ��������. ��������� ��������, ����� ���������� �� ������� � ����� ������ � ����� ���������� ������������.
declare
    -- �������� ����: ���������� ���������� � ����� -20001
    main_exception exception;
    pragma exception_init(main_exception, -20001);

begin
    declare
        -- ��������� ����: ���������� ���������� � ����� -20001
        inner_exception exception;
        pragma exception_init(inner_exception, -20001);

    begin
        -- ��������� ���������� �� ��������� �����
        raise inner_exception;
    exception
        when inner_exception then
            dbms_output.put_line('���������� ���������� �� ��������� �����.');
            raise; -- ������� ���������� � �������� ���� |    ����� ���������� inner_exception �������������� �����, ��� ��������������� ��� main_exception � �������� �����. |
    end;

exception
    when main_exception then
        dbms_output.put_line('���������� ���������� � �������� �����.');
end;


--� ���� ������ ����� ��������, ���, ���� ����� ���������� ���������,
--��� �������� ������� ���������� � ��������� ����� ������. ����������, ����������� �� ��������� �����, �������������� �������� �� ����������, ������������ � �������� �����.
--10. ���������, ������������ �� ���������� NO_DATA_FOUND � ������� SELECT�INTO � PL/SQL ����� � �������������� ��������� �������, �������� MAX.
DECLARE
  max_capacity NUMBER;
BEGIN
  SELECT MAX(auditorium_capacity) INTO max_capacity FROM AUDITORIUM;
  DBMS_OUTPUT.PUT_LINE('Max capacity: ' || max_capacity);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found');
END;
    
--� PL/SQL ����� ���������� NO_DATA_FOUND �� ������������ ��� ������������� ��������� �������, ����� ��� MAX, MIN, SUM, AVG � ������,
--���� ���� ����������� ���� ������� �������� NULL ��-�� ���������� ������. ��� ������� � ���, ��� ��������� ������� ������ ���������� ��������:
--���� �������������� ���������, ���� NULL, �� �� ���������� ���������� NO_DATA_FOUND.
