WITH male AS (SELECT p.name
	FROM pizzeria p
	JOIN person_visits AS visit ON p.id = visit.pizzeria_id
	JOIN person pe ON pe.id = visit.person_id
	WHERE gender = 'male'
),
female AS (SELECT p.name
	FROM pizzeria p
	JOIN person_visits AS visit ON p.id = visit.pizzeria_id
	JOIN person pe ON pe.id = visit.person_id
	WHERE gender = 'female'
),
only_male AS (SELECT name
	FROM male
	EXCEPT ALL
	SELECT name
	FROM female
),
only_female AS (SELECT name
	FROM female
	EXCEPT ALL
	SELECT name
	FROM male
)
SELECT name AS pizzeria_name
FROM only_male
UNION ALL
SELECT name
FROM only_female
ORDER BY 1;