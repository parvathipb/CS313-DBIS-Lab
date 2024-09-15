\copy student FROM 'studentData.csv' DELIMITER ',';
\copy department FROM 'departmentData.csv' DELIMITER ',';
\copy professor FROM 'professorData.csv' DELIMITER ',';
\copy course FROM 'courseData.csv' DELIMITER ',';
\copy major FROM 'majorData.csv' DELIMITER ',';
\copy enroll FROM 'enrollData.csv' DELIMITER ',';

--ALTER TABLE course ALTER COLUMN cname TYPE VARCHAR(60);
