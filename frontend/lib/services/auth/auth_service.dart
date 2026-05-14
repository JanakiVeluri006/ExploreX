import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔐 REGISTER
  static Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential =
        await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        final response = await http.post(
          Uri.parse("http://127.0.0.1:5000/create-user"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "firebase_uid": user.uid,
            "email": user.email,
          }),
        );
        print(response.statusCode);
        print(response.body);
      }
      return user;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return null;
    }
  }

  // 🔑 LOGIN
  static Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential =
        await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return null;
    }
  }

  // 🚪 LOGOUT
  static Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // 👤 CURRENT USER
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}