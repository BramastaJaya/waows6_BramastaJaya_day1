from flask import Blueprint, request, jsonify
from config.database import execute_query

customers_bp = Blueprint('customers', __name__)

@customers_bp.route('/', methods=['GET'])
def get_all_customers():
    """Get all customers data"""
    query = """
        SELECT u.Name ,c.CustomerID, u.Gender, TIMESTAMPDIFF(YEAR, u.DateofBirth, CURDATE()) as Age, c.Annual_Income, c.Spending_Score, c.created_at
        FROM mall_customer c
        JOIN users u ON c.UserId = u.UserId
        ORDER BY c.CustomerID DESC
    """
    customers = execute_query(query)
    
    if customers is None:
        return jsonify({'error': 'Database error'}), 500
    
    return jsonify({
        'success': True,
        'data': customers,
        'total': len(customers)
    })

@customers_bp.route('/<int:customer_id>', methods=['GET'])
def get_customer(customer_id):
    """Get single customer by ID with user details"""
    query = """
        SELECT 
            c.CustomerID, 
            u.Name, 
            u.RoleId, 
            u.Gender,
            c.Annual_Income, 
            c.Spending_Score
        FROM mall_customer c
        JOIN users u ON c.UserId = u.UserId
        WHERE c.CustomerID = %s
    """
    customer = execute_query(query, (customer_id,), fetch_one=True)
    
    if not customer:
        return jsonify({'error': 'Customer not found'}), 404
    
    return jsonify({
        'success': True,
        'data': customer
    })

@customers_bp.route('/', methods=['POST'])
def create_customer():
    data = request.get_json()

    required = [
        'Name', 'Email', 'Password', 'Gender',
        'DateofBirth', 'RoleId',
        'Annual_Income', 'Spending_Score'
    ]

    for validate in required:
        #Double check
        if validate not in data or data[validate] in (None, ""):
            return jsonify({'error': f'Missing required validate: {validate}'}), 400

    try:

        #inser ke customers
        insert_user = """
            INSERT INTO users (Name, Email, Password, Gender, DateofBirth, RoleId)
            VALUES (%s, %s, %s, %s, %s, %s)
        """

        users = execute_query(insert_user, (
            data['Name'],
            data['Email'],
            data['Password'],   
            data['Gender'],
            data['DateofBirth'],
            data['RoleId']
        ), fetch_all=False)
        

        # 2. Insert ke mall_customer
        insert_customer = """
            INSERT INTO mall_customer (UserId, Annual_Income, Spending_Score)
            VALUES (%s, %s, %s)
        """
        if not users:
            return jsonify({'error': 'Failed to create user'}), 500


        customer_id = execute_query(insert_customer, (
            users,
            data['Annual_Income'],
            data['Spending_Score']            
        ), fetch_all=False)

        if not customer_id:
            return jsonify({'error': 'Failed to create customer data'}), 500

        return jsonify({
            'success': True,
            'message': 'Customer created successfully',
            'user_id': users,
            'customer_id': customer_id
        }), 201

    except Exception as e:
        print("Error:", e)
        return jsonify({'error': 'Error on server side, please try again later.'}), 500


@customers_bp.route('/<int:customer_id>', methods=['PUT'])
def update_customer(customer_id):
    """Update existing customer - updates both users and mall_customer tables"""
    data = request.get_json()
    
    try:
        # First, get UserId from mall_customer
        get_user_query = """
            SELECT UserId FROM mall_customer WHERE CustomerID = %s
        """
        customer = execute_query(get_user_query, (customer_id,), fetch_one=True)
        
        if not customer:
            return jsonify({'error': 'Customer not found'}), 404
        
        user_id = customer['UserId']
        
        # Update users table (Name, RoleId, DateofBirth)
        user_update_fields = []
        user_params = []
        
        user_allowed_fields = ['Name', 'Gender', 'RoleId', 'DateofBirth']
        for field in user_allowed_fields:
            if field in data:
                user_update_fields.append(f"{field} = %s")
                user_params.append(data[field])
        
        if user_update_fields:
            user_params.append(user_id)
            user_query = f"""
                UPDATE users
                SET {', '.join(user_update_fields)}
                WHERE UserId = %s
            """
            execute_query(user_query, tuple(user_params), fetch_all=False)
        
        # Update mall_customer table (Annual_Income, Spending_Score)
        customer_update_fields = []
        customer_params = []
        
        customer_allowed_fields = ['Annual_Income', 'Spending_Score']
        for field in customer_allowed_fields:
            if field in data:
                customer_update_fields.append(f"{field} = %s")
                customer_params.append(data[field])
        
        if customer_update_fields:
            customer_params.append(customer_id)
            customer_query = f"""
                UPDATE mall_customer
                SET {', '.join(customer_update_fields)}
                WHERE CustomerID = %s
            """
            execute_query(customer_query, tuple(customer_params), fetch_all=False)
        
        if not user_update_fields and not customer_update_fields:
            return jsonify({'error': 'No valid fields to update'}), 400
        
        return jsonify({
            'success': True,
            'message': 'Customer updated successfully'
        })
        
    except Exception as e:
        print("Error updating customer:", e)
        return jsonify({'error': 'Failed to update customer'}), 500


@customers_bp.route('/<int:customer_id>', methods=['DELETE'])
def delete_customer(customer_id):
    """Delete customer"""
    query = "DELETE FROM mall_customer WHERE CustomerID = %s"
    result = execute_query(query, (customer_id,), fetch_all=False)
    
    if result:
        return jsonify({
            'success': True,
            'message': 'Customer deleted successfully'
        })
    
    return jsonify({'error': 'Failed to delete customer'}), 500


@customers_bp.route('/stats', methods=['GET'])
def get_customer_stats():
    """Get customer statistics"""
    query = """
        SELECT 
            COUNT(*) as total_customers,
            AVG(TIMESTAMPDIFF(YEAR, u.DateofBirth, CURDATE())) as avg_age,
            AVG(c.Annual_Income) as avg_income,
            AVG(c.Spending_Score) as avg_spending_score
        FROM mall_customer c
        JOIN users u ON c.UserId = u.UserId;
    """
    stats = execute_query(query, fetch_one=True)
    
    
    
    return jsonify({
        'success': True,
        'data': stats
    })