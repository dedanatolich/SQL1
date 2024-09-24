CREATE MATERIALIZED VIEW IF NOT EXISTS mv_dmitriy_visits_and_eats AS
SELECT name AS pizzeria_name
FROM person_visits pv
JOIN pizzeria p ON pv.pizzeria_id = p.id
WHERE person_id = 9 AND visit_date = '2022-01-08'
ORDER BY 1;
