SELECT DISTINCT pizza_name, pizzeria_name_1, pizzeria_name_2, table1.price
FROM (
	SELECT DISTINCT p.id AS id1,
		p.name AS pizzeria_name_1,
		m.pizza_name AS pizza_name,
		price
	FROM menu m
	JOIN pizzeria p ON p.id = m.pizzeria_id
) AS table1
JOIN (
	SELECT p.id AS id2,
		p.name AS pizzeria_name_2,
		m.pizza_name AS pizza_name_2,
		price
	FROM menu m
	JOIN pizzeria p ON p.id = m.pizzeria_id
) AS table2
ON table1.price = table2.price AND table1.pizza_name = table2.pizza_name_2
WHERE id1> id2;