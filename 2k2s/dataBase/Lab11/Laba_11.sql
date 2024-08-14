----------1. Разработайте АБ, демонстрирующий работу оператора SELECT с точной выборкой. ------------
declare 
  faculty_rec faculty%rowtype;
begin 
  select * into faculty_rec from faculty where faculty = 'TOV';
  dbms_output.put_line(faculty_rec.faculty ||' '||faculty_rec.faculty_name);
end;

--2. Разработайте АБ, демонстрирующий работу оператора SELECT с неточной точной выборкой.
--Используйте конструкцию WHEN OTHERS секции исключений и встроенную функции SQLERRM, SQLCODE для диагностирования неточной выборки. ---
declare 
faculty_result faculty%rowtype;
begin
select * into faculty_result from faculty;
dbms_output.put_line(faculty_result.faculty || ' ' || faculty_result.faculty_name);
exception
when others 
then dbms_output.put_line('caught: ' || sqlcode|| ' '||sqlerrm);

end;

--3. Разработайте АБ, демонстрирующий работу конструкции WHEN TO_MANY_ROWS секции исключений для
--диагностирования неточной выборки.
declare
    faculty_rec faculty%rowtype;
begin
    select * into faculty_rec from faculty;
    dbms_output.put_line(faculty_rec.faculty || '  ' || faculty_rec.faculty_name);
exception
    when too_many_rows
    then dbms_output.put_line('caught: ' || sqlcode || ' ' || sqlerrm );
end;



--4. Разработайте АБ, демонстрирующий возникновение и обработку исключения NO_DATA_FOUND.
--Разработайте АБ, демонстрирующий применение атрибутов неявного курсора.
DECLARE
    faculty_rec faculty%rowtype;
    v_rowcount  INTEGER;
BEGIN
    SELECT *
    INTO faculty_rec
    FROM faculty
    WHERE faculty = 'EEE';

    v_rowcount := SQL%ROWCOUNT;  -- Получаем количество обработанных строк

    IF SQL%FOUND THEN
        -- Выводим информацию о факультете, если выборка прошла успешно
        dbms_output.put_line(faculty_rec.faculty || '  ' || faculty_rec.faculty_name);
        dbms_output.put_line('Rows affected: ' || v_rowcount);  -- Выводим количество строк
    ELSE
        -- Если не найдено ни одной строки, выводим сообщение
        dbms_output.put_line('No data found for faculty EEE.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Rows affected: ' || v_rowcount);
        dbms_output.put_line('Caught: ' || SQLCODE || ' ' || SQLERRM);
END;





--5. Разработайте АБ, демонстрирующий применение операторов INSERT, UPDATE, DELETE,
--вызывающие нарушение целостности в базе данных. Обработайте исключения.
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

--6. Создайте анонимный блок, распечатывающий таблицу TEACHER с применением явного курсора LOOP-цикла.
--Считанные данные должны быть записаны в переменные, объявленные с применением опции %TYPE

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

--7. Создайте АБ, распечатывающий таблицу SUBJECT с применением явного курсора иWHILE-цикла.
--Считанные данные должны быть записаны в запись (RECORD), объявленную с применением опции %ROWTYPE.

declare 
    cursor curs_subject is select * from subject;
    rec_subject subject%rowtype; --Считанные данные должны быть записаны в запись (RECORD), объявленную с применением опции %ROWTYPE.
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
--8. Создайте АБ, распечатывающий следующие списки аудиторий:
--все аудитории (таблица AUDITORIUM) с вместимостью меньше 20, от 21-30, от 31-60, от 61 до 80, от 81 и выше.
--Примените курсор с параметрами и три способа организации цикла по строкам курсора.

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

--9. Создайте AБ. Объявите курсорную переменную с помощью системного типа refcursor.
--Продемонстрируйте ее применение для курсора c параметрами. 


DECLARE
    -- Объявляем переменную для курсора типа REFCURSOR
    cur_refcursor SYS_REFCURSOR;
    -- Объявляем переменные для хранения данных, которые будут извлекаться из курсора
    d_faculty faculty.faculty%TYPE;
    d_faculty_name faculty.faculty_name%TYPE;

BEGIN
    -- Открываем курсор с параметрами
    OPEN cur_refcursor FOR
        SELECT faculty, faculty_name
        FROM faculty
        WHERE faculty = 'HTiT';

    -- Извлекаем данные из курсора в переменные
    LOOP
        FETCH cur_refcursor INTO d_faculty, d_faculty_name;
        EXIT WHEN cur_refcursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Faculty: ' || d_faculty || ', Faculty Name: ' || d_faculty_name);
    END LOOP;

    -- Закрываем курсор
    CLOSE cur_refcursor;

END;


--10. Создайте AБ. Уменьшите вместимость всех аудиторий (таблица AUDITORIUM) вместимостью от 40 до 80 на 10%.
--Используйте явный курсор с параметрами, цикл FOR, конструкцию UPDATE CURRENT OF. 

DECLARE
    CURSOR cur_auditoriums (min_capacity NUMBER, max_capacity NUMBER) IS
        SELECT auditorium, auditorium_capacity
        FROM auditorium
        WHERE auditorium_capacity >= min_capacity
          AND auditorium_capacity <= max_capacity
        FOR UPDATE OF auditorium_capacity;  -- Для обновления текущей строки в курсоре
    v_new_capacity NUMBER;
BEGIN
    -- Открываем курсор для аудиторий с вместимостью от 40 до 80 человек
    OPEN cur_auditoriums(40, 80);
    -- Цикл обработки записей из курсора
    FOR aud_rec IN cur_auditoriums LOOP
        -- Вычисляем новую вместимость (уменьшаем на 10%)
        v_new_capacity := aud_rec.auditorium_capacity * 0.9;
        -- Обновляем текущую запись в курсоре
        UPDATE auditorium
        SET auditorium_capacity = v_new_capacity
        WHERE CURRENT OF cur_auditoriums;
        -- Выводим информацию о выполненном обновлении
        DBMS_OUTPUT.PUT_LINE('Updated auditorium ' || aud_rec.auditorium ||
                             ': Old capacity = ' || aud_rec.auditorium_capacity ||
                             ', New capacity = ' || v_new_capacity);
    END LOOP;
    -- Закрываем курсор
    CLOSE cur_auditoriums;
    -- Фиксируем изменения в базе данных
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Обработка исключений
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' ' || SQLERRM);
        ROLLBACK; -- Откат изменений, если произошла ошибка
END;
