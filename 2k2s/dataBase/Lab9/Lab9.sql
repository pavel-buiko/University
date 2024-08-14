/*2.	�������� ��������� �������, �������� � ��� ������ � �����������������,
��� ����� ��� ��������. �������� ����������� ������ � ���������� ���������.*/

CREATE GLOBAL TEMPORARY TABLE temp_table (
    id NUMBER,
    name VARCHAR2(50)
);

INSERT INTO temp_table (id, name)
VALUES (1, 'John');

INSERT INTO temp_table (id, name)
VALUES (2, 'Jane');

SELECT * FROM temp_table


/*3.	�������� ������������������ S1 (SEQUENCE), �� ���������� 
����������������: ��������� �������� 1000; ���������� 10; ��� ������������ 
��������; ��� ������������� ��������; �� �����������; �������� �� ����������
� ������; ���������� �������� �� �������������. �������� ��������� ��������
������������������. �������� ������� �������� ������������������.*/

CREATE SEQUENCE s1
  START WITH 1000
  INCREMENT BY 10
  NOMINVALUE
  NOMAXVALUE
  NOCYCLE
  NOCACHE
  NOORDER;
--�������� ��������� �������� ������������������. 
select S1.nextval from dual;
--�������� ������� �������� ������������������.
select S1.currval from dual;



/*4.	�������� ������������������ S2 (SEQUENCE), �� ���������� ����������������: 
��������� �������� 10; ���������� 10; ������������ �������� 100; �� �����������.
�������� ��� �������� ������������������. ����������� �������� ��������,
��������� �� ������������ ��������.*/

create sequence S2
  start with 10
  increment by 10
  maxvalue 100
  nocycle;
--�������� ��� �������� ������������������. 
select S2.nextval from dual;
select S2.currval from dual;



/*5.	�������� ������������������ S3 (SEQUENCE), �� ����������
����������������: ��������� �������� 10; ���������� -10; ����������� 
�������� -100; �� �����������; ������������� ���������� ��������. �������� 
��� �������� ������������������. ����������� �������� ��������, ������ 
������������ ��������.*/

create sequence S3
  start with 10
  increment by -10
  maxvalue 11 
  minvalue -100
  nocycle
  order;
--�������� ��� �������� ������������������. 
select S3.nextval from dual;
select S3.currval from dual;



/*6.	�������� ������������������ S4 (SEQUENCE), �� ���������� ����������������:
��������� �������� 1; ���������� 1; ����������� �������� 10; �����������; ����������
� ������ 5 ��������; ���������� �������� �� �������������. ����������������� ����������� 
��������� �������� ������������������� S4.*/

create sequence S4
  start with 1
  increment by 1
  maxvalue 10
  cycle
  cache 5
  noorder;
--����������������� ����������� ��������� �������� ������������������� S4.
select S4.nextval from dual;
select S4.currval from dual;

/*7.	�������� ������ ���� ������������������� � ������� ���� ������, 
���������� ������� �������� ������������ XXX.*/
select * from user_sequences;


/*8.	�������� ������� T1, ������� ������� N1, N2, N3, N4, ���� NUMBER (20),
���������� � ������������� � �������� ���� KEEP. � ������� ��������� INSERT 
�������� 7 �����, �������� �������� ��� �������� ������ ������������� � 
������� ������������������� S1, S2, S3, S4.*/
create table T1 (
        N1 NUMBER(20),
        N2 NUMBER(20),
        N3 NUMBER(20),
        N4 NUMBER(20)) cache storage(buffer_pool keep);

begin
  for i in 1..7 loop
  insert into T1(N1, N2, N3, N4) values (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
  end loop;
end;
select * from T1;

/*9.	�������� ������� ABC, ������� hash-��� (������ 200) �
���������� 2 ����: X (NUMBER (10)), V (VARCHAR2(12)).*/
create cluster abc ( 
                    x number (10), 
                    v varchar2(12)) 
        hashkeys 200;
        
        
    /*10.	�������� ������� A, ������� ������� XA (NUMBER (10)) � VA (VARCHAR2(12)),
������������� �������� ABC, � ����� ��� ���� ������������ �������.*/
create table A(XA number(10),
               VA varchar2(12), 
               aa number(10))
cluster ABC (XA, VA);
        
        /*11.	�������� ������� B, ������� ������� XB (NUMBER (10)) � VB (VARCHAR2(12)), 
������������� �������� ABC, � ����� ��� ���� ������������ �������.*/
create table B(xb number(10),
               VB varchar2(12), 
               bb number(10))
cluster ABC (XB, VB);

    /*12.	�������� ������� �, ������� ������� X� (NUMBER (10)) � V� (VARCHAR2(12))
, ������������� �������� ABC, � ����� ��� ���� ������������ �������. */
create table c(XC number(10),
               VC varchar2(12), 
               cc number(10))
cluster ABC (XC, VC);


/*13.	������� ��������� ������� � ������� � �������������� ������� Oracle.*/
select * from user_tables;
select * from user_clusters;


/*15.	�������� ��������� ������� ��� ������� XXX.B � ����������������� ��� ����������.*/
create public synonym sb for b;
DROP public synonym sb
select * from sb;

/*16.	�������� ��� ������������ ������� A � B (� ��������� � ������� �������)
, ��������� �� �������, �������� ������������� V1, ���������� �� SELECT... FOR 
A inner join B. ����������������� ��� �����������������.*/
create table A1(x number(10), y varchar(12),constraint x_pk primary key (x));
create table B1(x number(10),y varchar(12), constraint x_fk foreign key (x) references A1(x));

insert into A1 (x, y) values (1,'a');
insert into A1 (x, y) values (2,'b');
insert into A1 (x, y) values (3,'c');
insert into B1 (x, y) values (1,'d');
insert into B1 (x, y) values (2,'e');
insert into B1 (x, y) values (3,'f');

select * from a1;
select * from b1;

create view V1 as select A1.y as ay, B1.y as byf, A1.x from A1 inner join B1 on A1.x=B1.x;
select * from V1;


/*17.	�� ������ ������ A � B �������� ����������������� ������������� MV_XXX,
������� ����� ������������� ���������� 2 ������. ����������������� ��� �����������������.*/

create materialized view MV_IPB
build immediate 
refresh complete on demand next sysdate + numtodsinterval(2, 'minute') 
as select * from A1;

select * from  MV_IPB

insert into a1 (x, y) values (4,'aa');
insert into A1 (x, y) values (5,'bb');