BEGIN; --Начало --Session1;
SELECT *
FROM pizzeria
WHERE name  = 'Pizza Hut'; --Session1;
UPDATE pizzeria
SET rating = 4
WHERE name = 'Pizza Hut'; -- Измениенеие таблицы --Session1;
COMMIT; -- Установка изменений --Session1;
SELECT *
FROM pizzeria
WHERE name  = 'Pizza Hut'; --Session1;

BEGIN; --Session2;
SELECT *
FROM pizzeria
WHERE name  = 'Pizza Hut'; --Session2;
UPDATE pizzeria
SET rating = 3.6
WHERE name = 'Pizza Hut';
UPDATE pizzeria
SET rating = 3.6
WHERE name = 'Pizza Hut'; --Session2;
COMMIT; --Session2;
SELECT *
FROM pizzeria
WHERE name  = 'Pizza Hut'; --Session2;