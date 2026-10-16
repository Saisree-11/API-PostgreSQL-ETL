import requests
import psycopg2
import logging

# Logging
logging.basicConfig(
    filename="pipeline.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Database Connection
conn = psycopg2.connect(
    host="localhost",
    database="sales_db",
    user="postgres",
    password="787878"
)

cursor = conn.cursor()

API_URL = "https://jsonplaceholder.typicode.com/users"

# Extract
def extract_data():
    response = requests.get(API_URL)

    if response.status_code == 200:
        return response.json()

    return []

# Transform
def transform_data(data):

    transformed = []

    for record in data:

        transformed.append({
            "customer_id": record["id"],
            "customer_name": record["name"],
            "email": record["email"]
        })

    return transformed

# Validate
def validate_data(records):

    valid_records = []

    for record in records:

        if (
            record["customer_id"]
            and record["customer_name"]
            and record["email"]
        ):
            valid_records.append(record)

    return valid_records

# Load
def load_data(records):

    for record in records:

        cursor.execute("""
            INSERT INTO customers
            (customer_id, customer_name, email)

            VALUES (%s,%s,%s)

            ON CONFLICT (customer_id)
            DO NOTHING
        """,
        (
            record["customer_id"],
            record["customer_name"],
            record["email"]
        )
        )

    conn.commit()

# Main ETL
data = extract_data()

transformed = transform_data(data)

validated = validate_data(transformed)

load_data(validated)

print("ETL Completed Successfully")

cursor.close()
conn.close()