WITH visits AS
(SELECT * FROM person_visits
	WHERE (person_id = 1 OR person_id = 2)
	AND visit_date BETWEEN '2022-01-01' AND '2022-01-10')
SELECT CAST(list AS DATE) AS missing_date
	FROM generate_series('2022-01-01', '2022-01-10', interval '1 day') list
LEFT JOIN visits
ON list = visits.visit_date
WHERE visits.visit_date IS NULL
ORDER BY missing_date ASC;