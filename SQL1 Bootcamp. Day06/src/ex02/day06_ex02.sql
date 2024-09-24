SELECT p.name AS name, pizza_name, price, (m.price / 100 * (100 - pd.discount))
	AS discount_price, p.name AS pizzeria_name
FROM person p
JOIN person_order po
ON po.person_id = p.id
JOIN menu m
ON m.id = po.menu_id
JOIN person_discounts pd
ON pd.person_id = po.person_id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1, 2;