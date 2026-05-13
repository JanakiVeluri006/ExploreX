// Entry Point of the App
// Loads the initial screen (TripListPage) which shows the list of trips and allows navigation to AddTripPage.
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/trip_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth/register_screen.dart';
=======
// import 'screens/trip_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'screens/auth/register_screen.dart';
>>>>>>> backend-dev
import 'screens/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}