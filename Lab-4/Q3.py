import psycopg2

def insert_movie_info(mycursor, mov_id, act_id, role):
    try:
        mycursor.execute(
            "INSERT INTO movie_cast (mov_id, act_id, role) VALUES (%s, %s, %s)",
            (mov_id, act_id, role),
        )
    except psycopg2.IntegrityError as e:
        # If there's an integrity error (movie ID not found), raise an exception
        raise e

conn = psycopg2.connect(database='moviedb',
                        host="localhost",
                        user="postgres",
                        password="123456",
                        port=5432) 
                        
mycursor = conn.cursor()

# Start a transaction
conn.autocommit = False
n=0
try:
    num_movies = int(input("Enter the number of movies: "))

    for i in range(num_movies):
        mov_id = input(f"Enter movie id of movie number {i + 1}: ")
        role = input(f"Enter role of the actor in movie number {i + 1}: ")
        act_id = 131

    # Insert movie information into the movie_cast table
        try:
            insert_movie_info(mycursor, mov_id, act_id, role)
        except psycopg2.IntegrityError as e:
            # Handle the integrity error when movie ID is not found
            n = i + 1
            conn.rollback()
            # print("Error:",e)
        if i == num_movies and n != 0:
            break

    if n == 0:
        # Commit the transaction if all insertions were successful
        conn.commit()
        print("Output: Database update successful")
    else:
        print(f"Output: Movie number {n} is not present in the database. Database is not updated.")

finally:
    # Close the cursor and database connection
    conn.autocommit = True  # Reset autocommit to True
    mycursor.close()
    conn.close()

