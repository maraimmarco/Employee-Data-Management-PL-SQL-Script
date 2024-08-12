CREATE OR REPLACE procedure HR.NewEmp(firstname in varchar2,lastname in varchar2,email in varchar2,hireDate in varchar2,jobID in varchar2,salary in number,dept_id in number)   ---convert hire Date to to_date
     is 
     convertDate date ;
          begin 
     convertDate := to_date(hiredate,'dd/mm/yyyy');
        insert into employees (employee_id,first_name,last_name,email,hire_date,job_id,salary,department_id) values (EMPLOYEES_SEQ.nextVal,firstname,lastname,email,convertDate,jobID,salary,dept_id);
     end;