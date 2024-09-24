DROP TABLE IF EXISTS nodes;

CREATE TABLE nodes (
  node_id bigint PRIMARY KEY,
  point_1 VARCHAR(1) NOT NULL,
  point_2 VARCHAR(1) NOT NULL,
  cost INTEGER NOT NULL
); 

INSERT INTO nodes VALUES (1, 'a', 'b', 10);
INSERT INTO nodes VALUES (2, 'b', 'a', 10);
INSERT INTO nodes VALUES (3, 'a', 'c', 15);
INSERT INTO nodes VALUES (4, 'c', 'a', 15);
INSERT INTO nodes VALUES (5, 'a', 'd', 20);
INSERT INTO nodes VALUES (6, 'd', 'a', 20);
INSERT INTO nodes VALUES (7, 'b', 'c', 35);
INSERT INTO nodes VALUES (8, 'c', 'b', 35);
INSERT INTO nodes VALUES (9, 'b', 'd', 25);
INSERT INTO nodes VALUES (10, 'd', 'b', 25);
INSERT INTO nodes VALUES (11, 'c', 'd', 30);
INSERT INTO nodes VALUES (12, 'd', 'c', 30);

WITH RECURSIVE tmp AS (
	SELECT 'a' AS start, nodes.point_1 AS current, 0 AS sum_cost, 1 AS count
	FROM nodes
	WHERE point_1 = 'a'

	UNION

	SELECT tmp.start || ',' || nodes.point_2, nodes.point_2,
		tmp.sum_cost + nodes.cost, count + 1 
	FROM nodes n, tmp
	WHERE tmp.current = n.point_1 AND count < 4 AND tmp.start NOT LIKE '%' ||
		n.point_2 || '%'
)

SELECT sum_cost + nodes.cost AS total_cost, '{' || tmp.start || ',a' || '}' AS
	tour
FROM tmp
JOIN nodes n ON n.point_1 = tmp.current AND n.point_2 = 'a'
WHERE tmp.count = 4
ORDER BY 1,2;