-- creating function
CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
        pperson VARCHAR DEFAULT 'Dmitriy', 
        pprice NUMERIC(5,2) DEFAULT 500,
        pdate DATE DEFAULT '2022-01-08')
RETURNS TABLE (pizzeria VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT pz.name FROM person_visits pv
        JOIN pizzeria pz ON pv.pizzeria_id=pz.id
        JOIN person pr ON pv.person_id=pr.id
        JOIN menu m ON pz.id=m.pizzeria_id
    WHERE pr.name=pperson 
        AND m.price<pprice
        AND pv.visit_date=pdate;
END;
$$;

-- to see function's output (there are different ways to put parameters into function)
-- #1
select *
from fnc_person_visits_and_eats_on_date(pprice := 800);
-- #2
select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');

-- let's check it with just querys
-- #1
SELECT DISTINCT pz.name FROM person_visits pv
    JOIN pizzeria pz ON pv.pizzeria_id=pz.id
    JOIN person pr ON pv.person_id=pr.id
    JOIN menu m ON pz.id=m.pizzeria_id
WHERE pr.name='Dmitriy' 
    AND m.price<800
    AND pv.visit_date='2022-01-08';
-- #2
SELECT DISTINCT pz.name FROM person_visits pv
    JOIN pizzeria pz ON pv.pizzeria_id=pz.id
    JOIN person pr ON pv.person_id=pr.id
    JOIN menu m ON pz.id=m.pizzeria_id
WHERE pr.name='Anna' 
    AND m.price<1300
    AND pv.visit_date='2022-01-01';

-- Extra: another way to input into the function 
-- #2
select * from fnc_person_visits_and_eats_on_date('Anna',1300,'2022-01-01');
