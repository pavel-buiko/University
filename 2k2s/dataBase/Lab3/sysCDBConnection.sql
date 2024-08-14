SELECT name, open_mode
FROM v$pdbs;

alter session set "_ORACLE_SCRIPT"=TRUE;
----3 лаба
CREATE TABLESPACE C##tablespace
DATAFILE 'C##tablespace.dbf'
SIZE 100M
AUTOEXTEND ON
NEXT 10M;
ALTER TABLESPACE C##tablespace online
drop tablespace C##tablespace including CONTENTS and DATAFILES;

CREATE ROLE C##my_role;

GRANT CREATE SESSION, CREATE TABLE TO C##my_role;

DROP ROLE C##my_role

CREATE PROFILE C##my_profile
LIMIT
  FAILED_LOGIN_ATTEMPTS 3
  PASSWORD_LOCK_TIME 1
  PASSWORD_LIFE_TIME 90
  PASSWORD_REUSE_TIME 30
  PASSWORD_REUSE_MAX 10;
  
DROP PROFILE C##my_profile


CREATE USER C##IPB IDENTIFIED BY 1111 container=all
default tablespace C##tablespace
PROFILE C##my_profile;


ALTER USER C##IPB QUOTA 100M ON Users;



GRANT C##my_role to C##IPB



alter session set "_oracle_script"=true;

DROP USER C##IPB CASCADE