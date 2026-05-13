from flask import Blueprint, request, jsonify

from controllers.favorite_controller import (
    toggle_favorite,
    get_user_favorites
)

favorite_bp = Blueprint('favorite_bp', __name__)


@favorite_bp.route('/toggle-favorite', methods=['POST'])
def toggle_favorite_route():

    data = request.get_json()

    response, status = toggle_favorite(data)

    return jsonify(response), status


@favorite_bp.route('/get-favorites/<user_id>', methods=['GET'])
def get_favorites_route(user_id):

    response, status = get_user_favorites(user_id)

    return jsonify(response), status