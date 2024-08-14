/*1 ���������� ����� ������ ������� SGA.*/
-------------------1
select * from V$SGA;
select SUM(value) from v$sga;

/*2.���������� ������� ������� �������� ����� SGA.*/
-------------------2
select * from v$sga_dynamic_components where current_size > 0;

/*3.���������� ������� ������� ��� ������� ����.*/
--------------------3
select component, granule_size from v$sga_dynamic_components where current_size > 0;

/*4.���������� ����� ��������� ��������� ������ � SGA.*/
--------------------4
select current_size from v$sga_dynamic_free_memory;

/*5. ���������� ������������ � ������� ������ ������� SGA.*/
--------------------5
SHOW PARAMETER SGA_MAX_SIZE

/*6. ���������� ������� ����� ���P, DEFAULT � RECYCLE ��������� ����.*/
--------------------6
select component, current_size, min_size from v$sga_dynamic_components 
where component='KEEP buffer cache' or component='DEFAULT buffer cache' or component='RECYCLE buffer cache';


/*7. �������� �������, ������� ����� ���������� � ��� ���P.
����������������� ������� �������.*/
--------------------7
CREATE TABLE MyTable (
   id NUMBER,
   name VARCHAR2(50)
) TABLESPACE users STORAGE (BUFFER_POOL KEEP);

SELECT segment_name, segment_type, tablespace_name, buffer_pool 
FROM user_segments 
WHERE segment_name = 'MYTABLE';


drop table MyTable;


/*8.�������� �������, ������� ����� ������������ � ���� 
DEFAULT. ����������������� ������� �������. */
--------------------8
CREATE TABLE my_cached_table (
  id NUMBER,
  name VARCHAR2(50),
  age NUMBER
) CACHE;

SELECT segment_name, segment_type, tablespace_name
FROM user_segments
WHERE segment_name = 'MY_CACHED_TABLE';

/*9.	������� ������ ������ �������� �������. */
--------------------9
show parameter log_buffer;


/*10.	������� ������ ��������� ������ � ������� ����. */
--------------------10
select sum(decode(name,'free memory',bytes)) 
from v$sgastat 
where pool = 'large pool';


/*11.���������� ������ ������� ���������� � ��������� (dedicated, shared). */
--------------------11
select username, service_name, server, osuser, machine, program 
from v$session 
where username is not null;

/*12. �������� ������ ������ ���������� � ��������� ����� ������� ���������. */
--------------------12
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

SELECT name, description FROM v$bgprocess;


/*13.	�������� ������ ���������� � ��������� ����� ��������� ���������. */
--------------------13
select * from v$bgprocess where paddr != '00';

/*14. ����������, ������� ��������� DBWn �������� � ��������� ������. */
--------------------14
select count(*) from v$bgprocess where paddr!= '00' and name like 'DBW%';


/*15.	���������� ������� (����� ����������� ����������). */
--------------------15
select * from v$services;


/*16 �������� ��������� ��� ��������� �����������. */
--------------------16
select * from v$dispatcher;

show parameter dispatchers;


