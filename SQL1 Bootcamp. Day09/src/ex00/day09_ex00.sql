-- creating person audit table
CREATE TABLE IF NOT EXISTS person_audit(
    created TIMESTAMP (2) WITH TIME ZONE DEFAULT NOW() NOT NULL,
    type_event VARCHAR(1) DEFAULT 'I' NOT NULL,
    row_id BIGINT NOT NULL,
    name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    address VARCHAR
    CONSTRAINT ch_type_event CHECK (type_event='I' OR type_event='U' OR type_event='D')
    -- I-insert; U-update; D-delete
);

-- creating the auditor function
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO person_audit (row_id, name, age, gender, address)
    VALUES (NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create the trigger
CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

-- insert a new value into person table
INSERT INTO person(id, name, age, gender, address) 
VALUES (10,'Damir', 22, 'male', 'Irkutsk');

-- check that the function worked correctly
SELECT * FROM person_audit ;