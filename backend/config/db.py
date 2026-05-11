from pymongo import MongoClient

MONGO_URI = "mongodb+srv://janakiVarshitha:23b01a05i9j0@cluster0.m4qgitv.mongodb.net/?appName=Cluster0"

client = MongoClient(MONGO_URI, serverSelectionTimeoutMS=5000)

# print(client.list_database_names())  # Test connection and print database names 
db = client["explorex"]