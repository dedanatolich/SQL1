CREATE INDEX IF NOT EXISTS idx_person_name ON person (UPPER(name));

SET enable_seqscan = OFF;
EXPLAIN ANALYSE

SELECT *
FROM person
WHERE (UPPER(name)) IS NOT NULL;