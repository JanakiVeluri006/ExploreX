from config.db import db


def create_user(data):

    firebase_uid = data.get("firebase_uid")
    email = data.get("email")

    if not firebase_uid or not email:

        return {
            "success": False,
            "message": "Missing required fields"
        }, 400

    existing_user = db["users"].find_one({
        "firebase_uid": firebase_uid
    })

    if existing_user:

        return {
            "success": True,
            "message": "User already exists"
        }, 200

    db["users"].insert_one({
        "firebase_uid": firebase_uid,
        "email": email,
    })

    return {
        "success": True,
        "message": "User created successfully"
    }, 201