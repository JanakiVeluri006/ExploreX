import 'package:flutter/material.dart';
import 'edit_trip_screen.dart';
import '../services/trip_service.dart';
import '../theme/app_colors.dart'; 
import 'journal_screen.dart';

class TripDetailsScreen extends StatefulWidget {
  final String tripId;
  
  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  Map<String, dynamic>? trip;
  bool isEditingDescription = false;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    fetchTrip();
  }

  // ✅ FETCH TRIP
  Future<void> fetchTrip() async {
    final data = await TripService.getTrip(widget.tripId);

    if (data != null) {
      setState(() {
        trip = data;
        descriptionController = TextEditingController(
                                  text: trip!["description"] ?? "",
                                );
      });
    }
  }

  // ✅ DELETE TRIP
Future<void> deleteTrip() async {
  try {
    final success = await TripService.deleteTrip(widget.tripId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Trip deleted successfully 🗑️"),
          duration: Duration(seconds: 1),
        ),
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      Navigator.pop(context, true);
    }
  } catch (e) {
    print("DELETE ERROR: $e");
  }
}

Future<void> updateDescription() async {

  try {

    final success =
        await TripService.updateTrip({

      "id": trip!["id"],

      "description":
          descriptionController.text,
    });

    if (success) {

      setState(() {

        trip!["description"] =
            descriptionController.text;

        isEditingDescription = false;
      });
    }

  } catch (e) {
    print("DESCRIPTION UPDATE ERROR: $e");
  }
}

Future<void> toggleFavorite() async {

  try {

    final success =
        await TripService.toggleFavorite(
          widget.tripId,
        );

    if (success) {

      setState(() {

        trip!["isFavorite"] =
            !(trip!["isFavorite"] ?? false);
      });
    }

  } catch (e) {
    print("FAVORITE ERROR: $e");
  }
}

Future<void> togglePlanned() async {

  try {

    final success =
        await TripService.togglePlanned(
          widget.tripId,
        );

    if (success) {

      setState(() {

        trip!["isPlanned"] =
            !(trip!["isPlanned"] ?? false);
      });
    }

  } catch (e) {
    print("PLANNED ERROR: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    if (trip == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(trip!["title"] ?? "", style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
        actions: [
          // ✏️ EDIT
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white,),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTripScreen(trip: trip!),
                ),
              );

              // 🔄 Refresh after edit
              fetchTrip();
            },
          ),

          // 🗑 DELETE
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white,),
            onPressed: () async {

              final confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Trip"),
                  content: const Text(
                    "Are you sure you want to delete this trip?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                deleteTrip();
              }
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌄 IMAGE BANNER
            SizedBox(
              height: 260,
              width: double.infinity,
              child: Stack(
                children: [
                  // 🌄 IMAGE
                  Positioned.fill(
                    child: Image.network(
                      (trip!["image"] != null &&
                              trip!["image"] != "")
                          ? trip!["image"]
                          : "https://picsum.photos/seed/${trip!["location"]}/800/600",
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // 🌑 GRADIENT OVERLAY
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ Colors.transparent,Colors.black87 ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // ❤️📌 FLOATING ACTIONS
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      children: [
                        // ❤️ FAVORITE
                        GestureDetector(
                          onTap: toggleFavorite,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                            child: Icon(
                              trip!["isFavorite"] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  trip!["isFavorite"] == true
                                      ? Colors.red
                                      : Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // 📌 PLANNED
                        GestureDetector(
                          onTap: togglePlanned,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),

                            child: Icon(

                              trip!["isPlanned"] == true
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,

                              color:
                                  trip!["isPlanned"] == true
                                      ? Colors.amber
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✨ TITLE OVER IMAGE
                  Positioned(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip!["title"] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  // Text(
                  //   "⏳ ${trip!["days"] ?? 0} days",
                  //   style: const TextStyle(fontSize: 16),
                  // ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${trip!["days"] ?? 0} Days",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                trip!["location"] ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 📝 DESCRIPTION
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        "About this trip ✨",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          isEditingDescription ? Icons.close : Icons.edit,
                        ),
                        onPressed: () {
                          setState(() {
                            isEditingDescription = !isEditingDescription;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  if (isEditingDescription) ...[
                    TextField(
                      controller: descriptionController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText:
                            "Write about this trip...",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: updateDescription,
                          child: const Text("Save"),
                        ),

                        const SizedBox(width: 10),

                        TextButton(
                          onPressed: () {
                            setState(() {
                              isEditingDescription = false;
                              descriptionController.text =
                                  trip!["description"] ?? "";
                            });
                          },

                          child: const Text("Cancel"),
                        ),
                      ],
                    ),

                  ] else ...[
                    Text(
                      (trip?["description"] ?? "").toString().trim().isNotEmpty
                          ? trip!["description"] : "No description added yet.",

                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 20),

                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => JournalScreen(
                                  tripId: trip!["id"],
                                  tripTitle: trip!["title"],
                                ),
                              ),
                            );
                          },

                          icon: const Icon(Icons.menu_book),

                          label: const Text(
                            "Travel Memory Book",
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}