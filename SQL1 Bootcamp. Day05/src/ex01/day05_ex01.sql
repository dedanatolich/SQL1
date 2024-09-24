SET enable_indexscan = ON;
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT pizza_name, name AS pizzeria_name
FROM menu m
LEFT JOIN pizzeria p ON m.pizzeria_id = p.id;
