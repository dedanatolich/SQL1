WITH pv_max AS (
    SELECT MAX(id) + 1
    FROM person_visits
),
dmitriy AS (
    SELECT id
    FROM person
    WHERE name = 'Dmitriy'
),
dmitriy_visits AS (
    SELECT pizzeria.id
    FROM person_visits
    JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    JOIN dmitriy ON person_visits.person_id = dmitriy.id 
    WHERE visit_date = '2022-01-08'
),
cheap_pizzeria AS (
    SELECT pizzeria.id
    FROM pizzeria
    JOIN menu ON pizzeria.id = menu.pizzeria_id
    WHERE price < 800
    AND pizzeria.id NOT IN (SELECT id FROM dmitriy_visits)
    LIMIT 1
)

INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT
    (SELECT * FROM pv_max),
    (SELECT * FROM dmitriy),
    (SELECT * FROM cheap_pizzeria),
    '2022-01-08'
WHERE EXISTS (SELECT * FROM cheap_pizzeria);

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;

SELECT * FROM mv_dmitriy_visits_and_eats;
