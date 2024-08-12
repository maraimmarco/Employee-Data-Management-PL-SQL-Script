CREATE OR REPLACE PROCEDURE HR.addNewCity(NewCity IN VARCHAR2)
IS 
    cityChecked VARCHAR2(20) := NewCity;
    countRow NUMBER(10);
BEGIN
    -- Check if the city already exists in the locations table
    SELECT COUNT(*) 
    INTO countRow
    FROM locations
    WHERE city = cityChecked;

    -- If the city doesn't exist, insert it into the locations table
    IF countRow = 0 THEN 
        dbms_output.put_line(cityChecked);
        INSERT INTO locations(location_id, city) VALUES(locations_seq.nextVal, cityChecked);
        dbms_output.put_line('Done');
    ELSE 
        -- Otherwise, display an error message
        DBMS_OUTPUT.PUT_LINE('Error: city already exists');
    END IF;
END;