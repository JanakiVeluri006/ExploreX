// Handles all trip-related API calls (CRUD Operations)
//  Used by UI screens to interact with backend for fetching, creating, and updating trips.

import 'package:http/http.dart' as http;
import 'dart:convert';

class TripService {
  static Future<List> getTrips() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/get-trips'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["data"] ?? [];
    }

    return [];
  }

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

static Future<bool>
toggleFavorite(String id) async {

  try {

    final response = await http.post(
      Uri.parse(
        "http://localhost:5000/toggle-favorite/$id",
      ),
    );

    return response.statusCode == 200;

  } catch (e) {

    print("FAVORITE ERROR: $e");
    return false;
  }
}

static Future<bool>
togglePlanned(String id) async {

  try {

    final response = await http.post(
      Uri.parse(
        "http://localhost:5000/toggle-planned/$id",
      ),
    );

    return response.statusCode == 200;

  } catch (e) {

    print("PLANNED ERROR: $e");
    return false;
  }
}

}