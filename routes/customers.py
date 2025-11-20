from flask import Blueprint, request, jsonify
from config.database import execute_query

customers_bp = Blueprint('customers', __name__)

@customers_bp.route('/', methods=['GET'])
def get_all_customers():
    """Get all customers"""
    query = """
        SELECT CustomerID, Gender, Age, Annual_Income, Spending_Score, created_at
        FROM mall_customer
        ORDER BY CustomerID DESC
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
    """Get single customer by ID"""
    query = """
        SELECT CustomerID, Gender, Age, Annual_Income, Spending_Score, created_at
        FROM mall_customer
        WHERE CustomerID = %s
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
    """Create new customer"""
    data = request.get_json()
    
    # Validation
    required_fields = ['Gender', 'Age', 'Annual_Income', 'Spending_Score']
    for field in required_fields:
        if field not in data:
            return jsonify({'error': f'Missing required field: {field}'}), 400
    
    query = """
        INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score)
        VALUES (%s, %s, %s, %s)
    """
    
    result = execute_query(
        query,
        (data['Gender'], data['Age'], data['Annual_Income'], data['Spending_Score']),
        fetch_all=False
    )
    
    if result:
        return jsonify({
            'success': True,
            'message': 'Customer created successfully',
            'customer_id': result
        }), 201
    
    return jsonify({'error': 'Failed to create customer'}), 500

@customers_bp.route('/<int:customer_id>', methods=['PUT'])
def update_customer(customer_id):
    """Update existing customer"""
    data = request.get_json()
    
    # Build dynamic update query
    update_fields = []
    params = []
    
    allowed_fields = ['Gender', 'Age', 'Annual_Income', 'Spending_Score']
    for field in allowed_fields:
        if field in data:
            update_fields.append(f"{field} = %s")
            params.append(data[field])
    
    if not update_fields:
        return jsonify({'error': 'No valid fields to update'}), 400
    
    params.append(customer_id)
    query = f"""
        UPDATE mall_customer
        SET {', '.join(update_fields)}
        WHERE CustomerID = %s
    """
    
    result = execute_query(query, tuple(params), fetch_all=False)
    
    if result:
        return jsonify({
            'success': True,
            'message': 'Customer updated successfully'
        })
    
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
            AVG(Age) as avg_age,
            AVG(Annual_Income) as avg_income,
            AVG(Spending_Score) as avg_spending_score
        FROM mall_customer
    """
    stats = execute_query(query, fetch_one=True)
    
    return jsonify({
        'success': True,
        'data': stats
    })
