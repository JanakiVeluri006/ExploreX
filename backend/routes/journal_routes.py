from flask import Blueprint, request, jsonify

from controllers.journal_controller import (
    create_journal,
    get_all_journals,
    delete_journal
)

journal_bp = Blueprint("journal_bp", __name__)


# ➕ CREATE JOURNAL
@journal_bp.route('/create-journal', methods=['POST'])
def create_journal_route():

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