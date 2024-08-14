-------1
-- �������� �������� � ��� ����������� ��� ���� tablespace �� �������� dba_tablespaces.

SELECT tablespace_name, contents
FROM dba_tablespaces;

-------2
-- �������� �������� tablespace � ��� ����� ��� ���� ������ � ��������� ������ �� ��������� dba_data_files � dba_temp_files, ��������������.

SELECT tablespace_name, file_name 
FROM dba_data_files;

SELECT tablespace_name, file_name
FROM dba_temp_files;

-- �������� ��� ������ �� dba_undo_extents.

SELECT *
FROM dba_undo_extents;

-------3
-- �������� ��� ������� �� ������������� V$LOG, ������� �������� ���������� � ���������� ������ (�����) ���� ������.

SELECT * FROM V$LOG;

-------4
-- �������� ��� ������� �� ������������� v$logfile, ����������� ���������� � ���� ���������� ���������� ������ ���� ������.

SELECT * FROM v$logfile;

-------5
-- ����������� ������� ���������� ���� � ����� �������� ��� ������ �� ������������� V$LOG, ������� ���������� ���������� � ���������� ������ ����� ������������.
-- ����� �������� ������� �������� ���������� ����������� ������ (SCN) �� v$database.

ALTER SYSTEM SWITCH LOGFILE;

SELECT * FROM V$LOG;

SELECT current_scn FROM v$database;

-------6
-- ��������� ����� ��������� ���������� ���� ��� ������ 4 � ��������� �������� � ������� ��������.
-- ��������� ����� ���� ����������� ����� � ������ 4, ������������� ������������ ���� 'REDO11.log'.
-- ��������� ��� ���� ����� ���� ����������� ����� � ������ 4, ����� ������������� ������������ ���� 'REDO12.log'.

alter database add logfile group 4 'REDO10.log' size 50m blocksize 512;
alter database add logfile member 'REDO11.log' reuse to group 4;
alter database add logfile member 'REDO12.log' reuse to group 4;

-------7
-- ������� ��������� ����� ����������� ����� �� ������ 4, � ����� ������� ���� ������ ���������� ������.

alter database drop logfile member 'REDO10.log';
alter database drop logfile member 'REDO11.log';
alter database drop logfile member 'REDO12.log';
alter database drop Logfile group 4;

-------8
-- ���������� ������� ����� ������������ ���� ������.
-- ���������� ��������� ��������� � ������� ���������� ���� ������.

SELECT log_mode FROM v$database;

SELECT ARCHIVER FROM V$INSTANCE;

-------9
--����� ���������� ������
SELECT MAX(SEQUENCE#) AS LAST_ARCHIVE_SEQUENCE
FROM V$ARCHIVED_LOG;

SELECT * 
FROM V$ARCHIVED_LOG;
------10
-- ���������� ��������� ��������� � ������� ���������� ���� ������ � ����� ������������.

SELECT ARCHIVER FROM V$INSTANCE;

SELECT log_mode FROM sys.v$database;

------11
-- ������� ������������ ���������� ����� ������������������ (SEQUENCE#) � �������� ������� (�������).
-- ���������� ��������� ������������.
-- �������� ������������������ SCN � �������� ��������.
-- ��������� ������������ �������� ����������� ����� � �������� ��� �����, ������ � ��������� SCN ����� ������������.

SELECT MAX(SEQUENCE#) AS MAX_SEQUENCE FROM V$LOG_HISTORY;

SHOW PARAMETER LOG_ARCHIVE_DEST;

SELECT FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG ORDER BY FIRST_CHANGE#;

SELECT FIRST_CHANGE#, NEXT_CHANGE# FROM V$LOG_HISTORY ORDER BY FIRST_CHANGE#;

ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 = 'LOCATION=/archive';

ALTER SYSTEM SWITCH LOGFILE;

SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--------12
-- ���������� �������� ���� ������ � �� ������� ����� ������������.

SELECT name, log_mode FROM v$database;

--------13
-- ���������� ���������� � ����������� ������ ���� ������.

SELECT * FROM v$controlfile;

--------14
-- ���������� �������� ��������� control.
SHOW PARAMETER CONTROL;



