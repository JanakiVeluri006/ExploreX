from flask import Blueprint, request, jsonify
from controllers.trip_controller import (
    create_trip,
    get_all_trips,
    get_single_trip,
    update_trip,
    delete_trip,
    toggle_favorite,
<<<<<<< HEAD
    search_trips,
    toggle_planned
=======
    toggle_planned,
    search_trips,
    fix_images_data,
    fix_favorites_data,
    fix_planned_data,
    get_trips_by_category
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
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
<<<<<<< HEAD
def get_trips():
    user_id = request.args.get("user_id")
    response, status = get_all_trips(user_id)
=======
def get_trips_route():
    response, status = get_all_trips()
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    return jsonify(response), status


# 🔍 GET SINGLE TRIP
@trip_bp.route('/get-trip/<id>', methods=['GET'])
def get_trip_route(id):
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

<<<<<<< HEAD
=======

# 📌 TOGGLE PLANNED
@trip_bp.route('/toggle-planned/<id>', methods=['POST'])
def toggle_planned_route(id):
    response, status = toggle_planned(id)
    return jsonify(response), status


# 🔍 SEARCH TRIPS
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
@trip_bp.route('/search-trips', methods=['GET'])
def search_trips_route():
    query = request.args.get('q', '')
    response, status = search_trips(query)
    return jsonify(response), status

<<<<<<< HEAD
# 📌 TOGGLE FUTURE TRIP
@trip_bp.route('/toggle-planned/<id>', methods=['POST'])
def toggle_planned_route(id):
    response, status = toggle_planned(id)
=======

# 🔧 FIX MISSING IMAGES
@trip_bp.route('/fix-images', methods=['GET'])
def fix_images_route():
    response, status = fix_images_data()
    return jsonify(response), status


# ❤️ FIX OLD FAVORITES FIELD
@trip_bp.route('/fix-favorites', methods=['GET'])
def fix_favorites_route():
    response, status = fix_favorites_data()
    return jsonify(response), status


# 📌 FIX OLD PLANNED FIELD
@trip_bp.route('/fix-planned', methods=['GET'])
def fix_planned_route():
    response, status = fix_planned_data()
    return jsonify(response), status

# 🌍 GET TRIPS BY CATEGORY
@trip_bp.route('/get-category/<category_name>', methods=['GET'])
def get_category_route(category_name):

    response, status = get_trips_by_category(category_name)

>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    return jsonify(response), status