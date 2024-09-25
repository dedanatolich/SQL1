-- creating the auditor function
CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit()
RETURNS TRIGGER AS
$func$
BEGIN
    INSERT INTO person_audit 
        (type_event, row_id, name, age, gender, address)
    VALUES
        ('D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
    RETURN OLD;
END;
$func$ LANGUAGE plpgsql;

-- create the trigger
CREATE TRIGGER trg_person_delete_audit
BEFORE DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_delete_audit();

-- delete a row
DELETE FROM person WHERE id = 10;

-- check that the function worked correctly
SELECT * FROM person_audit;