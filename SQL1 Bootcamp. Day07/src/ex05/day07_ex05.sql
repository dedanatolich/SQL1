SELECT DISTINCT name
FROM person p
WHERE p.id IN (
	SELECT id
	FROM person_order
)
ORDER BY 1;
