from flask import Blueprint, request, jsonify
from controllers.journal_controller import (
    create_journal,
    get_user_journals,
    get_trip_journals,
    update_journal,
    delete_journal
)

journal_bp = Blueprint('journal_bp', __name__)

# ➕ CREATE JOURNAL
@journal_bp.route('/create-journal', methods=['POST'])
def create_journal_route():
    data = request.get_json()
    response, status = create_journal(data)
    return jsonify(response), status

# Get all journals for a user
@journal_bp.route('/get-journals/<user_id>', methods=['GET'])
def get_user_journals_route(user_id):
    response, status = get_user_journals(user_id)
    return jsonify(response), status

# Get journals for a specific trip
@journal_bp.route('/get-trip-journals/<user_id>/<trip_id>', methods=['GET'])
def get_trip_journals_route(user_id, trip_id):
    response, status = get_trip_journals(
        user_id,
        trip_id
    )
    return jsonify(response), status

# 📝 UPDATE JOURNAL
@journal_bp.route('/update-journal', methods=['PUT'])
def update_journal_route():
    data = request.get_json()
    response, status_code = update_journal(data)
    return jsonify(response), status_code

# 🗑 DELETE JOURNAL
@journal_bp.route('/delete-journal', methods=['DELETE'])
def delete_journal_route():
    data = request.get_json()
    response, status_code = delete_journal(data)
    return jsonify(response), status_code