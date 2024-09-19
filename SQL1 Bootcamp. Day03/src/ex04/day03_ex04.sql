WITH male AS (SELECT p.name
	FROM pizzeria p
	JOIN menu m ON p.id = m.pizzeria_id
	JOIN person_order AS porder ON m.id = porder.menu_id
	JOIN person pe ON pe.id = porder.person_id
	WHERE gender = 'male'
),
female AS (SELECT p.name
	FROM pizzeria p
	JOIN menu m ON p.id = m.pizzeria_id
	JOIN person_order AS porder ON m.id = porder.menu_id
	JOIN person pe on pe.id = porder.person_id
	WHERE gender = 'female'
),
only_male AS (SELECT name
	FROM male
	EXCEPT
	SELECT name
	FROM female
),
only_female AS (SELECT name
	FROM female
	EXCEPT
	SELECT name
	FROM male
)
SELECT name AS pizzeria_name
FROM only_male
UNION
SELECT name
FROM only_female
ORDER BY 1;