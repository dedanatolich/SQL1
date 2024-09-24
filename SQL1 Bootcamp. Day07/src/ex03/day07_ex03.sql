with visits_and_ordres AS (
    (
		SELECT name, COUNT(person_id) AS count, 'visit' AS action_type
		FROM person_visits pv
		JOIN pizzeria p
		ON p.id = pizzeria_id
		GROUP BY name
    	ORDER BY count DESC
	)
	UNION
	(
		SELECT name, COUNT(person_id) AS count, 'order' AS action_type
		FROM person_order po
		JOIN menu m
		ON m.id = menu_id
		JOIN pizzeria p
		ON p.id = pizzeria_id
		GROUP BY name
	   	ORDER BY count DESC
	)
	ORDER BY action_type, count DESC
)

SELECT name, sum(count) total_count
FROM visits_and_ordres
GROUP BY name
ORDER BY 2 DESC;