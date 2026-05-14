from config.db import db
from bson import ObjectId


def toggle_planned(data):

    user_id = data.get("user_id")
    trip_id = data.get("trip_id")

    if not user_id or not trip_id:

        return {
            "success": False,
            "message": "Missing required fields"
        }, 400

    existing_plan = db["planned_trips"].find_one({
        "user_id": user_id,
        "trip_id": trip_id
    })

    # ❌ Remove planned
    if existing_plan:

        db["planned_trips"].delete_one({
            "_id": existing_plan["_id"]
        })

        return {
            "success": True,
            "message": "Removed from planned",
            "isPlanned": False
        }, 200

    # ✅ Add planned
    db["planned_trips"].insert_one({
        "user_id": user_id,
        "trip_id": trip_id
    })

    return {
        "success": True,
        "message": "Added to planned",
        "isPlanned": True
    }, 201


def get_user_planned(user_id):

    planned = db["planned_trips"].find({
        "user_id": user_id
    })

    trip_ids = []

    for item in planned:
        trip_ids.append(ObjectId(item["trip_id"]))

    trips = []

    for trip in db["trips"].find({
        "_id": {"$in": trip_ids}
    }):

        trip["_id"] = str(trip["_id"])
        trip["id"] = trip["_id"]
        trip["isPlanned"] = True

        trips.append(trip)

    return {
        "success": True,
        "data": trips
    }, 200