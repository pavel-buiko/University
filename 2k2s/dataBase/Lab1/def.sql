CREATE TABLE BPI (
ID Number(3) PRIMARY KEY,
Name VARCHAR2(50),
Value number 
)
DROP TABLE BPI

describe BPI

INSERT INTO BPI (ID, Name, Value) VALUES (1, '������ ������', 100);
INSERT INTO BPI (ID, Name, Value) VALUES (2, '������ ������', 120);
INSERT INTO BPI (ID, Name, Value) VALUES (3, '������ ������', 90);

COMMIT


select * from BPI



UPDATE BPI
SET Name = '����� ��������'
WHERE ID in (1,2)
select * from BPI

COMMIT


INSERT INTO BPI (ID, Name, Value) VALUES (4, '������ ������', 130);
INSERT INTO BPI (ID, Name, Value) VALUES (5, '������ ������', 140);

SELECT Name, SUM(Value) as Total 
FROM BPI 
GROUP BY Name;

select * from BPI 
WHERE Name = '����� ��������'


DELETE FROM BPI WHERE ID = 4
ROLLBACK //???




CREATE TABLE BPI_child (
    ChildID NUMBER(3) PRIMARY KEY,
    ChildName VARCHAR2(50),
    ChildValue NUMBER,
    FOREIGN KEY (ChildID) references BPI(ID)
);
DROP TABLE BPI_child

INSERT INTO BPI_child (ChildID, ChildName, ChildValue) VALUES (1, '������ �������� ������', 110);
INSERT INTO BPI_child (ChildID, ChildName, ChildValue) VALUES (2, '������ �������� ������', 40);
INSERT INTO BPI_child (ChildID, ChildName, ChildValue) VALUES (3, '������ ������', 40);


SELECT sum(ChildValue) FROM BPI_child

SELECT BPI.ID, BPI_child.ChildName 
FROM BPI
INNER JOIN BPI_child ON ID = ChildID


SELECT BPI.ID, BPI_child.ChildName
FROM BPI
LEFT JOIN BPI_child ON BPI_child.ChildID = BPI.ID








