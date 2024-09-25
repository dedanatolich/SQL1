-- creating function
CREATE OR REPLACE FUNCTION func_minimum (VARIADIC arr NUMERIC[])
RETURNS NUMERIC
AS $BODY$
BEGIN
    RETURN (SELECT MIN(in_put) FROM unnest(arr) AS in_put);
END;
$BODY$ LANGUAGE plpgsql;

-- check that the function works
SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
-- or
SELECT func_minimum(VARIADIC ARRAY[10.0, -1.0, 5.0, 4.4]);