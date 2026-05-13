import 'package:firebase_auth/firebase_auth.dart';

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

      return credential.user;

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