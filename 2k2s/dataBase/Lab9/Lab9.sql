/*2.	Создайте временную таблицу, добавьте в нее данные и продемонстрируйте,
как долго они хранятся. Поясните особенности работы с временными таблицами.*/

CREATE GLOBAL TEMPORARY TABLE temp_table (
    id NUMBER,
    name VARCHAR2(50)
);

INSERT INTO temp_table (id, name)
VALUES (1, 'John');

INSERT INTO temp_table (id, name)
VALUES (2, 'Jane');

SELECT * FROM temp_table


/*3.	Создайте последовательность S1 (SEQUENCE), со следующими 
характеристиками: начальное значение 1000; приращение 10; нет минимального 
значения; нет максимального значения; не циклическая; значения не кэшируются
в памяти; хронология значений не гарантируется. Получите несколько значений
последовательности. Получите текущее значение последовательности.*/

CREATE SEQUENCE s1
  START WITH 1000
  INCREMENT BY 10
  NOMINVALUE
  NOMAXVALUE
  NOCYCLE
  NOCACHE
  NOORDER;
--Получите несколько значений последовательности. 
select S1.nextval from dual;
--Получите текущее значение последовательности.
select S1.currval from dual;



/*4.	Создайте последовательность S2 (SEQUENCE), со следующими характеристиками: 
начальное значение 10; приращение 10; максимальное значение 100; не циклическую.
Получите все значения последовательности. Попытайтесь получить значение,
выходящее за максимальное значение.*/

create sequence S2
  start with 10
  increment by 10
  maxvalue 100
  nocycle;
--Получите все значения последовательности. 
select S2.nextval from dual;
select S2.currval from dual;



/*5.	Создайте последовательность S3 (SEQUENCE), со следующими
характеристиками: начальное значение 10; приращение -10; минимальное 
значение -100; не циклическую; гарантирующую хронологию значений. Получите 
все значения последовательности. Попытайтесь получить значение, меньше 
минимального значения.*/

create sequence S3
  start with 10
  increment by -10
  maxvalue 11 
  minvalue -100
  nocycle
  order;
--Получите все значения последовательности. 
select S3.nextval from dual;
select S3.currval from dual;



/*6.	Создайте последовательность S4 (SEQUENCE), со следующими характеристиками:
начальное значение 1; приращение 1; минимальное значение 10; циклическая; кэшируется
в памяти 5 значений; хронология значений не гарантируется. Продемонстрируйте цикличность 
генерации значений последовательностью S4.*/

create sequence S4
  start with 1
  increment by 1
  maxvalue 10
  cycle
  cache 5
  noorder;
--Продемонстрируйте цикличность генерации значений последовательностью S4.
select S4.nextval from dual;
select S4.currval from dual;

/*7.	Получите список всех последовательностей в словаре базы данных, 
владельцем которых является пользователь XXX.*/
select * from user_sequences;


/*8.	Создайте таблицу T1, имеющую столбцы N1, N2, N3, N4, типа NUMBER (20),
кэшируемую и расположенную в буферном пуле KEEP. С помощью оператора INSERT 
добавьте 7 строк, вводимое значение для столбцов должно формироваться с 
помощью последовательностей S1, S2, S3, S4.*/
create table T1 (
        N1 NUMBER(20),
        N2 NUMBER(20),
        N3 NUMBER(20),
        N4 NUMBER(20)) cache storage(buffer_pool keep);

begin
  for i in 1..7 loop
  insert into T1(N1, N2, N3, N4) values (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
  end loop;
end;
select * from T1;

/*9.	Создайте кластер ABC, имеющий hash-тип (размер 200) и
содержащий 2 поля: X (NUMBER (10)), V (VARCHAR2(12)).*/
create cluster abc ( 
                    x number (10), 
                    v varchar2(12)) 
        hashkeys 200;
        
        
    /*10.	Создайте таблицу A, имеющую столбцы XA (NUMBER (10)) и VA (VARCHAR2(12)),
принадлежащие кластеру ABC, а также еще один произвольный столбец.*/
create table A(XA number(10),
               VA varchar2(12), 
               aa number(10))
cluster ABC (XA, VA);
        
        /*11.	Создайте таблицу B, имеющую столбцы XB (NUMBER (10)) и VB (VARCHAR2(12)), 
принадлежащие кластеру ABC, а также еще один произвольный столбец.*/
create table B(xb number(10),
               VB varchar2(12), 
               bb number(10))
cluster ABC (XB, VB);

    /*12.	Создайте таблицу С, имеющую столбцы XС (NUMBER (10)) и VС (VARCHAR2(12))
, принадлежащие кластеру ABC, а также еще один произвольный столбец. */
create table c(XC number(10),
               VC varchar2(12), 
               cc number(10))
cluster ABC (XC, VC);


/*13.	Найдите созданные таблицы и кластер в представлениях словаря Oracle.*/
select * from user_tables;
select * from user_clusters;


/*15.	Создайте публичный синоним для таблицы XXX.B и продемонстрируйте его применение.*/
create public synonym sb for b;
DROP public synonym sb
select * from sb;

/*16.	Создайте две произвольные таблицы A и B (с первичным и внешним ключами)
, заполните их данными, создайте представление V1, основанное на SELECT... FOR 
A inner join B. Продемонстрируйте его работоспособность.*/
create table A1(x number(10), y varchar(12),constraint x_pk primary key (x));
create table B1(x number(10),y varchar(12), constraint x_fk foreign key (x) references A1(x));

insert into A1 (x, y) values (1,'a');
insert into A1 (x, y) values (2,'b');
insert into A1 (x, y) values (3,'c');
insert into B1 (x, y) values (1,'d');
insert into B1 (x, y) values (2,'e');
insert into B1 (x, y) values (3,'f');

select * from a1;
select * from b1;

create view V1 as select A1.y as ay, B1.y as byf, A1.x from A1 inner join B1 on A1.x=B1.x;
select * from V1;


/*17.	На основе таблиц A и B создайте материализованное представление MV_XXX,
которое имеет периодичность обновления 2 минуты. Продемонстрируйте его работоспособность.*/

create materialized view MV_IPB
build immediate 
refresh complete on demand next sysdate + numtodsinterval(2, 'minute') 
as select * from A1;

select * from  MV_IPB

insert into a1 (x, y) values (4,'aa');
insert into A1 (x, y) values (5,'bb');