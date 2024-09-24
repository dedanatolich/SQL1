WITH t1 AS (
	SELECT name, COUNT(person_id) AS count, 'visit' AS action_type
    FROM person_visits pv
    INNER JOIN pizzeria p
	ON pv.pizzeria_id = p.id
    GROUP BY name
    ORDER BY action_type, count DESC
    LIMIT 3
),
t2 AS (
	SELECT p.name, COUNT(person_id) AS count, 'order' AS action_type
    FROM person_order po
    INNER JOIN menu m
	ON m.id = po.menu_id
    INNER JOIN pizzeria p
	ON m.pizzeria_id = p.id
    GROUP BY name
    ORDER BY action_type, count DESC
    LIMIT 3
)

SELECT *
FROM t1
UNION ALL
SELECT *
FROM t2
ORDER BY action_type, count DESC;