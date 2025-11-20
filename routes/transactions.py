from flask import Blueprint, request, jsonify
from config.database import execute_query

transactions_bp = Blueprint('transactions', __name__)

@transactions_bp.route('/', methods=['GET'])
def get_all_transactions():
    """Get all transactions with customer info"""
    query = """
        SELECT 
            t.TransactionID,
            t.CustomerID,
            t.TransactionDate,
            t.TotalAmount,
            t.PaymentMethod,
            c.Gender,
            c.Age
        FROM transactions t
        LEFT JOIN mall_customer c ON t.CustomerID = c.CustomerID
        ORDER BY t.TransactionDate DESC
        LIMIT 100
    """
    transactions = execute_query(query)
    
    if transactions is None:
        return jsonify({'error': 'Database error'}), 500
    
    return jsonify({
        'success': True,
        'data': transactions,
        'total': len(transactions)
    })

@transactions_bp.route('/<int:transaction_id>', methods=['GET'])
def get_transaction(transaction_id):
    """Get single transaction with details"""
    # Get transaction header
    query_header = """
        SELECT 
            t.TransactionID,
            t.CustomerID,
            t.TransactionDate,
            t.TotalAmount,
            t.PaymentMethod,
            c.Gender,
            c.Age,
            c.Annual_Income
        FROM transactions t
        LEFT JOIN mall_customer c ON t.CustomerID = c.CustomerID
        WHERE t.TransactionID = %s
    """
    transaction = execute_query(query_header, (transaction_id,), fetch_one=True)
    
    if not transaction:
        return jsonify({'error': 'Transaction not found'}), 404
    
    # Get transaction details
    query_details = """
        SELECT 
            td.DetailID,
            td.ProductID,
            p.Name as ProductName,
            td.Quantity,
            td.UnitPrice,
            td.Subtotal
        FROM transaction_details td
        LEFT JOIN products p ON td.ProductID = p.ProductID
        WHERE td.TransactionID = %s
    """
    details = execute_query(query_details, (transaction_id,))
    
    transaction['items'] = details if details else []
    
    return jsonify({
        'success': True,
        'data': transaction
    })

@transactions_bp.route('/customer/<int:customer_id>', methods=['GET'])
def get_customer_transactions(customer_id):
    """Get all transactions for a specific customer"""
    query = """
        SELECT 
            t.TransactionID,
            t.TransactionDate,
            t.TotalAmount,
            t.PaymentMethod
        FROM transactions t
        WHERE t.CustomerID = %s
        ORDER BY t.TransactionDate DESC
    """
    transactions = execute_query(query, (customer_id,))
    
    if transactions is None:
        return jsonify({'error': 'Database error'}), 500
    
    return jsonify({
        'success': True,
        'data': transactions,
        'total': len(transactions)
    })

@transactions_bp.route('/stats', methods=['GET'])
def get_transaction_stats():
    """Get transaction statistics"""
    query = """
        SELECT 
            COUNT(*) as total_transactions,
            SUM(TotalAmount) as total_revenue,
            AVG(TotalAmount) as avg_transaction_value,
            MAX(TotalAmount) as max_transaction,
            MIN(TotalAmount) as min_transaction
        FROM transactions
    """
    stats = execute_query(query, fetch_one=True)
    
    return jsonify({
        'success': True,
        'data': stats
    })

@transactions_bp.route('/recent', methods=['GET'])
def get_recent_transactions():
    """Get recent transactions (last 10)"""
    query = """
        SELECT 
            t.TransactionID,
            t.CustomerID,
            t.TransactionDate,
            t.TotalAmount,
            t.PaymentMethod,
            c.Gender,
            c.Age
        FROM transactions t
        LEFT JOIN mall_customer c ON t.CustomerID = c.CustomerID
        ORDER BY t.TransactionDate DESC
        LIMIT 10
    """
    transactions = execute_query(query)
    
    return jsonify({
        'success': True,
        'data': transactions if transactions else []
    })

@transactions_bp.route('/top-customers', methods=['GET'])
def get_top_customers():
    """Get top customers by total spending"""
    query = """
        SELECT 
            c.CustomerID,
            c.Gender,
            c.Age,
            c.Annual_Income,
            c.Spending_Score,
            COUNT(t.TransactionID) as total_transactions,
            SUM(t.TotalAmount) as total_spent
        FROM mall_customer c
        LEFT JOIN transactions t ON c.CustomerID = t.CustomerID
        GROUP BY c.CustomerID
        ORDER BY total_spent DESC
        LIMIT 10
    """
    customers = execute_query(query)
    
    return jsonify({
        'success': True,
        'data': customers if customers else []
    })
