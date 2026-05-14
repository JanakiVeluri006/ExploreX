from config.db import db
from bson import ObjectId
from datetime import datetime

# ➕ CREATE JOURNAL
def create_journal(data):
    user_id = data.get("user_id")
    trip_id = data.get("trip_id")
    title = data.get("title")
    content = data.get("content")
    if not user_id or not trip_id or not title or not content:
        return {
            "success": False,
            "message": "Missing required fields"
        }, 400
    result = db["journals"].insert_one({
        "user_id": user_id,
        "trip_id": trip_id,
        "title": title,
        "content": content,
        "created_at": datetime.utcnow()
    })
    return {
        "success": True,
        "message": "Journal created successfully",
        "id": str(result.inserted_id)
    }, 201

# Get all journals for a user
def get_user_journals(user_id):
    journals = []
    for journal in db["journals"].find({
        "user_id": user_id
    }).sort("created_at", -1):
        journal["_id"] = str(journal["_id"])
        journal["id"] = journal["_id"]
        journals.append(journal)
    return {
        "success": True,
        "data": journals
    }, 200

# Get journals for a specific trip
def get_trip_journals(user_id, trip_id):
    journals = []
    for journal in db["journals"].find({
        "user_id": user_id,
        "trip_id": trip_id
    }).sort("created_at", -1):
        journal["_id"] = str(journal["_id"])
        journal["id"] = journal["_id"]
        journals.append(journal)
    return {
        "success": True,
        "data": journals
    }, 200