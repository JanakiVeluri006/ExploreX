from config.db import db
from bson import ObjectId
from datetime import datetime


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

    return {
        "success": True,
        "message": "Journal created successfully",
        "id": str(result.inserted_id)
    }, 201


# 📥 GET ALL JOURNALS
def get_all_journals():

    journals = []

    for journal in db["journals"].find():

        journal["_id"] = str(journal["_id"])
        journal["id"] = journal["_id"]

        journals.append(journal)

    return {
        "success": True,
        "data": journals
    }, 200


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
    }, 200