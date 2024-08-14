GRANT CREATE SESSION TO C##UserFourteen container = all;
GRANT CREATE TABLESPACE TO C##UserFourteen container = all;
GRANT CREATE TABLE TO C##UserFourteen container = all;
GRANT CREATE ANY TABLE TO C##UserFourteen container = all;
GRANT DBA TO C##UserFourteen container = all;
GRANT CREATE TABLE TO C##UserFourteen;

ALTER USER C##UserFourteen QUOTA UNLIMITED ON USERS;
GRANT CREATE ANY TABLE TO C##UserFourteen;
GRANT EXECUTE ON DBMS_REDEFINITION TO C##UserFourteen

create tablespace ts_name_1
datafile 'name_1.dbf'
size 20m
reuse AUTOEXTEND on next 2M
online
extent management local;


create tablespace ts_name_2
datafile 'name_2.dbf'
size 20m
reuse AUTOEXTEND on next 2M
online
extent management local;

create tablespace ts_name_3
datafile 'name_3.dbf'
size 20m
reuse AUTOEXTEND on next 2M
online
extent management local;



create tablespace ts_name_4
datafile 'name_4.dbf'
size 20m
reuse AUTOEXTEND on next 2M
online
extent management local;

--1.	Создайте таблицу T_RANGE c диапазонным секционированием. Используйте ключ секционирования типа NUMBER. 	

create table t_rangel
(
str nvarchar2(20) primary key, num int
)
partition by range (num)
(
partition nums_less_10 values less than (10) tablespace ts_name_1,
partition nums_less_20 values less than (20) tablespace ts_name_2,
partition nums_less_30 values less than (30) tablespace ts_name_3,
partition nums_max values less than (maxvalue) tablespace ts_name_4
);

--2.	Создайте таблицу T_INTERVAL c интервальным секционированием. Используйте ключ секционирования типа DATE.
create table T_INTERVAL (id number, time_id date)
partition by range (time_id)
interval (numtoyminterval (1, 'month'))
(
partition po values less than (to_date ('11-12-2009', 'dd-mm-yyyy')),
partition pl values less than (to_date ('1-12-2015', 'dd-mm-yyyy')),
partition p2 values less than (to_date ('1-12-2018', 'dd-mm-yyyy'))
);
----------------
CREATE TABLE T_INTERVAL2 (
    id NUMBER,
    time_id DATE
)
PARTITION BY RANGE (time_id)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(
    PARTITION p0 VALUES LESS THAN (TO_DATE('11-12-2009', 'DD-MM-YYYY')) TABLESPACE ts_name_1,
    PARTITION p1 VALUES LESS THAN (TO_DATE('01-12-2015', 'DD-MM-YYYY')) TABLESPACE ts_name_2,
    PARTITION p2 VALUES LESS THAN (TO_DATE('01-12-2018', 'DD-MM-YYYY')) TABLESPACE ts_name_3
);

DROP TABLE  T_INTERVAL2;

--3.	Создайте таблицу T_HASH c хэш-секционированием. Используйте ключ секционирования типа VARCHAR2.
SELECT *
FROM user_tablespaces;

create table t_hash
(
id int generated always as identity primary key, str nvarchar2 (30)
)
partition by hash (str) (
    partition part_1 tablespace ts_name_1, 
    partition part_2 tablespace ts_name_2,
    partition part_3 tablespace ts_name_3,
    partition part_4 tablespace ts_name_4
);

DROP TABLE t_hash;



CREATE TABLE t_hash (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    str NVARCHAR2(30)
)
PARTITION BY HASH (str) (
    PARTITION part_1,
    PARTITION part_2,
    PARTITION part_3,
    PARTITION part_4
);

--4.	Создайте таблицу T_LIST со списочным секционированием. Используйте ключ секционирования типа CHAR.
create table t_list
(
id int generated always as identity primary key, str nchar(30)
)
partition by list (str)
(
partition part_1 values ('aaa', 'bbb', 'ccc', 'fff') tablespace ts_name_1,
partition part_2 values ('ggg', 'hhh', 'iii', 'lll') tablespace ts_name_2,
partition part_3 values ('mmm', 'nnn', 'ooo', 'qqq') tablespace ts_name_3,
partition part_default values (default) tablespace ts_name_4
);


--5.	Введите с помощью операторов INSERT данные в таблицы T_RANGE, T_INTERVAL, T_HASH, T_LIST.
--Данные должны быть такими, чтобы они разместились по всем секциям. Продемонстрируйте это с помощью SELECT запроса. 


-- Вставляем данные в таблицу T_LIST
INSERT INTO t_list (str) VALUES ('aaa');
INSERT INTO t_list (str) VALUES ('bbb');
INSERT INTO t_list (str) VALUES ('ccc');
INSERT INTO t_list (str) VALUES ('fff');
INSERT INTO t_list (str) VALUES ('ggg');
INSERT INTO t_list (str) VALUES ('hhh');
INSERT INTO t_list (str) VALUES ('iii');
INSERT INTO t_list (str) VALUES ('lll');
INSERT INTO t_list (str) VALUES ('mmm');
INSERT INTO t_list (str) VALUES ('nnn');
INSERT INTO t_list (str) VALUES ('ooo');
INSERT INTO t_list (str) VALUES ('qqq');

SELECT * FROM t_list;


