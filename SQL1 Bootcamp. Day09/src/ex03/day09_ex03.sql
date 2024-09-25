-- deleting functions
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit(), fnc_trg_person_update_audit(), fnc_trg_person_insert_audit() CASCADE;
-- deleting triggers
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
-- deleting values from person_audit table
DELETE FROM person_audit WHERE row_id IS NOT NULL;

-- checking that deletion was successfull           --- ATTENTION! INPUT SEPARATELY
-- to see function list
\df
-- to see table info (inc. triggers) 
\d person
-- check the person_audit table
select * from person_audit;

-- creating the auditor function
CREATE OR REPLACE FUNCTION  fnc_trg_person_audit()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO person_audit (row_id, name, age, gender, address)
        VALUES (NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO person_audit
            (type_event, row_id, name, age, gender, address)
        VALUES 
            ('U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        RETURN OLD;
    ELSE
        INSERT INTO person_audit 
            (type_event, row_id, name, age, gender, address)
        VALUES
            ('D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- creating the trigger
CREATE OR REPLACE TRIGGER trg_person_audit
AFTER INSERT OR UPDATE OR DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_audit();

-- executing some commands
INSERT INTO person(id, name, age, gender, address)VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;

-- check that the function and the trigger worked correctly
SELECT * FROM person_audit;