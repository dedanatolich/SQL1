-- removing functions 
DROP FUNCTION IF EXISTS fnc_persons_female, fnc_persons_male;

-- creating function
CREATE OR REPLACE FUNCTION fnc_persons (pgender VARCHAR DEFAULT 'female')
RETURNS TABLE (id INTEGER, name VARCHAR, age INTEGER, gender VARCHAR, address VARCHAR)
LANGUAGE SQL
AS $$
    SELECT *
    FROM person
    WHERE gender=pgender;
$$;

-- to see function's ouitput (there are different ways to put parameters into function)
select * from fnc_persons('male');
select * from fnc_persons(pgender := 'male');
select * from fnc_persons();

