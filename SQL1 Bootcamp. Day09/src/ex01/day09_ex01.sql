-- creating the auditor function
CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER AS 
$fnc_trg_person_update_audit$
BEGIN
    INSERT INTO person_audit
        (type_event, row_id, name, age, gender, address)
    VALUES 
        ('U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
    RETURN OLD;
END;
$fnc_trg_person_update_audit$ LANGUAGE plpgsql;

-- create the trigger
CREATE TRIGGER trg_person_update_audit
AFTER UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_update_audit();

-- update some values
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

-- check that the function worked correctly
SELECT * FROM person_audit;