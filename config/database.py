import pymysql
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Database configuration
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', '@GunG.Br4m'),
    'database': os.getenv('DB_NAME', 'shop'),
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

def get_db_connection():
    """
    Create and return a database connection
    """
    try:
        connection = pymysql.connect(**DB_CONFIG)
        return connection
    except pymysql.Error as e:
        print(f"❌ Database connection error: {e}")
        return None

def test_connection():
    """
    Test database connection
    """
    try:
        connection = get_db_connection()
        if connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                result = cursor.fetchone()
            connection.close()
            print("✅ Database connection successful!")
            return True
        return False
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        return False

def execute_query(query, params=None, fetch_one=False, fetch_all=True):
    """
    Execute a query and return results
    
    Args:
        query: SQL query string
        params: Query parameters (tuple or dict)
        fetch_one: Return single result
        fetch_all: Return all results
    
    Returns:
        Query results or None
    """
    connection = get_db_connection()
    if not connection:
        return None
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            
            # For SELECT queries
            if fetch_one:
                result = cursor.fetchone()
            elif fetch_all:
                result = cursor.fetchall()
            else:
                # For INSERT/UPDATE/DELETE
                connection.commit()
                result = cursor.lastrowid if cursor.lastrowid else True
                
        return result
    except pymysql.Error as e:
        print(f"❌ Query execution error: {e}")
        connection.rollback()
        return None
    finally:
        connection.close()
