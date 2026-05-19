from flask import Blueprint, request, jsonify

from controllers.journal_controller import (
    create_journal,
    get_all_journals,
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


# 📚 GET ALL JOURNALS OF USER
@journal_bp.route('/get-journals/<user_id>', methods=['GET'])
def get_all_journals_route(user_id):
    response, status = get_all_journals(user_id)
    return jsonify(response), status


# 📖 GET JOURNALS OF SPECIFIC TRIP
@journal_bp.route(
    '/get-trip-journals/<user_id>/<trip_id>',
    methods=['GET']
)
def get_trip_journals_route(user_id, trip_id):
    response, status = get_trip_journals(
        user_id,
        trip_id
    )
    return jsonify(response), status


# ✏️ UPDATE JOURNAL
@journal_bp.route('/update-journal', methods=['PUT'])
def update_journal_route():
    data = request.get_json()
    response, status = update_journal(data)
    return jsonify(response), status

# 🗑 DELETE JOURNAL
@journal_bp.route('/delete-journal', methods=['DELETE'])
def delete_journal_route():
    data = request.get_json()
    response, status = delete_journal(data)
    return jsonify(response), status