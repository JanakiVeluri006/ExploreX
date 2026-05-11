// Entry Point of the App
// Loads the initial screen (TripListPage) which shows the list of trips and allows navigation to AddTripPage.
import 'package:flutter/material.dart';
import 'screens/trip_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TripListPage(),
    );
  }
}