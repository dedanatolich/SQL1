SELECT pizza_name, price, p.name AS pizzeria_name
FROM menu
LEFT JOIN pizzeria p ON menu.pizzeria_id = p.id
WHERE menu.id NOT IN (
	SELECT menu_id
	FROM person_order
)
ORDER BY 1, 2;