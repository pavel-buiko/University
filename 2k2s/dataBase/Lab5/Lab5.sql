---------1
SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;
SELECT * FROM DBA_USERS
---------2
CREATE TABLESPACE BPI_QDATA
DATAfILE 'bpi_qdata.dbf'
SIZE 10M
OFFLINE;

alter session set "_ORACLE_SCRIPT"=true;

ALTER TABLESPACE BPI_QDATA ONLINE 

CREATE ROLE bpirole;
grant CREATE SESSION, CREATE TABLE TO bpi_role
DROP ROLE bpi_role2


revoke bpirole from BPI
CREATE USER BPI IDENTIFIED BY 1111
DEFAULT TABLESPACE BPI_QDATA
QUOTA 2M ON BPI_QDATA
PROFILE DEFAULT;

GRANT CREATE SESSION, CREATE TABLE to BPI

SELECT *
FROM DBA_ROLE_PRIVS
WHERE GRANTED_ROLE = 'BPI_ROLE2';


CREATE TABLE BPI_T1 (
id number(6) PRIMARY KEY,
Name varchar2(50),
Price number(10)
)
TABLESPACE BPI_QDATA;

SELECT * FROM BPI.BPI_T1;


SELECT owner 
FROM dba_tables 
WHERE table_name = 'BPI_T1';

SELECT sys_context('userenv', 'current_schema') AS current_schema FROM dual;


SELECT table_name
FROM user_tables
WHERE table_name = 'BPI_T1';

SELECT table_name
FROM dba_tables
WHERE owner = 'BPI'
  AND table_name = 'BPI_T1';


SELECT table_name
FROM all_tables
WHERE table_name = 'BPI_T1';

INSERT INTO BPI_T1 (id, Name, Price) VALUES (1, 'Example 1', 100);
INSERT INTO BPI_T1 (id, Name, Price) VALUES (2, 'Example 2', 200);
INSERT INTO BPI_T1 (id, Name, Price) VALUES (3, 'Example 3', 300);

DROP TABLE BPI_T1

DROP USER BPI CASCADE

SELECT * FROM DBA_TABLES

SELECT owner
FROM all_tables
WHERE table_name = 'BPI_T1';

---------3
SELECT * 
FROM DBA_SEGMENTS
WHERE tablespace_name = 'BPI_QDATA'

---------4
SELECT * 
FROM DBA_SEGMENTS
WHERE tablespace_name = 'BPI_QDATA'
AND segment_name NOT LIKE 'BPI_T1'

---------5
SELECT * 
FROM DBA_SEGMENTS
WHERE segment_name = 'BPI_T1'


---------6
DROP TABLE BPI_T1

---------7
SELECT * FROM USER_RECYCLEBIN


--список сегментов
SELECT SEGMENT_NAME
FROM DBA_SEGMENTS
WHERE tablespace_name = 'BPI_QDATA'

-- определения сегмента таблицы XXX_T1 
SELECT segment_name, segment_type
FROM dba_segments
WHERE segment_name = 'BPI_T1';

SELECT *
FROM user_recyclebin;
PURGE RECYCLEBIN;

--------8
SELECT flashback_on FROM v$database; --  :(
FLASHBACK TABLE BPI_T1 TO BEFORE DROP;
--------9
BEGIN
    FOR K in 1..10000 LOOP
        INSERT INTO BPI_T1 (Id, Name, Price) 
        VALUES (K, 'Имя', 1000); 
    END LOOP;
    COMMIT;
END;
--------10
SELECT *
FROM DBA_SEGMENTS
WHERE SEGMENT_NAME = 'BPI_T1';
--------11
SELECT OWNER, SEGMENT_NAME, EXTENT_ID, FILE_ID, BLOCK_ID, BLOCKS
FROM DBA_EXTENTS
WHERE OWNER = 'BPI';
--------12
SELECT rowid, t.*
  FROM BPI_T1 t
--AAAAAAA: номер файла
--G: номер блока
--BBB: номер места в блоке
--CCC: номер ряда
--DDD: номер байта в ряду
--EEE: номер байта в файле
типы сегментов

--------13
SELECT ORA_RowSCN, t.* FROM BPi.BPI_T1 t;


CREATE OR REPLACE TRIGGER bpi.bpi_t1_rowscn_trg
BEFORE INSERT OR UPDATE ON bpi.bpi_t1
FOR EACH ROW
BEGIN
  :new.ROWSCN := DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER;
END;
/


SELECT privilege 
FROM user_sys_privs;

DROP TABLESPACE BPI_QDATA INCLUDING CONTENTS AND DATAFILES;
