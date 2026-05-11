// UI for creating a new Trip
// Collects user inputs and sends data to TripService to create a new trip.
// Uses PlaceService to fetch an image based on location.

import 'package:flutter/material.dart';
import '../services/trip_service.dart';
import '../services/place_service.dart';
import '../theme/app_colors.dart'; 

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final daysController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  Future<void> createTrip() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final days = int.tryParse(daysController.text);
    setState(() {
      isLoading = true;
    });

  try {
    final location = locationController.text;

    final imageUrl = await PlaceService.fetchPlaceImage(location);

    final success = await TripService.createTrip({
      "title": titleController.text,
      "location": location,
      "days": days,
      "image": imageUrl ?? "",
      "description": descriptionController.text,
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Trip created successfully 🎉"),
          duration: Duration(seconds: 1),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
  }

  } catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Something went wrong ❌"),
    ),
  );
}

  setState(() {
    isLoading = false;
  });
}

  Widget buildTextField(
  String label,
  TextEditingController controller, {
  TextInputType type = TextInputType.text,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),

    child: TextFormField(
      controller: controller,
      keyboardType: type,

      validator: (value) {

        // ✅ Empty check
        if (value == null || value.trim().isEmpty) {
          return "$label is required";
        }

        // 📍 Location validation
        if (label == "Location") {

          final locationRegex = RegExp(r'^[a-zA-Z\s]+$');

          if (!locationRegex.hasMatch(value.trim())) {
            return "Only letters and spaces allowed";
          }
        }

        // ⏳ Days validation
        if (label == "Days") {

          final days = int.tryParse(value);
          if (days == null) {
            return "Enter a valid number";
          }
          if (days <= 0) {
            return "Days must be greater than 0";
          }
        }

        return null;
      },

      decoration: InputDecoration(
        labelText: label,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Trip")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create New Trip ✈️",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Form(
                  key: _formKey,
                    child: Column(
                      children: [
                        buildTextField("Trip Title", titleController),
                        buildTextField("Location", locationController),
                        buildTextField("Days", daysController, type: TextInputType.number),
                        buildTextField("Description", descriptionController),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: isLoading ? null : createTrip,
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("Create Trip", style: AppTextStyles.lightTitle),
                        ),
                      ],
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