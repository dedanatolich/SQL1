SELECT p.name, COUNT(*) AS count_of_orders,
	round(AVG(price), 2) AS average_price, MAX(price) AS max_price,
	MIN(price) AS min_price
FROM person_order po
INNER JOIN menu m
ON m.id = po.menu_id
INNER JOIN pizzeria p
ON p.id = m.pizzeria_id
GROUP BY 1
ORDER BY 1;