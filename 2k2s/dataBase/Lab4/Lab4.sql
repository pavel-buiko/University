-------1
-- Выбирает название и тип содержимого для всех tablespace из каталога dba_tablespaces.

SELECT tablespace_name, contents
FROM dba_tablespaces;

-------2
-- Выбирает название tablespace и имя файла для всех данных и временных файлов из каталогов dba_data_files и dba_temp_files, соответственно.

SELECT tablespace_name, file_name 
FROM dba_data_files;

SELECT tablespace_name, file_name
FROM dba_temp_files;

-- Выбирает все данные из dba_undo_extents.

SELECT *
FROM dba_undo_extents;

-------3
-- Выбирает все столбцы из представления V$LOG, которое содержит информацию о журнальных файлах (логах) базы данных.

SELECT * FROM V$LOG;

-------4
-- Выбирает все столбцы из представления v$logfile, содержащего информацию о всех физических журнальных файлах базы данных.

SELECT * FROM v$logfile;

-------5
-- Переключает текущий журнальный файл и затем выбирает все данные из представления V$LOG, которое показывает информацию о журнальных файлах после переключения.
-- Затем выбирает текущее значение системного порядкового номера (SCN) из v$database.

ALTER SYSTEM SWITCH LOGFILE;

SELECT * FROM V$LOG;

SELECT current_scn FROM v$database;

-------6
-- Добавляет новый групповой журнальный файл для группы 4 с указанным размером и блочным размером.
-- Добавляет новый член журнального файла к группе 4, переиспользуя существующий файл 'REDO11.log'.
-- Добавляет еще один новый член журнального файла к группе 4, также переиспользуя существующий файл 'REDO12.log'.

alter database add logfile group 4 'REDO10.log' size 50m blocksize 512;
alter database add logfile member 'REDO11.log' reuse to group 4;
alter database add logfile member 'REDO12.log' reuse to group 4;

-------7
-- Удаляет указанные члены журнального файла из группы 4, а затем удаляет саму группу журнальных файлов.

alter database drop logfile member 'REDO10.log';
alter database drop logfile member 'REDO11.log';
alter database drop logfile member 'REDO12.log';
alter database drop Logfile group 4;

-------8
-- Возвращает текущий режим журнализации базы данных.
-- Показывает состояние архивации в текущем экземпляре базы данных.

SELECT log_mode FROM v$database;

SELECT ARCHIVER FROM V$INSTANCE;

-------9
--номер последнего архива
SELECT MAX(SEQUENCE#) AS LAST_ARCHIVE_SEQUENCE
FROM V$ARCHIVED_LOG;

SELECT * 
FROM V$ARCHIVED_LOG;
------10
-- Показывает состояние архивации в текущем экземпляре базы данных и режим журнализации.

SELECT ARCHIVER FROM V$INSTANCE;

SELECT log_mode FROM sys.v$database;

------11
-- Находит максимальный порядковый номер последовательности (SEQUENCE#) в журналах истории (повтора).
-- Показывает параметры журнализации.
-- Выбирает последовательность SCN в архивных журналах.
-- Выполняет переключение текущего журнального файла и выбирает имя файла, первый и следующий SCN после переключения.

SELECT MAX(SEQUENCE#) AS MAX_SEQUENCE FROM V$LOG_HISTORY;

SHOW PARAMETER LOG_ARCHIVE_DEST;

SELECT FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG ORDER BY FIRST_CHANGE#;

SELECT FIRST_CHANGE#, NEXT_CHANGE# FROM V$LOG_HISTORY ORDER BY FIRST_CHANGE#;

ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 = 'LOCATION=/archive';

ALTER SYSTEM SWITCH LOGFILE;

SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--------12
-- Показывает название базы данных и ее текущий режим журнализации.

SELECT name, log_mode FROM v$database;

--------13
-- Показывает информацию о контрольных файлах базы данных.

SELECT * FROM v$controlfile;

--------14
-- Показывает значение параметра control.
SHOW PARAMETER CONTROL;



