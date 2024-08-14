---1. ������������ ���������� ��������� ���� PL/SQL (��), �� ���������� ����������-------------------------

begin
  null;
end;

SET SERVEROUTPUT ON;
--2. ������������ ��, ��������� �Hello World!�. --------------------------
begin
  dbms_output.put_line('Hello world');
end;

---------------3. ������������ ������, ����������� ����������� ��� ����������� PL/SQL.-----------------

select * from v$reserved_words where length = 1;  ---???and keyword != 'A'

----------------4. ������������ ������, ����������� ����������� ��� �������� ����� PL/SQL.---------------
select keyword from v$reserved_words where length > 1 order by keyword;

-----------------������������ ��������� ����, ��������������� -----------------
DECLARE
  -- ���������� � ������������� ����� number-����������
  num1 NUMBER := 4;
  num2 NUMBER := 10;
  num3 NUMBER;
  num4 NUMBER;
  
  -- ���������� � ������������� number-���������� � ������������� ������
  num_fixed_point NUMBER(5, 2) := 123.45;
  
  -- ���������� � ������������� number-���������� � ������������� ������ � ������������� ��������� (����������)
  num_fixed_negative_scale NUMBER(5, -2) := 12345; --�� ����� ����������
  
  -- ���������� number-���������� � ������ � ����������� ������� E (������� 10) ��� �������������/����������
  num_with_exponent NUMBER := 1.23E4;
  
  -- ���������� � ������������� ���������� ���� ����
  date_var1 DATE := SYSDATE;
  date_var2 DATE := TO_DATE('2024-05-29', 'YYYY-MM-DD');
  
  -- ���������� � ������������� ���������� ���������� ��������� ���������
  char_var CHAR(10) := 'Hello !';
  varchar_var VARCHAR2(50) := 'This is a VARCHAR2 variable';
  long_var LONG := 'This is a LONG variable';
  
  -- ���������� � ������������� BOOLEAN-����������
  bool_var BOOLEAN := TRUE;