-- Вставляем данные в таблицу T_HASH
INSERT INTO t_hash (str) VALUES ('aaa');
INSERT INTO t_hash (str) VALUES ('bbb');
INSERT INTO t_hash (str) VALUES ('ccc');
INSERT INTO t_hash (str) VALUES ('fff');
INSERT INTO t_hash (str) VALUES ('ggg');
INSERT INTO t_hash (str) VALUES ('hhh');
INSERT INTO t_hash (str) VALUES ('iii');
INSERT INTO t_hash (str) VALUES ('lll');
INSERT INTO t_hash (str) VALUES ('mmm');
INSERT INTO t_hash (str) VALUES ('nnn');
INSERT INTO t_hash (str) VALUES ('ooo');
INSERT INTO t_hash (str) VALUES ('qqq');

SELECT * FROM t_hash;


-- Вставляем данные в таблицу T_INTERVAL2
INSERT INTO t_interval2 (id, time_id) VALUES (1, TO_DATE('01-11-2009', 'DD-MM-YYYY'));
INSERT INTO t_interval2 (id, time_id) VALUES (2, TO_DATE('15-02-2010', 'DD-MM-YYYY'));
INSERT INTO t_interval2 (id, time_id) VALUES (3, TO_DATE('20-01-2016', 'DD-MM-YYYY'));
INSERT INTO t_interval2 (id, time_id) VALUES (4, TO_DATE('10-03-2017', 'DD-MM-YYYY'));
INSERT INTO t_interval2 (id, time_id) VALUES (5, TO_DATE('25-07-2018', 'DD-MM-YYYY'));


-- Проверяем данные в таблице T_INTERVAL2
SELECT * FROM t_interval2;


-- Вставляем данные в таблицу T_RANGE
INSERT INTO t_rangel (str, num) VALUES ('AAA', 5);
INSERT INTO t_rangel (str, num) VALUES ('BBB', 15);
INSERT INTO t_rangel (str, num) VALUES ('CCC', 25);
INSERT INTO t_rangel (str, num) VALUES ('DDD', 35);

-- Проверяем данные в таблице T_RANGE
SELECT * FROM t_rangel;



--6.	Продемонстрируйте для всех таблиц процесс перемещения строк между секциями, при изменении (оператор UPDATE) ключа секционирования
select * from t_rangel;
alter table t_rangel enable row movement;
update t_rangel set num = 50 where num = 5;
select * from t_rangel partition (nums_less_10);
select * from t_rangel partition (nums_max);



--7.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE MERGE.
alter table t_list merge partitions part_l, part_2 into partition part_12;
select * from t_list partition (part_12);

--8.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE SPLIT.

SELECT PARTITION_NAME, HIGH_VALUE
FROM USER_TAB_PARTITIONS
WHERE TABLE_NAME = 'T_INTERVAL2';


ALTER TABLE T_INTERVAL2 SPLIT PARTITION p1
    AT (TO_DATE('01-01-2014', 'DD-MM-YYYY'))
    INTO (PARTITION p1a TABLESPACE ts_name_2,
          PARTITION p1b TABLESPACE ts_name_3);

-- После выполнения операции проверим изменения в разделах
SELECT PARTITION_NAME, HIGH_VALUE
FROM USER_TAB_PARTITIONS
WHERE TABLE_NAME = 'T_INTERVAL2';

--9.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE EXCHANGE.
DROP TABLE t_list2;
CREATE TABLE t_list2 (
    id INT,
    str NCHAR(30)
)
PARTITION BY LIST (str)
(
    PARTITION part_1 VALUES ('aaa', 'bbb', 'ccc', 'fff') TABLESPACE ts_name_1,
    PARTITION part_2 VALUES ('ggg', 'hhh', 'iii', 'lll') TABLESPACE ts_name_2,
    PARTITION part_3 VALUES ('mmm', 'nnn', 'ooo', 'qqq') TABLESPACE ts_name_3,
    PARTITION part_default VALUES (DEFAULT) TABLESPACE ts_name_4
);
INSERT INTO t_list2 (str) VALUES ('aaa');
INSERT INTO t_list2 (str) VALUES ('bbb');
INSERT INTO t_list2 (str) VALUES ('ccc');
INSERT INTO t_list2 (str) VALUES ('fff');
INSERT INTO t_list2 (str) VALUES ('ggg');
INSERT INTO t_list2 (str) VALUES ('hhh');
INSERT INTO t_list2 (str) VALUES ('iii');
INSERT INTO t_list2 (str) VALUES ('lll');
INSERT INTO t_list2 (str) VALUES ('mmm');
INSERT INTO t_list2 (str) VALUES ('nnn');
INSERT INTO t_list2 (str) VALUES ('ooo');
INSERT INTO t_list2 (str) VALUES ('qqq');


CREATE TABLE t_list_temp (
    id INT,
    str NCHAR(30)
);

-- Вставка данных во временную таблицу
INSERT INTO t_list_temp (id, str)
VALUES (101, 'aaa');
INSERT INTO t_list_temp (id, str) VALUES(102, 'bbb');

-- Проверка данных во временной таблице
SELECT * FROM t_list_temp;



ALTER TABLE t_list2 EXCHANGE PARTITION part_1
WITH TABLE t_list_temp
INCLUDING INDEXES
WITHOUT VALIDATION;

-- После выполнения операции проверим данные в таблице T_LIST
SELECT * FROM t_list2;

--Список всех секционированных таблиц
SELECT table_name, partitioning_type
FROM all_part_tables
WHERE owner = 'SYS'; 

SELECT table_name, partitioning_type
FROM all_part_tables;
--Список всех секций какой-либо таблицы
SELECT partition_name, high_value
FROM all_tab_partitions
WHERE table_name = 'T_LIST';

--Список всех значений из какой-либо секции по имени секции
SELECT *
FROM T_LIST PARTITION (PART_3);


-- Список всех значений из какой-либо секции по ссылке
SELECT *
FROM t_rangel
WHERE NUM =5;
