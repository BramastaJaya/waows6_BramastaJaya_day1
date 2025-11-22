from flask import Flask, render_template, redirect,url_for
from flask_cors import CORS
from config.database import test_connection
from routes.customers import customers_bp
from routes.products import products_bp
from routes.transactions import transactions_bp
from routes.auth import auth_bp
app = Flask(__name__)
CORS(app) 
app.register_blueprint(customers_bp, url_prefix='/api/admin/customers')
app.register_blueprint(products_bp, url_prefix='/api/admin/products')
app.register_blueprint(transactions_bp, url_prefix='/api/admin/transactions')
app.register_blueprint(auth_bp, url_prefix = '/api/auth')

@app.route('/')
def landingPage():
    return redirect(url_for('loginPage'))

@app.route('/auth/login')
def loginPage():
    return render_template('login.html')

@app.route('/auth/register')
def registerPage():
    return render_template('register.html')

@app.route('/admin')
def adminPage():
    return render_template('index.html')

#routes to customer page
@app.route('/admin/customers')
def manage_customer():
    return render_template('manage_customer.html')

#routes to producs list page
@app.route('/admin/products')
def products_page():
    return render_template('manage_products.html')

#route to history of transactions 
@app.route('/admin/transactions')
def transactions_page():
    return render_template('manage_transactions.html')

@app.route('/admin/health')
def health():
    """Health check endpoint"""
    db_status = test_connection()
    return {
        'status': 'healthy',
        'database': 'connected' if db_status else 'disconnected'
    }

if __name__ == '__main__':
    app.run(debug=True, host='127.0.0.1', port=5000)
