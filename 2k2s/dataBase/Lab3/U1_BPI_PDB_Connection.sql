CREATE TABLE BPI_TABLE (
Id number(3) PRIMARY KEY,
Title VARCHAR2(50),
Value number)

DROP TABLE BPI_TABLE

-- Вставка данных в таблицу BPI_TABLE
INSERT INTO BPI_TABLE (Id, Title, Value) VALUES (1, 'Товар 1', 100);
INSERT INTO BPI_TABLE (Id, Title, Value) VALUES (2, 'Товар 2', 200);
INSERT INTO BPI_TABLE (Id, Title, Value) VALUES (3, 'Товар 3', 300);

SELECT * FROM BPI_TABLE
--6
--Табличные пространства (Tablespaces):
SELECT *
FROM DBA_TABLESPACES;

--Файлы (Permanent and Temporary):
SELECT file_name, tablespace_name, 'DATAFILE' AS file_type
FROM dba_data_files
UNION ALL
SELECT file_name, tablespace_name, 'TEMPFILE' AS file_type
FROM dba_temp_files;


--Роли и привилегии (Roles and Privileges):
SELECT grantee, privilege
FROM dba_sys_privs
WHERE grantee IN (SELECT role FROM dba_roles);



--Профили безопасности
SELECT profile, resource_name, limit
FROM dba_profiles;

--Пользователи и их роли
SELECT username, default_tablespace, profile, account_status
FROM dba_users
WHERE username <> 'SYS'; -- исключаем системного пользователя SYS



SELECT owner, object_name, object_type
FROM all_objects
WHERE owner = 'U1_BPI_PDB';