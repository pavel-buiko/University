CREATE USER C##UserFourteen IDENTIFIED BY 1111;

GRANT ALL PRIVILEGES ON example_table TO C##UserFourteen;

GRANT ALL PRIVILEGES TO C##UserFourteen;

--1. �������� �������, ������� ��������� ���������, ���� �� ������� ��������� ����.

CREATE TABLE employee (
    employee_id NUMBER(10) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL
);


DROP TABLE employee;
DROP TRIGGER PREVENT_DROP_TABLE;
  
--2. ��������� ������� ������� (10 ��.).
INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (1, 'John', 'Doe', 'john.doe@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (3, 'Michael', 'Johnson', 'michael.johnson@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (4, 'Emily', 'Davis', 'emily.davis@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (5, 'David', 'Wilson', 'david.wilson@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (6, 'Sarah', 'Taylor', 'sarah.taylor@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (7, 'Robert', 'Anderson', 'robert.anderson@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (8, 'Jessica', 'Martinez', 'jessica.martinez@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (9, 'Christopher', 'Hernandez', 'christopher.hernandez@example.com');

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (10, 'Olivia', 'Gonzalez', 'olivia.gonzalez@example.com');


SELECT * FROM employee;
--3. �������� BEFORE � ������� ������ ��������� �� ������� INSERT, DELETE � UPDATE. ���� � ��� ����������� �������� ������ �������� ��������� �� ��������� ������� (DMS_OUTPUT) �� ����� ����������� ������. 
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER trg_employees_AUDIT_
BEFORE INSERT OR DELETE OR UPDATE ON employee
DECLARE
  v_operation VARCHAR2(10);
BEGIN
  CASE
    WHEN INSERTING THEN
      v_operation := 'INSERT';
    WHEN DELETING THEN
      v_operation := 'DELETE';
    WHEN UPDATING THEN
      v_operation := 'UPDATE';
  END CASE;

  DBMS_OUTPUT.PUT_LINE('Triggered: ' || v_operation || ' on employees table');
END;

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (11, 'Sanya', 'Mironov', 'sasha@example.com');

UPDATE employee
SET first_name = 'Sanya'
WHERE employee_id = 11;

DELETE FROM employee
WHERE employee_id = 11;


--4. �������� BEFORE-������� ������ ������ �� ������� INSERT, DELETE � UPDATE
CREATE OR REPLACE TRIGGER trg_employees_AUDIT_row
BEFORE INSERT OR DELETE OR UPDATE ON employee
FOR EACH ROW
DECLARE
  v_operation VARCHAR2(10);
BEGIN
  CASE
    WHEN INSERTING THEN
      v_operation := 'INSERT';
    WHEN DELETING THEN
      v_operation := 'DELETE';
    WHEN UPDATING THEN
      v_operation := 'UPDATE';
  END CASE;

  DBMS_OUTPUT.PUT_LINE('Raw trigger: ' || v_operation || ' on employees table, employee_id = ' || :NEW.employee_id);
END;

--5. ��������� ��������� INSERTING, UPDATING � DELETING.
CREATE OR REPLACE TRIGGER predicate_employees_AUDIT_row
BEFORE INSERT OR DELETE OR UPDATE ON employee
BEGIN
IF INSERTING THEN DBMS_OUTPUT.PUT_LINE('INSERTING TABLE');
ELSIF UPDATING THEN DBMS_OUTPUT.PUT_LINE('UPDATING TABLE');
ELSIF DELETING THEN DBMS_OUTPUT.PUT_LINE('DELETING TABLE');  
     END IF;
END;
  
--6. ������������ AFTER-�������� ������ ��������� �� ������� INSERT, DELETE � UPDATE.

CREATE OR REPLACE TRIGGER TRIGGER_AFTER
AFTER INSERT OR UPDATE OR DELETE ON employee
BEGIN
     IF INSERTING THEN DBMS_OUTPUT.PUT_LINE('DATA INSERTED');
     ELSIF UPDATING THEN DBMS_OUTPUT.PUT_LINE('DATA UPDATED');
     ELSIF DELETING THEN DBMS_OUTPUT.PUT_LINE('DATA DELETED');        
     END IF;
END;

--7. ������������ AFTER-�������� ������ ������ �� ������� INSERT, DELETE � UPDATE.
CREATE OR REPLACE TRIGGER trg_employee_after_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('New employee added: ' || :NEW.employee_id);
END;

-- AFTER UPDATE trigger
CREATE OR REPLACE TRIGGER trg_employee_after_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employee ' || :OLD.employee_id || ' updated');
END;

-- AFTER DELETE trigger 
CREATE OR REPLACE TRIGGER trg_employee_after_delete
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employee ' || :OLD.employee_id || ' deleted');
END;

--8. �������� ������� � ������ AUDIT_. ������� ������ ��������� ����:
--OperationDate, OperationType (�������� �������, ���������� � ��������), TriggerName(��� ��������), Data (������ �� ���������� ����� �� � ����� ��������).
    create table AUDIT_
    (
        OPERATIONDATE timestamp, 
        OPERATIONTYPE varchar2(50), 
        TRIGGERNAME varchar2(30),
        DATA varchar2(300)   
    );
    
    SELECT * FROM AUDIT_
--9. �������� ��� �������� ����� �������, ����� ��� �������������� ��� �������� � �������� �������� � ������� AUDIT.
CREATE OR REPLACE TRIGGER before_insert_employee
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
  INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
  VALUES (
    SYSTIMESTAMP, 
    'INSERT', 
    'before_insert_employee', 
    'employee_id: ' || :NEW.employee_id || ', first_name: ' || :NEW.first_name || ', last_name: ' || :NEW.last_name || ', email: ' || :NEW.email
  );
END;



CREATE OR REPLACE TRIGGER before_update_employee
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
  INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
  VALUES (
    SYSTIMESTAMP, 
    'UPDATE', 
    'before_update_employee', 
    'OLD - employee_id: ' || :OLD.employee_id || ', first_name: ' || :OLD.first_name || ', last_name: ' || :OLD.last_name || ', email: ' || :OLD.email ||
    ' -> NEW - employee_id: ' || :NEW.employee_id || ', first_name: ' || :NEW.first_name || ', last_name: ' || :NEW.last_name || ', email: ' || :NEW.email
  );
END;

CREATE OR REPLACE TRIGGER before_delete_employee
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
  INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
  VALUES (
    SYSTIMESTAMP, 
    'DELETE', 
    'before_delete_employee', 
    'employee_id: ' || :OLD.employee_id || ', first_name: ' || :OLD.first_name || ', last_name: ' || :OLD.last_name || ', email: ' || :OLD.email
  );
END;



--10. ��������� ��������, ���������� ����������� ������� �� ���������� �����. ��������, ��������������� �� ������� ��� �������. ��������� ���������
--����������� �� �������, ������� ������ �� ���������
INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (14, 'John', Null, 'john.doe@example.com');

SELECT * FROM AUDIT_

--11. ������� (drop) �������� �������. ��������� ���������. �������� �������, ����������� �������� �������� �������.
CREATE OR REPLACE TRIGGER prevent_drop_table
BEFORE DROP ON DATABASE
DECLARE
  v_object_name VARCHAR2(30);
BEGIN
  -- �������� ��� �������, ������� �������� �������
  v_object_name := ORA_DICT_OBJ_NAME;

  -- ���������, �������� �� ������ �������� � ����� �� �� ��� EMPLOYEE
  IF ORA_DICT_OBJ_TYPE = 'TABLE' AND v_object_name = 'EMPLOYEE' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Table EMPLOYEE cannot be dropped');
  END IF;
END;



  drop table employee;
  SELECT object_type, object_name
  FROM user_objects
  WHERE object_name = 'EMPLOYEE';
  --12
  
  drop table AUDIT_;
  
  
  --13. �������� ������������� ��� �������� ��������.
  --������������ INSTEAD OF UPDATE-�������.
  --������� ������ ��������� ����� ������ � �������, � ������ �������� ��� ����������������.
  
  CREATE VIEW employee_view AS
    SELECT employee_id, first_name, last_name, email
    FROM employee
    WHERE first_name NOT LIKE '�����_%';

CREATE OR REPLACE TRIGGER instead_of_update_employee
INSTEAD OF UPDATE ON employee_view
FOR EACH ROW
DECLARE
    new_employee_id NUMBER(10);
BEGIN
    -- ���������� ����� employee_id
    SELECT MAX(employee_id) + 1 INTO new_employee_id FROM employee;

    -- �������� ������ ������ ��� "�����_"
    UPDATE employee
    SET first_name = '�����_' || :OLD.first_name
    WHERE employee_id = :OLD.employee_id;

    -- ��������� ����� ������ � ������ ������� � ����� employee_id
    INSERT INTO employee (employee_id, first_name, last_name, email)
    VALUES (new_employee_id, :NEW.first_name, :NEW.last_name, :NEW.email);
END;

    
    SELECT * FROM employee_view


UPDATE employee_view
SET first_name = 'Johnny', last_name = 'Doi', email = 'john.doe@example.com'
WHERE employee_id = 1;

SELECT * FROM EMPLOYEE;
    
--15. �������� ��������� ��������� ������ ����, ����������� �� ���� � �� �� �������, � ��������, � ����� ������� ��� �����������. �������� ������� ���������� ���� ���������.

CREATE OR REPLACE TRIGGER log_insert_trigger1
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger 1: Before Insert');
END;

CREATE OR REPLACE TRIGGER log_insert_trigger3
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger 3: Before Insert');
END;

CREATE OR REPLACE TRIGGER log_insert_trigger2
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger 2: Before Insert');
END;




DROP TRIGGER log_insert_trigger1;
DROP TRIGGER log_insert_trigger2;
DROP TRIGGER log_insert_trigger3;


CREATE OR REPLACE TRIGGER log_insert_trigger1
BEFORE INSERT ON employee
FOR EACH ROW
FOLLOWS log_insert_trigger2, log_insert_trigger3
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger 1: Before Insert');
END;



CREATE OR REPLACE TRIGGER log_insert_trigger2
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger 2: Before Insert');
END;


CREATE OR REPLACE TRIGGER log_insert_trigger3
BEFORE INSERT ON employee
FOR EACH ROW
FOLLOWS log_insert_trigger2
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger 3: Before Insert');
END;




SET SERVEROUTPUT ON;

SELECT * FROM EMPLOYEE;

INSERT INTO employee (employee_id, first_name, last_name, email)
VALUES (88, 'John', 'Smith', 'example@gmail.com');
--3
--2
--1
