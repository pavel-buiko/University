-- Создание таблицы
CREATE TABLE C##_Table (
    Id Number(3),
    Title varchar2(50),
    Value Number(10)
);

DROP TABLE C##_Table;

INSERT INTO C##_Table (Id, Title, Value) VALUES (1, 'Example 1', 100);
INSERT INTO C##_Table (Id, Title, Value) VALUES (2, 'Example 2', 200);
INSERT INTO C##_Table (Id, Title, Value) VALUES (3, 'Example 3', 300);

select * from C##_Table


-- Проверка объектов, принадлежащих пользователю C##BPI
SELECT owner, object_name, object_type
FROM all_objects 
WHERE owner = 'C##IPB';


Классификация словарей

показать действия общ пользователя в CDB

Название этапов startup и shutdown
