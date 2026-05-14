// Handles all trip-related API calls (CRUD Operations)
//  Used by UI screens to interact with backend for fetching, creating, and updating trips.

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class TripService {
  static const String baseUrl = "http://localhost:5000";
  static Future<List> getTrips() async {
    final user = FirebaseAuth.instance.currentUser;
    final response = await http.get( Uri.parse("http://localhost:5000/get-trips?user_id=${user?.uid}"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["data"] ?? [];
    }
    return [];
  }

// ✏️ Create trip
  static Future<bool> createTrip(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:5000/create-trip'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return response.statusCode == 201;
  } catch (e) {
    print("SERVICE CREATE ERROR: $e");
    return false;
  }
}

// ✏️ Update trip
static Future<bool> updateTrip(Map data) async {
  try {
    final response = await http.post(
      Uri.parse("http://localhost:5000/update-trip"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return response.statusCode == 200;
  } catch (e) {
    print("UPDATE SERVICE ERROR: $e");
    return false;
  }
}

// 🔍 Get single trip
static Future<Map<String, dynamic>?> getTrip(String id) async {
  try {
    final response = await http.get(
      Uri.parse("http://localhost:5000/get-trip/$id"),
    );
    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(
        jsonDecode(response.body),
      );
    }
  } catch (e) {
    print("GET TRIP ERROR: $e");
  }
  return null;
}

// 🗑 Delete trip
static Future<bool> deleteTrip(String id) async {
  try {
    final response = await http.post(
      Uri.parse("http://localhost:5000/delete-trip"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}),
    );
    return response.statusCode == 200;
  } catch (e) {
    print("DELETE SERVICE ERROR: $e");
    return false;
  }
}

// 🔍 Search trips
static Future<List> searchTrips(String query) async {
  try {
    final response = await http.get(
      Uri.parse("http://localhost:5000/search-trips?q=$query"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"] ?? [];
    }
  } catch (e) {
    print("SEARCH ERROR: $e");
  }
  return [];
}

// ❤️ Toggle favorite
static Future<bool> toggleFavorite(String tripId) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final response = await http.post(
      Uri.parse("$baseUrl/toggle-favorite"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": user.uid,
        "trip_id": tripId,
      }),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data["isFavorite"];
    }
    return false;
  } catch (e) {
    print("TOGGLE FAVORITE ERROR: $e");
    return false;
  }
}

// 📅 Toggle planned
static Future<bool> togglePlanned(String tripId) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final response = await http.post(
      Uri.parse("$baseUrl/toggle-planned"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": user.uid,
        "trip_id": tripId,
      }),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data["isPlanned"];
    }
    return false;
  } catch (e) {
    print("TOGGLE PLANNED ERROR: $e");
    return false;
  }
}

}