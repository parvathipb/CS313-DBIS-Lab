import psycopg2

# Connect to the PostgreSQL server
conn = psycopg2.connect(
    host="localhost",
    user="postgres",
    password="123456",
    port=5432
)

# Create a cursor
cursor = conn.cursor()

# Check if the database 'mydb' already exists
cursor.execute("SELECT 1 FROM pg_database WHERE datname = 'mydb'")

# If 'mydb' doesn't exist, create it
if cursor.fetchone() is None:
    cursor.execute("CREATE DATABASE mydb")

# Commit the changes
conn.commit()

# Close the cursor and the database connection
cursor.close()
conn.close()