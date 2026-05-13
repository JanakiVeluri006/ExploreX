from config.db import db
from bson import ObjectId

def create_trip(data):

    title = data.get("title")
    location = data.get("location")
    days = data.get("days")
    image = data.get("image", "")

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
        "isFavorite": False
    })

    return {
        "success": True,
        "message": "Trip created successfully",
        "id": str(result.inserted_id)
    }, 201

def get_all_trips():

    trips = []

    for trip in db["trips"].find():
        trip["_id"] = str(trip["_id"])
        trip["id"] = trip["_id"]
        trips.append(trip)

    return {
        "success": True,
        "data": trips
    }, 200

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

def fix_planned():

    db["trips"].update_many(
        {"isPlanned": {"$exists": False}},
        {"$set": {"isPlanned": False}}
    )

    return {
        "success": True,
        "message": "Planned field added to old trips"
    }, 200