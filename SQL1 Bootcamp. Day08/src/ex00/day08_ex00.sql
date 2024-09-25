-- Сессия 1
BEGIN; -- Начало транзакции

-- Обновление рейтинга пиццерии
UPDATE pizzeria
SET rating = 5
WHERE name = 'Pizza Hut';

-- Проверка обновленного рейтинга в текущей транзакции
SELECT *
FROM pizzeria
WHERE name = 'Pizza Hut';

COMMIT; -- Фиксация изменений

-- Сессия 2
-- Проверка рейтинга до фиксации изменений (перед выполнением COMMIT в Сессии 1)
SELECT *
FROM pizzeria
WHERE name = 'Pizza Hut';

-- Ожидаемый результат до COMMIT:
-- rating = 4.6

-- Проверка рейтинга после фиксации изменений (после выполнения COMMIT в Сессии 1)
SELECT *
FROM pizzeria
WHERE name = 'Pizza Hut';

-- Ожидаемый результат после COMMIT:
-- rating = 5
