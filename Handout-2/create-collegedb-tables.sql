CREATE TABLE student(
        sid INT NOT NULL PRIMARY KEY,
        sname VARCHAR(100),
        gender CHAR(1),
        gpa FlOAT(2)
        );
    
CREATE TABLE  department (
        dname VARCHAR(100) NOT NULL PRIMARY KEY,
        numphds INT
        );
       

CREATE TABLE  professor(
           pname VARCHAR(100) NOT NULL PRIMARY KEY,
           dname VARCHAR(100) REFERENCES department(dname)
           );
           
CREATE TABLE course(
               cno FLOAT NOT NULL UNIQUE,
               cname VARCHAR(100),
               dname VARCHAR(100) NOT NULL REFERENCES department(dname),
               CONSTRAINT fk_cour_1 PRIMARY KEY (cno,dname)
               --PRIMARY KEY (cno,dname)
               );
               
CREATE TABLE  major(
                   dname VARCHAR(100) NOT NULL REFERENCES department(dname),
                   sid INT NOT NULL REFERENCES student(sid) 
                   );
                   
CREATE TABLE  enroll(
                      sid INT NOT NULL REFERENCES student(sid) ,
                      grade FLOAT,
                      dname VARCHAR(100) NOT NULL REFERENCES department(dname),
                      cno FLOAT NOT NULL REFERENCES course(cno),
                      CONSTRAINT fk_cour_1 FOREIGN KEY(cno) REFERENCES course(cno)
                       );

