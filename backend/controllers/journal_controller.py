from config.db import db
from bson import ObjectId
from datetime import datetime

<<<<<<< HEAD
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
=======

# ➕ CREATE JOURNAL
def create_journal(data):

    trip_id = data.get("trip_id")
    title = data.get("title")
    content = data.get("content")
    image = data.get("image", "")

    if not trip_id or not title or not content:
        return {
            "success": False,
            "message": "All fields are required"
        }, 400

    result = db["journals"].insert_one({
        "trip_id": trip_id,
        "title": title,
        "content": content,
        "image": image,
        "created_at": datetime.now()
    })

>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    return {
        "success": True,
        "message": "Journal created successfully",
        "id": str(result.inserted_id)
    }, 201

<<<<<<< HEAD
# Get all journals for a user
def get_user_journals(user_id):
    journals = []
    for journal in db["journals"].find({
        "user_id": user_id
    }).sort("created_at", -1):
        journal["_id"] = str(journal["_id"])
        journal["id"] = journal["_id"]
        journals.append(journal)
=======

# 📥 GET ALL JOURNALS
def get_all_journals():

    journals = []

    for journal in db["journals"].find():

        journal["_id"] = str(journal["_id"])
        journal["id"] = journal["_id"]

        journals.append(journal)

>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    return {
        "success": True,
        "data": journals
    }, 200

<<<<<<< HEAD
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
=======

# 🗑 DELETE JOURNAL
def delete_journal(data):

    journal_id = data.get("id")

    if not journal_id:
        return {
            "success": False,
            "message": "Journal ID is required"
        }, 400

    try:
        obj_id = ObjectId(journal_id)
    except:
        return {
            "success": False,
            "message": "Invalid ID"
        }, 400

    db["journals"].delete_one({"_id": obj_id})

    return {
        "success": True,
        "message": "Journal deleted successfully"
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
    }, 200