WITH andery_visit AS (
	SELECT p.name AS pizzeria_name
    FROM person_visits
    JOIN pizzeria p ON p.id = person_visits.pizzeria_id
    WHERE person_visits.person_id = 2
),
andrey_order AS (
	SELECT p.name AS pizzeria_name
    FROM person_order po
    JOIN menu m ON m.id = po.menu_id
    JOIN pizzeria p ON p.id = m.pizzeria_id
    WHERE po.person_id = 2
)
SELECT  pizzeria_name
FROM andery_visit
EXCEPT
SELECT pizzeria_name
FROM andrey_order
ORDER BY 1;