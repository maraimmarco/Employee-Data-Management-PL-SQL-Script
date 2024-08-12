DECLARE
  CURSOR filterCur IS
    SELECT cols.table_name, cols.column_name
    FROM all_constraints cons
    JOIN all_cons_columns cols ON cons.constraint_name = cols.constraint_name
    JOIN all_tab_columns tab_cols ON cons.table_name = tab_cols.table_name AND cols.column_name = tab_cols.column_name
    WHERE cols.position = 1
      AND cons.constraint_type = 'P'
      AND cons.owner = cols.owner
      AND cols.owner = 'HR'
      AND NOT EXISTS (
          SELECT 1
          FROM all_cons_columns composite_check
          WHERE composite_check.constraint_name = cons.constraint_name
            AND composite_check.owner = cons.owner
          HAVING COUNT(*) > 1
      )
      AND tab_cols.data_type != 'VARCHAR2' and tab_cols.data_type !='CHAR'
    ORDER BY cols.table_name, cols.position;

  CURSOR dropSeq IS 
    SELECT sequence_name FROM user_sequences;


  PROCEDURE createSeq( tableName IN VARCHAR2, columnName IN VARCHAR2) IS 
sequenceName varchar2(50); 
 max_value NUMBER(20);
BEGIN
  sequenceName := tableName || '_SEQ'; --  seq
  EXECUTE IMMEDIATE 'SELECT MAX(' || columnName || ') FROM ' || tableName INTO max_value;

  IF max_value IS NOT NULL THEN
    -- Increment max value by 1 and create sequence
    max_value := max_value + 1;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE ' || sequenceName ||
                      ' START WITH ' || max_value ||
                      ' INCREMENT BY 1';
                    
  
   EXECUTE IMMEDIATE 'create or replace trigger ' || tableName || '_trg ' ||
                     'before insert on ' || tableName || ' ' ||
                     'for each row ' ||
                     'begin ' ||
                     ':new.' || columnName || ' := ' || sequenceName || '.nextval; ' ||
                     'end;';
  ELSE

    DBMS_OUTPUT.PUT_LINE('No existing data found for ' || tableName || '.' || columnName);
  END IF;
EXCEPTION
  WHEN OTHERS THEN

    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END createSeq;

BEGIN

  FOR var_dropSeq IN dropSeq LOOP  
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || var_dropSeq.sequence_name;
  END LOOP;


  FOR varfilterCur IN filterCur LOOP
    DECLARE

    BEGIN

      createSeq( varfilterCur.table_name, varfilterCur.column_name);
    END;
  END LOOP;
END;