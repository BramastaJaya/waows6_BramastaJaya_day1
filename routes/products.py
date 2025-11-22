from flask import Blueprint, request, jsonify
from config.database import execute_query

products_bp = Blueprint('products', __name__)

@products_bp.route('/', methods=['GET'])
def get_all_products():
    """Get all products with category info"""
    query = """
        SELECT 
            p.ProductID,
            p.Name as ProductName,
            p.Price,
            p.Stock,
            p.created_at,
            c.Name as CategoryName,
            c.CategoryID
        FROM products p
        LEFT JOIN product_categories c ON p.CategoryID = c.CategoryID
        ORDER BY p.ProductID DESC
    """
    products = execute_query(query)
    
    if products is None:
        return jsonify({'error': 'Database error'}), 500
    
    return jsonify({
        'success': True,
        'data': products,
        'total': len(products)
    })

@products_bp.route('/<int:product_id>', methods=['GET'])
def get_product(product_id):
    """Get single product by ID"""
    query = """
        SELECT 
            p.ProductID,
            p.Name as ProductName,
            p.Price,
            p.Stock,
            p.created_at,
            c.Name as CategoryName,
            c.CategoryID
        FROM products p
        LEFT JOIN product_categories c ON p.CategoryID = c.CategoryID
        WHERE p.ProductID = %s
    """
    product = execute_query(query, (product_id,), fetch_one=True)
    
    if not product:
        return jsonify({'error': 'Product not found'}), 404
    
    return jsonify({
        'success': True,
        'data': product
    })

@products_bp.route('/', methods=['POST'])
def create_product():
    """Create new product"""
    data = request.get_json()
    
    # Validation
    required_fields = ['Name', 'CategoryID', 'Price', 'Stock']
    for field in required_fields:
        if field not in data:
            return jsonify({'error': f'Missing required field: {field}'}), 400
    
    query = """
        INSERT INTO products (Name, CategoryID, Price, Stock)
        VALUES (%s, %s, %s, %s)
    """
    
    result = execute_query(
        query,
        (
            data['Name'], 
            data['CategoryID'], 
            data['Price'], 
            data['Stock']
        ),
        fetch_all=False
    )
    
    if result:
        return jsonify({
            'success': True,
            'message': 'Product created successfully',
            'product_id': result
        }), 201
    
    return jsonify({'error': 'Failed to create product'}), 500

@products_bp.route('/<int:product_id>', methods=['PUT'])
def update_product(product_id):
    """Update existing product"""
    data = request.get_json()
    
    # Build dynamic update query
    update_fields = []
    params = []
    
    allowed_fields = ['Name', 'CategoryID', 'Price', 'Stock']
    for field in allowed_fields:
        if field in data:
            update_fields.append(f"{field} = %s")
            params.append(data[field])
    
    if not update_fields:
        return jsonify({'error': 'No valid fields to update'}), 400
    
    params.append(product_id)
    query = f"""
        UPDATE products
        SET {', '.join(update_fields)}
        WHERE ProductID = %s
    """
    
    result = execute_query(query, tuple(params), fetch_all=False)
    
    if result:
        return jsonify({
            'success': True,
            'message': 'Product updated successfully'
        })
    
    return jsonify({'error': 'Failed to update product'}), 500

@products_bp.route('/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    """Delete product"""
    query = "DELETE FROM products WHERE ProductID = %s"
    result = execute_query(query, (product_id,), fetch_all=False)
    
    if result:
        return jsonify({
            'success': True,
            'message': 'Product deleted successfully'
        })
    
    return jsonify({'error': 'Failed to delete product'}), 500

@products_bp.route('/categories', methods=['GET'])
def get_categories():
    """Get all product categories"""
    query = "SELECT CategoryID, Name, Description FROM product_categories"
    categories = execute_query(query)
    
    if categories is None:
        return jsonify({'error': 'Database error'}), 500
    
    return jsonify({
        'success': True,
        'data': categories
    })

@products_bp.route('/low-stock', methods=['GET'])
def get_low_stock():
    """Get products with low stock (< 10)"""
    query = """
        SELECT 
            p.ProductID,
            p.Name as ProductName,
            p.Price,
            p.Stock,
            c.Name as CategoryName
        FROM products p
        LEFT JOIN product_categories c ON p.CategoryID = c.CategoryID
        WHERE p.Stock < 10
        ORDER BY p.Stock ASC
    """
    products = execute_query(query)
    
    return jsonify({
        'success': True,
        'data': products if products else []
    })
