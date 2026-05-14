from datetime import datetime
from flask import Blueprint, request, jsonify
from config.db import db
from bson import ObjectId

from controllers.trip_controller import (
    create_trip,
    get_all_trips,
    get_single_trip,
    update_trip,
    delete_trip,
    toggle_favorite,
    search_trips,
    toggle_planned
)

trip_bp = Blueprint('trip_bp', __name__)

# ➕ CREATE TRIP
@trip_bp.route('/create-trip', methods=['POST'])
def create_trip_route():
    data = request.get_json()
    response, status = create_trip(data)
    return jsonify(response), status

# 📥 GET ALL TRIPS
@trip_bp.route('/get-trips', methods=['GET'])
def get_trips():
    user_id = request.args.get("user_id")
    response, status = get_all_trips(user_id)
    return jsonify(response), status

# 🔍 GET SINGLE TRIP
@trip_bp.route('/get-trip/<id>', methods=['GET'])
def get_trip(id):
    response, status = get_single_trip(id)
    return jsonify(response), status

# ✏️ UPDATE TRIP
@trip_bp.route('/update-trip', methods=['POST'])
def update_trip_route():
    data = request.get_json()
    response, status = update_trip(data)
    return jsonify(response), status

# 🗑 DELETE TRIP
@trip_bp.route('/delete-trip', methods=['POST'])
def delete_trip_route():
    data = request.get_json()
    response, status = delete_trip(data)
    return jsonify(response), status

# ❤️ TOGGLE FAVORITE
@trip_bp.route('/toggle-favorite/<id>', methods=['POST'])
def toggle_favorite_route(id):
    response, status = toggle_favorite(id)
    return jsonify(response), status

@trip_bp.route('/search-trips', methods=['GET'])
def search_trips_route():
    query = request.args.get('q', '')
    response, status = search_trips(query)
    return jsonify(response), status

# 📌 TOGGLE FUTURE TRIP
@trip_bp.route('/toggle-planned/<id>', methods=['POST'])
def toggle_planned_route(id):
    response, status = toggle_planned(id)
    return jsonify(response), status