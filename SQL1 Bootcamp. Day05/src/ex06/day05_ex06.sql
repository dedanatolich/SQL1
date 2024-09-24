CREATE UNIQUE INDEX IF NOT EXISTS idx_1 ON pizzeria (rating);

SET enable_seqscan = OFF;
EXPLAIN ANALYSE

SELECT m.pizza_name AS pizza_name, MAX(rating)
OVER (
	PARTITION BY rating
	ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS k
FROM menu m
INNER JOIN pizzeria p ON m.pizzeria_id = p.id
ORDER BY 1, 2;