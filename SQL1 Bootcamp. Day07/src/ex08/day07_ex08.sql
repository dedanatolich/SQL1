SELECT p.address, pz.name, COUNT(*) count_of_orders
FROM person p
INNER JOIN person_order po
ON p.id = po.person_id
INNER JOIN menu m
ON po.menu_id = m.id
INNER JOIN pizzeria pz
ON m.pizzeria_id = pz.id
GROUP BY 1, 2
ORDER BY 1, 2;
