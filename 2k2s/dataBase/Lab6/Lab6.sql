---------1
show parameter spfile ;

---------3
CREATE PFILE='BPI_PFILE.ora' FROM SPFILE;

---------5
CREATE SPFILE= 'BPI_SPFILE.ora' FROM PFILE = 'BPI_PFILE.ora';

---------7
ALTER SYSTEM SET OPEN_CURSORS = 350;


---------8
SELECT name FROM v$controlfile;

SELECT * FROM V$CONTROLFILE;

---------9
ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'CONTROLFILE.TXT';

---------10
SELECT * FROM V$PASSWORDFILE_INFO;


---------12
SELECT * FROM V$DIAG_INFO;


---------14
SELECT value
FROM v$diag_info
WHERE name = 'Diag Trace';


