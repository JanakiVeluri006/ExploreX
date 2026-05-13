from flask import Blueprint, request, jsonify
from controllers.user_controller import create_user

user_bp = Blueprint('user_bp', __name__)

@user_bp.route('/create-user', methods=['POST'])
def create_user_route():
    data = request.get_json()
    response, status = create_user(data)
    return jsonify(response), status