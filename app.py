from flask import Flask, render_template
from flask_cors import CORS
from config.database import test_connection
from routes.customers import customers_bp
from routes.products import products_bp
from routes.transactions import transactions_bp

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Register blueprints
app.register_blueprint(customers_bp, url_prefix='/api/customers')
app.register_blueprint(products_bp, url_prefix='/api/products')
app.register_blueprint(transactions_bp, url_prefix='/api/transactions')

@app.route('/')
def index():
    """Landing page"""
    return render_template('index.html')

@app.route('/customers-page')
def customers_page():
    """Customers management page"""
    return render_template('customers.html')

@app.route('/products-page')
def products_page():
    """Products management page"""
    return render_template('products.html')

@app.route('/transactions-page')
def transactions_page():
    """Transactions view page"""
    return render_template('transactions.html')

@app.route('/health')
def health():
    """Health check endpoint"""
    db_status = test_connection()
    return {
        'status': 'healthy',
        'database': 'connected' if db_status else 'disconnected'
    }

if __name__ == '__main__':
    print("\n" + "="*50)
    print("🚀 WAOW Season 6 - Flask Workshop")
    print("="*50)
    print("📍 Server running on: http://127.0.0.1:5000")
    print("🔗 API endpoints:")
    print("   - Customers: http://127.0.0.1:5000/api/customers")
    print("   - Products: http://127.0.0.1:5000/api/products")
    print("   - Transactions: http://127.0.0.1:5000/api/transactions")
    print("="*50 + "\n")
    
    app.run(debug=True, host='0.0.0.0', port=4500)
