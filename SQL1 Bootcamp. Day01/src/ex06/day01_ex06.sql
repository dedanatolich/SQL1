SELECT po.order_date AS action_date, p.name AS person_name
FROM person_order po
JOIN person p ON po.person_id = p.id
WHERE (po.order_date, po.person_id) IN 
    (SELECT visit_date, person_id
     FROM person_visits)
ORDER BY po.order_date, p.name DESC;
