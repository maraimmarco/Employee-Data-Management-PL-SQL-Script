CREATE OR REPLACE procedure HR.addNewDep  (cityName varchar2,departmentName varchar2)
is 
    cityNameVar varchar(20) := cityName;
    countNumber number(10);
    locationNumber Number(10);
begin
    select count(*)
    into countNumber
    from departments 
    where department_name = departmentName;
    --retrive location id
    select location_id 
    into locationNumber
    from locations 
    where city = cityNameVar;
   
     if countNumber =0 then 
        insert into departments (department_id,department_name,location_id) values(DEPARTMENTS_SEQ.nextVal,departmentName,locationNumber);
        
     else 
          DBMS_OUTPUT.PUT_LINE('Error: department  already exists');
     end if ;
end;