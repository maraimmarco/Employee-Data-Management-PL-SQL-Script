CREATE OR REPLACE PROCEDURE HR.addNewJob(
    jobTile IN VARCHAR2
)
IS 
    jobNameCheck varchar(20) :=jobTile;
    jobChecked NUMBER(10);
    jobId VARCHAR2(20);
BEGIN
    SELECT COUNT(*)
     INTO jobChecked 
     FROM jobs
     where job_title =jobNameCheck;
    IF jobChecked = 0 THEN 
        jobId := SUBSTR(jobTile, 1, 3);
        INSERT INTO jobs(job_id, job_title) VALUES(jobId, jobTile);
    ELSE 
               DBMS_OUTPUT.PUT_LINE('Error: Jobs already exist');
    END IF;
END addNewJob;