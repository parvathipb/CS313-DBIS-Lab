--Universitydb
--1
--group by course_id,sec_id
select course_id,sec_id,count(*) from takes group by course_id,sec_id having count(*)=(select max(counted) from (select count(*) as counted from takes group by course_id,sec_id) as max_count) or count(*)=(select min(counted) from (select count(*) as counted from takes group by course_id,sec_id) as min_count);
--group by course_id
select course_id,count(*) from takes group by course_id having count(*)=(select max(counted) from (select count(*) as counted from takes group by course_id) as max_count) or count(*)=(select min(counted) from (select count(*) as counted from takes group by course_id) as min_count);
--2
select sec_id,count(*) from takes group by course_id,sec_id having count(*)=(select max(counted) from (select count(*) as counted from takes group by course_id,sec_id) as max_count);
--3
--a
SELECT
    (SELECT COALESCE(MAX(enrollment_count), 0) FROM (
        SELECT COUNT(*) AS enrollment_count
        FROM takes
        GROUP BY course_id, sec_id
    ) AS enrollments) AS maximum_enrollments,
    (SELECT COALESCE(MIN(enrollment_count), 0) FROM (
        SELECT COUNT(*) AS enrollment_count
        FROM takes
        GROUP BY course_id, sec_id
    ) AS enrollments) AS minimum_enrollments;
--b
SELECT
    MAX(COALESCE(enrollment_count, 0)) AS maximum_enrollments,
    MIN(COALESCE(enrollment_count, 0)) AS minimum_enrollments
FROM (
    SELECT
        s.course_id,
        s.sec_id,
        COUNT(t.id) AS enrollment_count
    FROM
        (SELECT DISTINCT course_id, sec_id FROM takes) AS s
    LEFT JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id
    GROUP BY s.course_id, s.sec_id
) AS enrollments;
--4
 select title,course_id from course where course_id like 'CS-1%';
--5
--a
SELECT DISTINCT id
FROM teaches t1
WHERE NOT EXISTS (
    SELECT course_id
    FROM course
    WHERE course_id LIKE 'CS-1%'
    EXCEPT
    SELECT course_id
    FROM teaches t2
    WHERE t1.id = t2.id
);
--b
 WITH cs1_courses AS (
    SELECT course_id
    FROM course
    WHERE course_id LIKE 'CS-1%'
)
SELECT id
FROM teaches t
GROUP BY id
HAVING COUNT(DISTINCT CASE WHEN t.course_id IN (SELECT course_id FROM cs1_courses) THEN t.course_id END) = (SELECT COUNT(*)
FROM cs1_courses);
--6
INSERT INTO student(id, name, dept_name, tot_cred)
SELECT
    id,
    name,
    dept_name,
    0 AS tot_cred
FROM instructor;
--7
 DELETE FROM student
WHERE tot_cred = 0
  AND student.id IN (
    SELECT DISTINCT instructor.id FROM instructor
  );
--8
--SELECT ID,name,10000 * courses_taught AS new_salary FROM instructor where courses_taught=(select count(*) from teaches group by course_id,sec_id);
--UPDATE instructor SET salary = 10000 * (SELECT COUNT(*) FROM teaches WHERE teaches.id = instructor.id group by course_id,sec_id);
UPDATE instructor AS i
SET salary = 10000 * (
    SELECT COUNT(*)
    FROM teaches AS t
    WHERE t.id = i.id
);
--9
CREATE VIEW fail_grades AS
SELECT
    id,
    course_id,
    sec_id,
    semester,
    year,
    grade
FROM
    takes
WHERE
    grade = 'F';
--10
SELECT id
FROM fail_grades
GROUP BY id
HAVING COUNT(*) >= 2;
--11
CREATE TABLE grade_mapping (
    grade CHAR(2) PRIMARY KEY,
    grade_point INT NOT NULL
);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('A', 10);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('A+', 10);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('A-', 9);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('B', 8);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('B+', 8);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('B-', 7);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('C', 6);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('C+', 6);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('C-', 5);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('D', 4);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('D+', 4);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('D-', 3);
INSERT INTO grade_mapping (grade, grade_point) VALUES ('F', 0);
--12
SELECT
    t.id,
    SUM(grade_mapping.grade_point * course.credits) / SUM(course.credits) AS cgpa
FROM
    takes AS t
INNER JOIN
    grade_mapping ON t.grade = grade_mapping.grade
INNER JOIN
    course ON t.course_id = course.course_id
GROUP BY
    t.id
ORDER BY
    t.id;
--13
 SELECT course_id, sec_id, time_slot_id
FROM section
WHERE (room_number, time_slot_id) IN (
    SELECT room_number, time_slot_id
    FROM section
    GROUP BY room_number, time_slot_id
    HAVING count(*) > 1
);
--14
CREATE VIEW faculty AS
SELECT id AS ID, name AS name, dept_name AS department
FROM instructor;
--15
CREATE VIEW CSinstructors AS
SELECT *
FROM instructor
WHERE dept_name = 'Comp. Sci.';
--16
INSERT INTO faculty (ID, name, department) VALUES (101, 'John smith', 'Music');
--INSERT 0 1
INSERT INTO faculty (ID, name, department) VALUES (104, 'Johnny Depp', 'Math');
--ERROR:  insert or update on table "instructor" violates foreign key constraint "instructor_dept_name_fkey"
--DETAIL:  Key (dept_name)=(Math) is not present in table "department".
INSERT INTO faculty (ID, name, department) VALUES (101, 'Bobby Brown', 'Music');
--ERROR:  duplicate key value violates unique constraint "instructor_pkey"
--DETAIL:  Key (id)=(101) already exists.
INSERT INTO CSinstructors (id,name, dept_name,salary) VALUES (20110, 'Robert Downey Jr', 'Comp. Sci.', '68900.00');
--INSERT 0 1
insert into faculty ('111111', 'pqr','Comp. Sci.');
--ERROR:  syntax error at or near "'111111'"
--LINE 1: insert into faculty ('111111', 'pqr','Comp. Sci.');
insert into Csinstructors ('189989', 'xyz','finanace');
--ERROR:  syntax error at or near "'189989'"
--LINE 1: insert into Csinstructors ('189989', 'xyz','finanace');
--17
CREATE USER new_user PASSWORD 'password@123';
GRANT SELECT ON student TO new_user;