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
    search_trips
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
    response, status = get_all_trips()
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

# 🔧 OPTIONAL FIX (for old data)
@trip_bp.route('/fix-images', methods=['GET'])
def fix_images():
    db["trips"].update_many(
        {"image": {"$exists": False}},
        {"$set": {"image": ""}}
    )
    return {"message": "Fixed all trips"}

# ❤️ FIX OLD FAVORITES FIELD
@trip_bp.route('/fix-favorites', methods=['GET'])
def fix_favorites():
    db["trips"].update_many(
        {"isFavorite": {"$exists": False}},
        {"$set": {"isFavorite": False}}
    )

    return {
        "success": True,
        "message": "Favorites field added to old trips"
    }


# 📌 FIX OLD PLANNED FIELD
@trip_bp.route('/fix-planned', methods=['GET'])
def fix_planned():

    db["trips"].update_many(
        {"isPlanned": {"$exists": False}},
        {"$set": {"isPlanned": False}}
    )

    return {
        "success": True,
        "message": "Planned field added to old trips"
    }

@trip_bp.route('/search-trips', methods=['GET'])
def search_trips_route():
    query = request.args.get('q', '')
    response, status = search_trips(query)
    return jsonify(response), status

# 📌 TOGGLE FUTURE TRIP
@trip_bp.route('/toggle-planned/<id>', methods=['POST'])
def toggle_planned(id):

    try:
        obj_id = ObjectId(id)
    except:
        return jsonify({
            "success": False,
            "message": "Invalid ID"
        }), 400

    trip = db["trips"].find_one({"_id": obj_id})

    if not trip:
        return jsonify({
            "success": False,
            "message": "Trip not found"
        }), 404

    current_value = trip.get("isPlanned", False)

    db["trips"].update_one(
        {"_id": obj_id},
        {
            "$set": {
                "isPlanned": not current_value
            }
        }
    )

    return jsonify({
        "success": True,
        "message": "Planned status updated",
        "isPlanned": not current_value
    }), 200