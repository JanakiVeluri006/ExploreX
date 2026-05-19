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

# 📚 GET ALL JOURNALS OF USER
def get_all_journals(user_id):
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

# 📖 GET JOURNALS OF SPECIFIC TRIP
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

# ✏️ UPDATE JOURNAL
def update_journal(data):
    try:
        journal_id = data.get("id")
        user_id = data.get("user_id")
        title = data.get("title")
        content = data.get("content")
        if not journal_id or not user_id:
            return {
                "success": False,
                "message": "Missing required fields"
            }, 400
        result = db["journals"].update_one(
            {
                "_id": ObjectId(journal_id),
                "user_id": user_id
            },
            {
                "$set": {
                    "title": title,
                    "content": content
                }
            }
        )
        if result.modified_count == 0:
            return {
                "success": False,
                "message": "Journal not found or unauthorized"
            }, 404
        return {
            "success": True,
            "message": "Journal updated successfully"
        }, 200
    except Exception as e:
        return {
            "success": False,
            "message": str(e)
        }, 500
    
# 🗑 DELETE JOURNAL
def delete_journal(data):

    try:

        journal_id = data.get("id")
        user_id = data.get("user_id")

        if not journal_id or not user_id:

            return {
                "success": False,
                "message": "Missing required fields"
            }, 400

        result = db["journals"].delete_one({

            "_id": ObjectId(journal_id),
            "user_id": user_id

        })

        if result.deleted_count == 0:

            return {
                "success": False,
                "message": "Journal not found or unauthorized"
            }, 404

        return {
            "success": True,
            "message": "Journal deleted successfully"
        }, 200

    except Exception as e:

        return {
            "success": False,
            "message": str(e)
        }, 500