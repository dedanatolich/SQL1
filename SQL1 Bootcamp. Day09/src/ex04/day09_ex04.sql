-- creating finction #1
CREATE OR REPLACE FUNCTION fnc_persons_female()
RETURNS TABLE(id INTEGER, name VARCHAR, age INTEGER, gender VARCHAR, address VARCHAR)
AS $$
    SELECT id, name, age, gender, address
    FROM person
    WHERE gender='female';
$$ LANGUAGE SQL;
-- creating finction #2
CREATE OR REPLACE FUNCTION fnc_persons_male()
RETURNS TABLE(id INTEGER, name VARCHAR, age INTEGER, gender VARCHAR, address VARCHAR)
LANGUAGE SQL
AS $$
    SELECT *
    FROM person
    WHERE gender='male';
$$;

-- to see functions' ouitput (can work with functions like with tables)
SELECT * FROM fnc_persons_female();
SELECT * FROM fnc_persons_male();

-- to see the views' output
SELECT * FROM v_persons_female;
SELECT * FROM v_persons_male;