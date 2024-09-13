SELECT po.order_date,
       CONCAT(p.name, ' (age: ', p.age, ')') AS person_info
FROM person_order po
JOIN person p ON po.person_id = p.id
ORDER BY po.order_date, person_info;
