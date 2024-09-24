SELECT  name, COUNT(person_id) AS count_of_visits
FROM person_visits pv
LEFT JOIN person p
ON pv.person_id = p.id
GROUP BY 1
ORDER BY 2 DESC LIMIT 4;