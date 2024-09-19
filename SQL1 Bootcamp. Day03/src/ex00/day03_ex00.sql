SELECT pizza_name, price, p.name AS pizzeria_name, visit_date 
FROM menu m
JOIN pizzeria p ON p.id = m.pizzeria_id
JOIN person_visits
ON person_visits.pizzeria_id = m.pizzeria_id AND person_visits.person_id = 3
WHERE price >= 800 AND price < 1000
ORDER BY 1,2,3;