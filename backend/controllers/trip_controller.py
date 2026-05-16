from config.db import db
from bson import ObjectId
from datetime import datetime
from services.category_service import detect_category

<<<<<<< HEAD
=======
# ➕ CREATE TRIP
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
def create_trip(data):

    title = data.get("title")
    location = data.get("location")
    days = data.get("days")
    image = data.get("image", "")
    description = data.get("description", "")
    category = detect_category(location)

    if not title or not location or days is None:
        return {
            "success": False,
            "message": "All fields are required"
        }, 400

    try:
        days = int(days)
    except:
        return {
            "success": False,
            "message": "Days must be a number"
        }, 400

    result = db["trips"].insert_one({
        "title": title,
        "location": location,
        "days": days,
        "image": image,
        "description": description,
        "category": category,
        "isFavorite": False,
        "isPlanned": False,
        "created_at": datetime.now()
    })

    return {
        "success": True,
        "message": "Trip created successfully",
        "id": str(result.inserted_id)
    }, 201

<<<<<<< HEAD
def get_all_trips(user_id):
=======

# 📥 GET ALL TRIPS
def get_all_trips():

>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    trips = []
    favorite_trip_ids = []
    favorites = db["favorites"].find({"user_id": user_id})
    for favorite in favorites:
        favorite_trip_ids.append(favorite["trip_id"])
    planned_trip_ids = []
    planned = db["planned_trips"].find({"user_id": user_id})
    for item in planned:
        planned_trip_ids.append(item["trip_id"])
    for trip in db["trips"].find():

        trip["_id"] = str(trip["_id"])
        trip["id"] = trip["_id"]

        trips.append(trip)
        trip["isFavorite"] = (str(trip["_id"]) in favorite_trip_ids)
        trip["isPlanned"] = (str(trip["_id"]) in planned_trip_ids)

    return {
        "success": True,
        "data": trips
    }, 200


# 🔍 GET SINGLE TRIP
def get_single_trip(id):

    try:
        obj_id = ObjectId(id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    trip = db["trips"].find_one({"_id": obj_id})

    if not trip:
        return {
            "success": False,
            "message": "Trip not found"
        }, 404

    trip["_id"] = str(trip["_id"])
    trip["id"] = trip["_id"]

    return trip, 200


# ✏️ UPDATE TRIP
def update_trip(data):

    trip_id = data.get("id")

    if not trip_id:
        return {
            "success": False,
            "message": "Trip ID is required"
        }, 400

    try:
        obj_id = ObjectId(trip_id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    update_data = {
        k: v for k, v in data.items()
        if k != "id"
    }

    db["trips"].update_one(
        {"_id": obj_id},
        {"$set": update_data}
    )

    return {
        "success": True,
        "message": "Trip updated successfully"
    }, 200


# 🗑 DELETE TRIP
def delete_trip(data):

    trip_id = data.get("id")

    if not trip_id:
        return {
            "success": False,
            "message": "Trip ID is required"
        }, 400

    try:
        obj_id = ObjectId(trip_id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    db["trips"].delete_one({"_id": obj_id})

    return {
        "success": True,
        "message": "Trip deleted successfully"
    }, 200


# ❤️ TOGGLE FAVORITE
def toggle_favorite(id):

    try:
        obj_id = ObjectId(id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    trip = db["trips"].find_one({"_id": obj_id})

    if not trip:
        return {
            "success": False,
            "message": "Trip not found"
        }, 404

    current_value = trip.get("isFavorite", False)

    db["trips"].update_one(
        {"_id": obj_id},
        {
            "$set": {
                "isFavorite": not current_value
            }
        }
    )

    return {
        "success": True,
        "message": "Favorite updated",
        "isFavorite": not current_value
    }, 200


# 📌 TOGGLE PLANNED
def toggle_planned(id):

    try:
        obj_id = ObjectId(id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    trip = db["trips"].find_one({"_id": obj_id})

    if not trip:
        return {
            "success": False,
            "message": "Trip not found"
        }, 404

    current_value = trip.get("isPlanned", False)

    db["trips"].update_one(
        {"_id": obj_id},
        {
            "$set": {
                "isPlanned": not current_value
            }
        }
    )

    return {
        "success": True,
        "message": "Planned status updated",
        "isPlanned": not current_value
    }, 200


# 🔍 SEARCH TRIPS
def search_trips(query):

    query = query.lower()

    results = []

    for trip in db["trips"].find():

        title = trip.get("title", "").lower()
        location = trip.get("location", "").lower()

        if query in title or query in location:

            trip["_id"] = str(trip["_id"])
            trip["id"] = trip["_id"]

            results.append(trip)

    return {
        "success": True,
        "data": results
    }, 200

<<<<<<< HEAD
def toggle_planned(id):

    try:
        obj_id = ObjectId(id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    trip = db["trips"].find_one({"_id": obj_id})

    if not trip:
        return {
            "success": False,
            "message": "Trip not found"
        }, 404

    current_value = trip.get("isPlanned", False)

    db["trips"].update_one(
        {"_id": obj_id},
        {
            "$set": {
                "isPlanned": not current_value
            }
        }
=======

# 🔧 FIX OLD IMAGE FIELD
def fix_images_data():

    db["trips"].update_many(
        {"image": {"$exists": False}},
        {"$set": {"image": ""}}
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    )

    return {
        "success": True,
<<<<<<< HEAD
        "message": "Planned status updated",
        "isPlanned": not current_value
=======
        "message": "Images fixed successfully"
    }, 200


# ❤️ FIX OLD FAVORITES FIELD
def fix_favorites_data():

    db["trips"].update_many(
        {"isFavorite": {"$exists": False}},
        {"$set": {"isFavorite": False}}
    )

    return {
        "success": True,
        "message": "Favorites fixed successfully"
    }, 200


# 📌 FIX OLD PLANNED FIELD
def fix_planned_data():

    db["trips"].update_many(
        {"isPlanned": {"$exists": False}},
        {"$set": {"isPlanned": False}}
    )

    return {
        "success": True,
        "message": "Planned trips fixed successfully"
    }, 200
# 🌍 GET TRIPS BY CATEGORY
def get_trips_by_category(category_name):

    trips = []

    for trip in db["trips"].find({
        "category": category_name
    }):

        trip["_id"] = str(trip["_id"])
        trip["id"] = trip["_id"]

        trips.append(trip)

    return {
        "success": True,
        "data": trips
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    }, 200