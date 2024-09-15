import csv #to read csv files
import psycopg2 #to connect to database

conn = psycopg2.connect(database='collegedb',
                        host="localhost",
                        user="user",
                        password="123456",
                        port=5432) 
                        
mycursor = conn.cursor() #connecting cursor and used to execute our commands

with open("studentData.csv", "r") as ip:
    csv_reader = csv.reader(ip) 

    for record in csv_reader:
        line = "INSERT INTO student VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\'," + record[
            3] + ");"  #this line prints like this (11,'sharukh','khan','M') if commanded print 
        mycursor.execute(line)

with open("departmentData.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO department VALUES (" + "\'" + record[0] + "\'," + record[1] + ");"
        mycursor.execute(line)

with open("professorData.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO professor VALUES (" + "\'"+ record[0] + "\',\'" + record[1] + "\');"
        mycursor.execute(line)

with open("courseData.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO course VALUES (" + record[0] + ",\'" + record[1] + "\',\'" + record[2] + "\');"  #this line prints like this (11,'sharukh','khan') if commanded print 
        mycursor.execute(line)

with open("majorData.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO major VALUES (" + "\'" + record[0] + "\'," + record[1] + ");"
        mycursor.execute(line)

with open("enrollData.csv", "r") as ip:
    csv_reader = csv.reader(ip)

    for record in csv_reader:
        line = "INSERT INTO enroll VALUES (" + record[0] + "," + record[1] + ",\'" + record[2] + "\'," + record[
            3] + ");"  #this line prints like this (11,6,'khan',5) if commanded print 
        mycursor.execute(line)

conn.commit()
conn.close()
mycursor.close()
