// UI for editing and existing Trip
//  Updates trip via API and navigates back to details page on success.

import 'package:flutter/material.dart';
import '../services/trip_service.dart';
import '../theme/app_colors.dart'; 

class EditTripScreen extends StatefulWidget {
  final Map trip;

  const EditTripScreen({super.key, required this.trip});

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController daysController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.trip["title"] ?? "");
    locationController = TextEditingController(text: widget.trip["location"] ?? "");
    daysController = TextEditingController(
      text: widget.trip["days"].toString(),
    );
  }

  // ✅ Beautiful input field
  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ✅ Update API
  Future<void> updateTrip() async {
    try {
      final success = await TripService.updateTrip({
        "id": widget.trip["id"],
        "title": titleController.text,
        "location": locationController.text,
        "days": int.tryParse(daysController.text) ?? 0,
      });

      if (success) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Trip updated successfully ✨"),
            duration: Duration(seconds: 1),
          ),
        );

        await Future.delayed(
          const Duration(seconds: 1),
        );

        Navigator.pop(context);
      }

    } catch (e) {
      print("UPDATE ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Edit Trip", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              buildTextField("Title", titleController),
              buildTextField("Location", locationController),
              buildTextField("Days", daysController),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: updateTrip,
                child: const Text(
                  "Update Trip",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}