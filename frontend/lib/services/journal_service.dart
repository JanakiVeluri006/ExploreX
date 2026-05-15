import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class JournalService {
  static const String baseUrl = "http://127.0.0.1:5000";
  // 📝 Create Journal
  static Future<bool> createJournal({
    required String tripId,
    required String title,
    required String content,

  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      final response = await http.post(
        Uri.parse("$baseUrl/create-journal"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "user_id": user.uid,
          "trip_id": tripId,
          "title": title,
          "content": content,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      print("CREATE JOURNAL ERROR: $e");
      return false;
    }
  }

  // 📖 Get Trip Journals
  static Future<List<dynamic>> getTripJournals(String tripId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];
      final response = await http.get(
        Uri.parse(
          "$baseUrl/get-trip-journals/${user.uid}/$tripId",
        ),
      );
      if (response.statusCode == 200) {
        final data =
            jsonDecode(response.body);
        return data["data"];
      }
      return [];
    } catch (e) {
      print("GET JOURNALS ERROR: $e");
      return [];
    }
  }

  // 📚 Get all journals of user
static Future<List<dynamic>> getUserJournals() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];
      final response = await http.get(
        Uri.parse("$baseUrl/get-journals/${user.uid}"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"];
      }
      return [];
    } catch (e) {
      print("GET USER JOURNALS ERROR: $e");
      return [];
    }
  }
}