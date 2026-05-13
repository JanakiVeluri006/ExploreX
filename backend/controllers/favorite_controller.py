from config.db import db
from bson import ObjectId


def toggle_favorite(data):

    user_id = data.get("user_id")
    trip_id = data.get("trip_id")

    if not user_id or not trip_id:

        return {
            "success": False,
            "message": "Missing required fields"
        }, 400

    existing_favorite = db["favorites"].find_one({
        "user_id": user_id,
        "trip_id": trip_id
    })

    # ❌ Remove favorite
    if existing_favorite:

        db["favorites"].delete_one({
            "_id": existing_favorite["_id"]
        })

        return {
            "success": True,
            "message": "Favorite removed",
            "isFavorite": False
        }, 200

    # ✅ Add favorite
    db["favorites"].insert_one({
        "user_id": user_id,
        "trip_id": trip_id
    })

    return {
        "success": True,
        "message": "Favorite added",
        "isFavorite": True
    }, 201


def get_user_favorites(user_id):

    favorites = db["favorites"].find({
        "user_id": user_id
    })

    trip_ids = []

    for favorite in favorites:
        trip_ids.append(ObjectId(favorite["trip_id"]))

    trips = []

    for trip in db["trips"].find({
        "_id": {"$in": trip_ids}
    }):

        trip["_id"] = str(trip["_id"])
        trip["id"] = trip["_id"]
        trip["isFavorite"] = True

        trips.append(trip)

    return {
        "success": True,
        "data": trips
    }, 200