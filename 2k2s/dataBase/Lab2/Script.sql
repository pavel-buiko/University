ALTER SESSION SET "_oracle_script" = TRUE

CREATE TABLESPACE TS_BPI
    DATAFILE 'TS_BPI.dbf' SIZE 7M
    AUTOEXTEND ON NEXT 5M MAXSIZE 30M;
    
CREATE TEMPORARY TABLESPACE TS_BPI_TEMP
    TEMPFILE 'TS_BPI_TEMP.dbf' SIZE 5M
    AUTOEXTEND ON NEXT 3M MAXSIZE 20M
    EXTENT MANAGEMENT LOCAL --UNIFORM SIZE 3M; --¬ы указываете, что хотите использовать
                                            --управление экстентами локально дл€ данного временного табличного пространства,
                                            --а не глобально дл€ всей базы данных. » опци€ UNIFORM SIZE 16M устанавливает размер экстентов равным 16 ћбайтам.
    
SELECT tablespace_name --3
FROM dba_tablespaces;

SELECT tablespace_name, file_name   //4
FROM dba_data_files;

-- —оздание роли
CREATE ROLE RL_BPICORE;  --5

-- Ќазначение привилегии на соединение
GRANT CREATE SESSION TO RL_BPICORE;

-- Ќазначение привилегии на создание, изменение и удаление объектов
GRANT CREATE TABLE TO RL_BPICORE;
GRANT CREATE VIEW TO RL_BPICORE;
GRANT CREATE PROCEDURE TO RL_BPICORE;


--6
SELECT role  
FROM dba_roles
where role = 'RL_BPICORE'

--7
SELECT * 
FROM dba_tab_privs
where GRANTEE = 'RL_BPICORE' -- не работает

 
SELECT *
FROM dba_sys_privs
WHERE grantee = 'RL_BPICORE'; -- работает

--8
CREATE PROFILE SECPROFILE LIMIT 
    PASSWORD_LIFE_TIME 180 -- количество дней жизни парол€
    SESSIONS_PER_USER 3 -- количество сессий дл€ пользовател€
    FAILED_LOGIN_ATTEMPTS 7 -- количество попыток входа
    PASSWORD_LOCK_TIME 1 -- количество дней блокировани€ после ошибок
    PASSWORD_REUSE_TIME 10 -- через сколько дней можно повторить пароль
    PASSWORD_GRACE_TIME DEFAULT -- количество дней предупреждений о смене парол€
    CONNECT_TIME 180 --врем€ соединени€, минут
    IDLE_TIME 30 --количество минут просто€

--10
SELECT * 
FROM dba_profiles
WHERE PROFILE = 'SECPROFILE'

--11
SELECT * 
FROM dba_profiles
WHERE PROFILE = 'DEFAULT'

--12
drop user BPICORE
CREATE USER BPICORE1
IDENTIFIED BY 12345
DEFAULT TABLESPACE TS_BPI
TEMPORARY TABLESPACE TS_BPI_TEMP
PROFILE SECPROFILE
ACCOUNT UNLOCK
PASSWORD EXPIRE;

GRANT RL_BPICORE TO BPICORE1
GRANT CREATE SESSION TO BPICORE
GRANT CONNECT TO BPICORE;
ALTER USER BPICORE IDENTIFIED BY 1111;


SELECT username, password_versions
FROM dba_users
WHERE username = 'BPICORE';

SELECT username, password
FROM dba_users
WHERE username = 'BPICORE';


SELECT account_status
FROM dba_users
WHERE username = 'BPICORE';

SELECT *
FROM dba_users
WHERE username = 'BPICORE';

DROP USER BPICORE;


CREATE TABLE BPI_T (
ID Number(3) PRIMARY KEY,
Name VARCHAR2(50),
Value number
)

Insert Into BPI_T (ID, Name, Value) VALUES (1, 'string', 100)
INSERT INTO BPI_T (ID, Name, Value) VALUES (2, 'string', 120);
INSERT INTO BPI_T (ID, Name, Value) VALUES (3, 'string', 90);

SELECT * 
FROM BPI_T

ALTER USER BPICORE QUOTA 2M ON TS_BPI

ALTER TABLESPACE TS_BPI OFFLINE
ALTER TABLESPACE TS_BPI ONLINE
--табличный протсранства 
--соотношени€ 
--привелегии админа
--„то такое файлы данных


