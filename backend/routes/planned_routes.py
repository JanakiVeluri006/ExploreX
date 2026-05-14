from flask import Blueprint, request, jsonify
from controllers.planned_controller import (
    toggle_planned,
    get_user_planned
)

planned_bp = Blueprint('planned_bp', __name__)

# ➕ TOGGLE PLANNED
@planned_bp.route('/toggle-planned', methods=['POST'])
def toggle_planned_route():
    data = request.get_json()
    response, status = toggle_planned(data)
    return jsonify(response), status

# 📥 GET PLANNED TRIPS
@planned_bp.route('/get-planned/<user_id>', methods=['GET'])
def get_planned_route(user_id):
    response, status = get_user_planned(user_id)
    return jsonify(response), status