from flask import Blueprint, request, jsonify
from config.database import execute_query

auth_bp = Blueprint('auth', __name__, url_prefix="/api/auth")

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    required_register = ['Name', 'Email', 'Password', 'Gender', 'DateofBirth']
    for i in required_register:
        if i not in data:
            return jsonify({
                "success": False,
                'error': f'Missing values {i}'
            }), 400 
    
    validate_query = "SELECT Email FROM users WHERE Email = %s" 
    invalid = execute_query(validate_query, (data['Email']), fetch_one=True)
    
    if invalid:
        if not isinstance(invalid, dict):
            return jsonify({
                'success': False,
                'error': 'Email already exist'
            }), 409
        if "Email" in invalid:
            return jsonify({
                'success': False,
                'error': 'Email already exist'
            }), 409
    
    data_table = """
        INSERT INTO users (Name, Email, Password, DateofBirth, Gender, RoleId) VALUES (%s, %s, %s, %s, %s, 2)
    """ 
    
    register = execute_query(
        data_table, (
            data['Name'],
            data['Email'],
            data['Password'],
            data['DateofBirth'],
            data['Gender']
        ), fetch_all=False)
    
    if register:
        return jsonify({
            'success': True, 
            'message': 'User registered successfully',
            'UserId': register
        }), 201
    else:
        return jsonify({
            'error': 'Failed to register user'
        }),500
        
    
    
@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    
    query = """
        SELECT UserId, Name, RoleId, Password, Email
        FROM users WHERE Email = %s
    """
    
    login = execute_query(query, (
        data['Email'],
        ), fetch_one=True)

    if not login:
        return jsonify({
            'error': 'User does not exist, Sign up first'
        }), 401
    
    # cek apakah login dalam bentuk dict atau tidak
    if not isinstance(login, dict):
    
    #jika tidak maka akan diinisialisasikan menjadi standar dictionary
        login = {
            "UserId": login[0],
            "Name": login[1],
            "Email": login[2],
            "RoleId": login[3],
            "Password": login[4]
        }
    
    if login['Password'] != data['Password']:
        return jsonify({
            'error': 'Invalid Email or Password, Try Again'
        }), 401
    
    return jsonify({
        'success': True,
        'userId': login['UserId'],
        'name': login['Name'],
        'email': login['Email'],
        'roleId': login['RoleId']
    }), 200
    