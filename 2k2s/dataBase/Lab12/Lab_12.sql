--1. Добавьте в таблицу TEACHERS два столбца BIRTHDAY и SALARY, заполните их значениями.

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



--2. Получите список преподавателей в виде Фамилия И.О. для преподавателей, родившихся в понедельник.
SELECT 
    TRIM(TO_CHAR(SUBSTR(TEACHER_NAME, 1, INSTR(TEACHER_NAME, ' ') - 1))) || ' ' ||
    SUBSTR(TEACHER_NAME, INSTR(TEACHER_NAME, ' ') + 1, 1) || '.' ||
    SUBSTR(SUBSTR(TEACHER_NAME, INSTR(TEACHER_NAME, ' ') + 2), 1, 1) || '.' as Имя
FROM 
    TEACHER
WHERE 
    TO_CHAR(birthday, 'D') = '1'; -- Понедельник (1)

SELECT * FROM teacher
WHERE TEACHER_NAME LIKE 'Prokopchuk%';
--3. Создайте представление, в котором поместите список преподавателей,
--которые родились в следующем месяце и выведите их даты рождения в формате «DD/MM/YYYY».
CREATE OR REPLACE VIEW teachers_next_month_birthdays AS
SELECT 
  teacher_name, 
  TO_CHAR(birthday, 'DD/MM/YYYY') AS birthday 
FROM 
  teacher 
WHERE 
  TO_CHAR(birthday, 'MM') = TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MM');

SELECT * FROM teachers_next_month_birthdays;

--4. Создайте представление, в котором поместите количество преподавателей, которые родились в каждом месяце, название месяца указать словом.

CREATE OR REPLACE VIEW teachers_birthdays_per_month AS
SELECT 
  TO_CHAR(birthday, 'Month') AS month_name, 
  COUNT(*) AS num_teachers 
FROM 
  teacher 
GROUP BY 
  TO_CHAR(birthday, 'Month');
  
  
select * from teachers_birthdays_per_month;


--5. Создать курсор и вывести список преподавателей,
-- Создаем курсор для выборки преподавателей с юбилеем в следующем году
DECLARE
  CURSOR c_teachers_with_anniversary IS
    SELECT 
      teacher_name,
      birthday,
      EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday) AS age_next_year
    FROM
      teacher
    WHERE 
      MOD(EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday), 10) = 0; -- Проверка на юбилей (кратный 10)

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

--у которых в следующем году юбилей с указанием, сколько лет исполняется.
DECLARE
  CURSOR c_teachers_with_30th_anniversary IS
    SELECT 
      teacher_name,
      birthday,
      EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday) AS age_next_year
    FROM 
      teacher
    WHERE 
      EXTRACT(YEAR FROM SYSDATE) + 1 - EXTRACT(YEAR FROM birthday) = 60; -- Проверка на 30-летний юбилей

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



--6. Создать курсор и вывести среднюю заработную плату по кафедрам с округлением вниз до целых, вывести средние итоговые значения для каждого факультета и для всех факультетов в целом.
declare
    cursor c_pulp is select pulpit, faculty from pulpit;
    -- Определяет курсор `c_pulp` для выборки всех кафедр и факультетов из таблицы `pulpit`.
    
    cursor c_fac is select faculty from faculty;
    -- Определяет курсор `c_fac` для выборки всех факультетов из таблицы `faculty`.
    
    avgsal number(6);
    -- Объявляет переменную `avgsal` типа number(6) для хранения среднего значения зарплаты.
    
begin
    dbms_output.put_line('--------------------pulpits----------------:');
    -- Выводит строку-заголовок для раздела кафедр.
    
    for r_pulp in c_pulp
    loop
        -- Для каждой записи (кафедра и факультет) в курсоре `c_pulp` выполняется следующий код:
        select floor(avg(salary)) into avgsal from teacher where pulpit = r_pulp.pulpit;
        -- Вычисляет среднюю зарплату для текущей кафедры и записывает её в переменную `avgsal`.
        
        dbms_output.put_line(rpad(r_pulp.pulpit, 20) || ' ' || avgsal);
        -- Выводит название кафедры и среднюю зарплату, форматируя строку с помощью `rpad`.
    end loop;
    
    dbms_output.put_line('------------------faculties:----------------');
    -- Выводит строку-заголовок для раздела факультетов.
    
    for r_fac in c_fac
    loop
        -- Для каждой записи (факультет) в курсоре `c_fac` выполняется следующий код:
        select floor(avg(salary)) into avgsal from teacher where pulpit in (select pulpit from pulpit where faculty = r_fac.faculty);
        -- Вычисляет среднюю зарплату для всех кафедр текущего факультета и записывает её в переменную `avgsal`.
        
        dbms_output.put_line(rpad(r_fac.faculty, 20) || ' ' || avgsal);
        -- Выводит название факультета и среднюю зарплату, форматируя строку с помощью `rpad`.
    end loop;
    
    select floor(avg(salary)) into avgsal from teacher;
    -- Вычисляет среднюю зарплату для всех записей в таблице `teacher` и записывает её в переменную `avgsal`.
    
    dbms_output.put_line(rpad('all', 20) || avgsal);
    -- Выводит строку 'all' и общую среднюю зарплату, форматируя строку с помощью `rpad`.
