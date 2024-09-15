CREATE TABLE student(
        sid INT NOT NULL PRIMARY KEY,
        sname VARCHAR(20),
        gender CHAR(1),
        gpa FlOAT(1)
        );
    
CREATE TABLE  department (
        dname VARCHAR(20) NOT NULL PRIMARY KEY,
        numphds INT
        );
       

CREATE TABLE  professor(
           pname VARCHAR(20) NOT NULL PRIMARY KEY,
           dname VARCHAR(20) REFERENCES department(dname)
           );
           
CREATE TABLE course(
               cno INT NOT NULL PRIMARY KEY,
               cname VARCHAR(20),
               dname VARCHAR(20) NOT NULL REFERENCES department(dname)
               );
               
CREATE TABLE  major(
                   dname VARCHAR(20) NOT NULL REFERENCES department(dname),
                   sid INT NOT NULL REFERENCES student(sid) 
                   );
                   
CREATE TABLE  enroll(
                      sid INT NOT NULL REFERENCES student(sid) ,
                      cno INT NOT NULL REFERENCES course(cno),
                      dname VARCHAR(20) NOT NULL REFERENCES department(dname),
                      grade FlOAT(1)
                       );

