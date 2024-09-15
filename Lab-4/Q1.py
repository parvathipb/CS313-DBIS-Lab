import psycopg2

conn = psycopg2.connect(database='moviedb',
                        host="localhost",
                        user="postgres",
                        password="123456",
                        port=5432) 
                        
mycursor = conn.cursor()
actor_id = input("Enter actor id : ")
#actor_id = int(acto_id)
#print(actor_id+1)
actor_fname = input("Enter First name : ")
actor_lname = input("Enter Last name : ")
actor_gender = input("Enter Gender : ")
# Check if the actor id already exists in the database
mycursor.execute("SELECT act_id FROM actor WHERE act_id = %s", (actor_id,))
existing_actor = mycursor.fetchone()

if existing_actor:
    print("Output: Actor ID already exists")
else:
    # Insert the new actor details into the actor table
    mycursor.execute("INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES (%s, %s, %s, %s)",
                     (actor_id, actor_fname, actor_lname, actor_gender))
    conn.commit()
    print("Output: Actor details inserted into the actor table successfully")

# Close the cursor and database connection
mycursor.close()
conn.close()