end;

--7. Создать неименованный блок для расчета результата деления двух переменных.
--Добавить обработку ситуации с делением на 0 через исключение ZERO_DIVIDE. Сгенерировать пользовательскую ошибку при значении делителя 0.
declare
    numerator   number := 10; -- числитель
    denominator number := 0;  -- знаменатель
    result      number;
begin
    if denominator = 0 then
        raise_application_error(-20001, 'Ошибка: Деление на 0 невозможно.'); --user exception
    else
        result := numerator / denominator;
        dbms_output.put_line('Результат деления: ' || result);
    end if;
exception
    when ZERO_DIVIDE then
        dbms_output.put_line('Исключение: деление на 0.');
end;


--8. Создать неименованный блок с командой SELECT…INTO для выбора наименования преподавателя по заданному коду.
--Добавить обработку исключения NO_DATA_FOUND с выводом информации 'Преподаватель не найден!'. Проверить, что произойдет при переопределении исключения.
DECLARE
  v_teacher_name VARCHAR2(100);
  v_teacher CHAR(10) := 'XUZ';
  v_teacher NUMBER := 111; 
BEGIN
  SELECT teacher_name INTO v_teacher_name FROM teacher WHERE teacher= v_teacher;
  
  DBMS_OUTPUT.PUT_LINE('Преподаватель: ' || v_teacher_name);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Преподаватель не найден!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
END;

--9. Создать основной и вложенный блок. Объявить в них исключения с разными именами, связать с кодом ошибки -20 001 с помощью PRAGMA EXCEPTION_INIT.
--Сгенерировать исключение во вложенном блоке, обработать его в основном. Проверить ситуацию, когда исключения не связаны с кодом ошибки и имеют одинаковое наименование.
declare
    -- Основной блок: объявление исключения с кодом -20001
    main_exception exception;
    pragma exception_init(main_exception, -20001);

begin
    declare
        -- Вложенный блок: объявление исключения с кодом -20001
        inner_exception exception;
        pragma exception_init(inner_exception, -20001);

    begin
        -- Генерация исключения во вложенном блоке
        raise inner_exception;
    exception
        when inner_exception then
            dbms_output.put_line('Исключение обработано во вложенном блоке.');
            raise; -- Проброс исключения в основной блок |    Когда исключение inner_exception пробрасывается вверх, оно перехватывается как main_exception в основном блоке. |
    end;

exception
    when main_exception then
        dbms_output.put_line('Исключение обработано в основном блоке.');
end;


--В этом случае важно отметить, что, хотя имена исключений одинаковы,
--они являются разными сущностями в контексте своих блоков. Исключение, объявленное во вложенном блоке, обрабатывается отдельно от исключения, объявленного в основном блоке.
--10. Проверить, генерируются ли исключение NO_DATA_FOUND в команде SELECT…INTO в PL/SQL блоке с использованием групповых функций, например MAX.
DECLARE
  max_capacity NUMBER;
BEGIN
  SELECT MAX(auditorium_capacity) INTO max_capacity FROM AUDITORIUM;
  DBMS_OUTPUT.PUT_LINE('Max capacity: ' || max_capacity);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found');
END;
    
--В PL/SQL блоке исключение NO_DATA_FOUND не генерируется при использовании групповых функций, таких как MAX, MIN, SUM, AVG и другие,
--даже если результатом этих функций является NULL из-за отсутствия данных. Это связано с тем, что групповые функции всегда возвращают значение:
--либо агрегированный результат, либо NULL, но не генерируют исключение NO_DATA_FOUND.
