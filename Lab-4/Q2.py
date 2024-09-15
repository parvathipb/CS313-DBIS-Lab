import psycopg2

conn = psycopg2.connect(database='moviedb',
                        host="localhost",
                        user="postgres",
                        password="123456",
                        port=5432) 
                        
mycursor = conn.cursor()
command = """
    ALTER TABLE movie_cast
    ADD CONSTRAINT pk_movie_cast PRIMARY KEY (mov_id, act_id);
"""

try:
    # Execute the SQL command
    mycursor.execute(command)
    print("Primary key constraint added successfully.")
    conn.commit()
except Exception as e:
    # If there's an error, rollback the transaction
    conn.rollback()
    print("Error:", e)

# Close the cursor and database connection
mycursor.close()
conn.close()