BEGIN
  -- �������������� �������� ��� ����� ������ number-�����������, ������� ������� � ��������
  num3 := num1 + num2;
  num4 := num2 - num1;
  
  DBMS_OUTPUT.PUT_LINE('num1: ' || num1);
  DBMS_OUTPUT.PUT_LINE('num2: ' || num2);
  DBMS_OUTPUT.PUT_LINE('num3: ' || num3);
  DBMS_OUTPUT.PUT_LINE('num4: ' || num4);
  DBMS_OUTPUT.PUT_LINE('num1 + num2: ' || num3);
  DBMS_OUTPUT.PUT_LINE('num2 - num1: ' || num4);
  
  -- ��������� � �������
  DBMS_OUTPUT.PUT_LINE('num1 * num2: ' || (num1 * num2));
  DBMS_OUTPUT.PUT_LINE('num2 / num1: ' || (num2 / num1));
  
  -- ������� � ��������
  DBMS_OUTPUT.PUT_LINE('num2 MOD num1: ' || (num2 MOD num1));
  
  -- ����� number-���������� � ������������� ������
  DBMS_OUTPUT.PUT_LINE('num_fixed_point: ' || num_fixed_point);
  
  -- ����� number-���������� � ������������� ������ � ������������� ���������
  DBMS_OUTPUT.PUT_LINE('num_fixed_negative_scale: ' || num_fixed_negative_scale);
  
  -- ����� number-���������� � ������ � �������� E (������� 10)
  DBMS_OUTPUT.PUT_LINE('num_with_exponent: ' || num_with_exponent);
  
  -- ����� ���������� ���� ����
  DBMS_OUTPUT.PUT_LINE('date_var1: ' || TO_CHAR(date_var1, 'YYYY-MM-DD HH24:MI:SS'));
  DBMS_OUTPUT.PUT_LINE('date_var2: ' || TO_CHAR(date_var2, 'YYYY-MM-DD'));
  
  -- ����� ���������� ����������
  DBMS_OUTPUT.PUT_LINE('char_var: ' || char_var);
  DBMS_OUTPUT.PUT_LINE('varchar_var: ' || varchar_var);
  DBMS_OUTPUT.PUT_LINE('long_var: ' || long_var);
  
  -- ����� BOOLEAN-����������
  IF bool_var THEN
    DBMS_OUTPUT.PUT_LINE('bool_var is TRUE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('bool_var is FALSE');
  END IF;
END;


--------6. ������������ ��������� ���� PL/SQL ���������� ���������� �������� (VARCHAR2, CHAR, NUMBER). �����������������  ��������� �������� � �����������.-------

DECLARE 
V_CONST_VAR CONSTANT VARCHAR2(10):='My Name';
V_CONST_NUM CONSTANT NUMBER(5):=20;
V_CONST_CHAR CONSTANT CHAR(5):='Pavel';
V_CONST_PI CONSTANT NUMBER := 3.14;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Concatenation of V_CONST_VAR and V_CONST_CHAR: ' || V_CONST_VAR || ' ' || V_CONST_CHAR);
    DBMS_OUTPUT.PUT_LINE('Substring of V_CONST_VAR: ' || SUBSTR(V_CONST_VAR, 1, 4));
    DBMS_OUTPUT.PUT_LINE('Length of V_CONST_CHAR: ' || LENGTH(V_CONST_CHAR));
    dbms_output.put_line('Constant V_CONST_VAR = '|| V_CONST_VAR);
    dbms_output.put_line('Constant V_CONST_VAR || V_CONST_VAR = '||(V_CONST_VAR || V_CONST_VAR)); 
    dbms_output.put_line('Constant V_CONST_NUM = '|| V_CONST_NUM);
    dbms_output.put_line('Constant V_CONST_CHAR = '|| V_CONST_CHAR);
   
   
    -- �������� � ����������� ���� NUMBER
    DBMS_OUTPUT.PUT_LINE('V_CONST_NUM + V_CONST_PI: ' || (V_CONST_NUM + V_CONST_PI));
    DBMS_OUTPUT.PUT_LINE('V_CONST_NUM * V_CONST_PI: ' || (V_CONST_NUM * V_CONST_PI));
    DBMS_OUTPUT.PUT_LINE('V_CONST_NUM / V_CONST_PI: ' || (V_CONST_NUM / V_CONST_PI));
    DBMS_OUTPUT.PUT_LINE('Remainder of c_number divided by 3: ' || MOD(V_CONST_NUM, 3));
END;
--------7. ������������ ��, ���������� ���������� ���������� � ������ %TYPE. ����������������� �������� �����.-----------

DECLARE
    example  AUDITORIUM%ROWTYPE;
    example2 AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;

BEGIN
    example2 := 100;
    SELECT * INTO example FROM AUDITORIUM WHERE AUDITORIUM_NAME = '429-4'; 
    DBMS_OUTPUT.PUT_LINE('AUDIT NAME: ' || example.AUDITORIUM_NAME || ' AUDIT CAPACITY '
        || example2);
END;



--9. ������������ ��, ��������������� ��� ��������� ����������� ��������� IF .---
DECLARE 
    v_num1 NUMBER := 10;
    v_num2 NUMBER := 20;
    v_str1 VARCHAR2(10) := 'abc';
    v_str2 VARCHAR2(10) := 'xyz';
    v_bool BOOLEAN := TRUE;
BEGIN
    IF v_num1 > v_num2 THEN
        dbms_output.put_line('v_num1 is greater than v_num2');
    ELSE
        dbms_output.put_line('v_num1 is less than or equal to v_num2');
    END IF;

    IF v_num1 > v_num2 THEN
        dbms_output.put_line('v_num1 is greater than v_num2');
    ELSIF v_num1 = v_num2 THEN
        dbms_output.put_line('v_num1 is equal to v_num2');
    ELSE
        dbms_output.put_line('v_num1 is less than v_num2');
    END IF;



    IF v_num1 = 10 AND v_str1 = 'abc' THEN
        dbms_output.put_line('v_num1 is 10 AND v_str1 is abc');
    ELSE
        dbms_output.put_line('v_num1 is not 10 OR v_str1 is not abc');
    END IF;

    IF v_num1 = 10 OR v_str1 = 'xyz' THEN
        dbms_output.put_line('v_num1 is 10 OR v_str1 is xyz');
    ELSE
        dbms_output.put_line('v_num1 is not 10 AND v_str1 is not xyz');
    END IF;
END;




---10. ������������ ��, ��������������� ������ ��������� CASE.----
DECLARE
  v_day VARCHAR2(10) := 'Sunday';
BEGIN
  CASE v_day
    WHEN 'Monday' THEN
      dbms_output.put_line('It is Monday');
    WHEN 'Tuesday' THEN
      dbms_output.put_line('It is Tuesday');
    WHEN 'Wednesday' THEN
      dbms_output.put_line('It is Wednesday');
    WHEN 'Thursday' THEN
      dbms_output.put_line('It is Thursday');
    WHEN 'Friday' THEN
      dbms_output.put_line('It is Friday');
    WHEN 'Saturday' THEN
      dbms_output.put_line('It is Saturday');
    WHEN 'Sunday' THEN
      dbms_output.put_line('It is Sunday');
    ELSE
      dbms_output.put_line('Invalid day');
  END CASE;
END;

--11. ������������ ��, ��������������� ������ ��������� LOOP.--
--12. ������������ ��, ��������������� ������ ��������� WHILE.--
DECLARE
   i NUMBER := 1;
BEGIN
   WHILE i <= 10 LOOP
      dbms_output.put_line(i);
      i := i + 1;
   END LOOP;
END;

--13. ������������ ��, ��������������� ������ ��������� FOR.-----
DECLARE
   i NUMBER;
BEGIN
   FOR i IN 1..10 LOOP
      dbms_output.put_line('i ='  || i);
   END LOOP;
END;


SELECT name, value FROM V$PARAMETER WHERE name LIKE '%plsql%';