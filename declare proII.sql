DECLARE
    CURSOR curEmpTemp IS 
        SELECT *
        FROM employees_temp; 
    cityname VARCHAR2(100);
    v_job_id varchar(10);
    v_sal number;
    v_dept_id number;
    v_email VARCHAR2(25); 
BEGIN 
    FOR recEmpTemp IN curEmpTemp LOOP
        v_email := SUBSTR(recEmpTemp.first_name, 1, 1)||upper(recEmpTemp.last_name);
        v_sal := to_number(recEmpTemp.salary);
        
        IF INSTR(recEmpTemp.email, '@') > 0 THEN 
            addNewJob(recEmpTemp.job_title);
            addNewCity(recEmpTemp.city);
            addNewJob(recEmpTemp.job_title);
            addNewDep(recEmpTemp.city, recEmpTemp.department_name);
            select job_id into v_job_id from jobs where job_title = recEmpTemp.job_title;
            select department_id into v_dept_id from departments where department_name = RECEMPTEMP.DEPARTMENT_NAME;
            NewEmp(recEmpTemp.first_name, recEmpTemp.last_name, v_email, recEmpTemp.hire_date, v_job_id,v_sal,v_dept_id);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Does not exist');
        END IF;
    END LOOP;
END;
select * from user_errors;