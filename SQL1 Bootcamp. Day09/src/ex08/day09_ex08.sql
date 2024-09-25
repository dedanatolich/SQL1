-- creating function
CREATE OR REPLACE FUNCTION fnc_fibonacci (pstop INTEGER DEFAULT 10 )
RETURNS TABLE(fibonacci_numbers INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE list AS(
    SELECT 0::INTEGER AS num1, 1::INTEGER AS num2
    UNION ALL
    SELECT l.num2, (l.num1+l.num2) FROM list l
    WHERE l.num2 < pstop
    )
    SELECT num1  FROM list;
END;
$$;

-- check that the function works
select * from fnc_fibonacci(100);
select * from fnc_fibonacci();


-- FIBONACCI LIST
-- 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144,..