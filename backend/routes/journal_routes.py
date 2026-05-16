from flask import Blueprint, request, jsonify
<<<<<<< HEAD
from controllers.journal_controller import (
    create_journal,
    get_user_journals,
    get_trip_journals
)

journal_bp = Blueprint('journal_bp', __name__)
=======

from controllers.journal_controller import (
    create_journal,
    get_all_journals,
    delete_journal
)

journal_bp = Blueprint("journal_bp", __name__)

>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9

# ➕ CREATE JOURNAL
@journal_bp.route('/create-journal', methods=['POST'])
def create_journal_route():
<<<<<<< HEAD
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

=======

    data = request.get_json()

    response, status = create_journal(data)

    return jsonify(response), status


# 📥 GET JOURNALS
@journal_bp.route('/get-journals', methods=['GET'])
def get_journals_route():

    response, status = get_all_journals()

    return jsonify(response), status


# 🗑 DELETE JOURNAL
@journal_bp.route('/delete-journal', methods=['POST'])
def delete_journal_route():

    data = request.get_json()

    response, status = delete_journal(data)

    return jsonify(response), status
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
