SELECT pizza_name
FROM menu
WHERE id = (SELECT MIN(id)
			FROM menu m
			WHERE m.pizza_name = menu.pizza_name)
ORDER BY pizza_name DESC;