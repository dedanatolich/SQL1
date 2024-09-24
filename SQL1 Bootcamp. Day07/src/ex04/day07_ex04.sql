SELECT name, COUNT(person_id) AS count_of_visits
FROM person_visits pv
INNER JOIN person p
ON p.id = pv.person_id
GROUP BY 1 HAVING COUNT(person_id) > 3;