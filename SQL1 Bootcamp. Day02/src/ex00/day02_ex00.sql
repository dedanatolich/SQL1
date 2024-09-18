SELECT name
FROM pizzeria p
LEFT JOIN
	person_visits on p.id = pizzeria_id
WHERE pizzeria_id is NULL;