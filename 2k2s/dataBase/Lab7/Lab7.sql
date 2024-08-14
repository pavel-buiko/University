/*1 Определите общий размер области SGA.*/
-------------------1
select * from V$SGA;
select SUM(value) from v$sga;

/*2.Определите текущие размеры основных пулов SGA.*/
-------------------2
select * from v$sga_dynamic_components where current_size > 0;

/*3.Определите размеры гранулы для каждого пула.*/
--------------------3
select component, granule_size from v$sga_dynamic_components where current_size > 0;

/*4.Определите объем доступной свободной памяти в SGA.*/
--------------------4
select current_size from v$sga_dynamic_free_memory;

/*5. Определите максимальный и целевой размер области SGA.*/
--------------------5
SHOW PARAMETER SGA_MAX_SIZE

/*6. Определите размеры пулов КЕЕP, DEFAULT и RECYCLE буферного кэша.*/
--------------------6
select component, current_size, min_size from v$sga_dynamic_components 
where component='KEEP buffer cache' or component='DEFAULT buffer cache' or component='RECYCLE buffer cache';


/*7. Создайте таблицу, которая будет помещаться в пул КЕЕP.
Продемонстрируйте сегмент таблицы.*/
--------------------7
CREATE TABLE MyTable (
   id NUMBER,
   name VARCHAR2(50)
) TABLESPACE users STORAGE (BUFFER_POOL KEEP);

SELECT segment_name, segment_type, tablespace_name, buffer_pool 
FROM user_segments 
WHERE segment_name = 'MYTABLE';


drop table MyTable;


/*8.Создайте таблицу, которая будет кэшироваться в пуле 
DEFAULT. Продемонстрируйте сегмент таблицы. */
--------------------8
CREATE TABLE my_cached_table (
  id NUMBER,
  name VARCHAR2(50),
  age NUMBER
) CACHE;

SELECT segment_name, segment_type, tablespace_name
FROM user_segments
WHERE segment_name = 'MY_CACHED_TABLE';

/*9.	Найдите размер буфера журналов повтора. */
--------------------9
show parameter log_buffer;


/*10.	Найдите размер свободной памяти в большом пуле. */
--------------------10
select sum(decode(name,'free memory',bytes)) 
from v$sgastat 
where pool = 'large pool';


/*11.Определите режимы текущих соединений с инстансом (dedicated, shared). */
--------------------11
select username, service_name, server, osuser, machine, program 
from v$session 
where username is not null;

/*12. Получите полный список работающих в настоящее время фоновых процессов. */
--------------------12
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

SELECT name, description FROM v$bgprocess;


/*13.	Получите список работающих в настоящее время серверных процессов. */
--------------------13
select * from v$bgprocess where paddr != '00';

/*14. Определите, сколько процессов DBWn работает в настоящий момент. */
--------------------14
select count(*) from v$bgprocess where paddr!= '00' and name like 'DBW%';


/*15.	Определите сервисы (точки подключения экземпляра). */
--------------------15
select * from v$services;


/*16 Получите известные вам параметры диспетчеров. */
--------------------16
select * from v$dispatcher;

show parameter dispatchers;


