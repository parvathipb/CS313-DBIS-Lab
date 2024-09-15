COPY student FROM 'C:/Users/handout-3/studentData.csv' DELIMITER ',';
COPY department FROM 'C:/Users/handout-3/departmentData.csv' DELIMITER ',';
COPY professor FROM 'C:/Users/handout-3/professorData.csv' DELIMITER ',';
COPY course FROM 'C:/Users/handout-3/courseData.csv' DELIMITER ',';
COPY major FROM 'C:/Users/handout-3/majorData.csv' DELIMITER ',';
COPY enroll FROM 'C:/Users/handout-3/enrollData.csv' DELIMITER ',';

--ALTER TABLE course ALTER COLUMN cname TYPE VARCHAR(60);
