SELECT 
    (SELECT name 
     FROM person 
     WHERE person.id = po.person_id) AS NAME,
	CASE 
        WHEN (SELECT name 
              FROM person 
              WHERE person.id = po.person_id) = 'Denis' THEN true
        ELSE false
    END AS check_name
FROM person_order po
WHERE po.menu_id IN (13, 14, 18) 
  AND po.order_date = '2022-01-07';
