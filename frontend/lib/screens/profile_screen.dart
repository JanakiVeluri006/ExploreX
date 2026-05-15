import 'package:flutter/material.dart';
<<<<<<< HEAD

class ProfileScreen extends StatelessWidget {

  final List trips;

  ProfileScreen({super.key, required this.trips});

=======
import '../services/journal_service.dart';
//import 'journal_screen.dart';
import 'journal_detail_screen.dart';
import 'trip_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  final List trips;
  const ProfileScreen({super.key, required this.trips});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
>>>>>>> frontend-dev
  final Map<String, String> user = {
    "name": "Traveler",
    "bio": "Seeking stories across Bharat ✨",
    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREVluEKIh35maMSougzs5yDZLcu3W-veUaGg&s",
  };
<<<<<<< HEAD

  @override
  Widget build(BuildContext context) {
    final favoriteTrips = trips.where((trip) => trip["isFavorite"] == true).toList();
    final plannedTrips = trips.where((trip) => trip["isPlanned"] == true).toList();//trips.take(4).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),

=======
  List journals = [];
  bool isLoadingJournals = true;
  @override
  void initState() {
    super.initState();
    fetchJournals();
  }

  Future<void> fetchJournals() async {
    final data = await JournalService.getUserJournals();
    setState(() {
      journals = data;
      isLoadingJournals = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteTrips = widget.trips.where((trip) => trip["isFavorite"] == true).toList();
    final plannedTrips = widget.trips.where((trip) => trip["isPlanned"] == true).toList();
    final recentJournals = journals.take(3).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.deepPurpleAccent[400],
        foregroundColor: Colors.white,
      ),
>>>>>>> frontend-dev
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD

              // 👤 PROFILE HEADER
=======
              // 👤 PROFILE IMAGE
>>>>>>> frontend-dev
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user["image"]!),
                ),
              ),

              const SizedBox(height: 16),

<<<<<<< HEAD
              // 👤 USERNAME
              Center(
                child: Text(
                  user["name"]!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
=======
              // 👤 NAME
              Center(
                child: Text(
                  user["name"]!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
>>>>>>> frontend-dev
                ),
              ),

              const SizedBox(height: 8),

              // ✨ BIO
              Center(
                child: Text(
                  user["bio"]!,
<<<<<<< HEAD
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
=======

                  textAlign:
                      TextAlign.center,

                  style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
>>>>>>> frontend-dev
                ),
              ),

              const SizedBox(height: 30),

<<<<<<< HEAD
              // 📊 STATS ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StatCard(title: "Planned", value: "12"),
                    _StatCard(title: "Favorites", value: "8"),
                    _StatCard(title: "Journals", value: "4"),
                  ],
              ),

              const SizedBox(height: 40),

              const Text(
                "Favorite Destinations ❤️",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 200,

                child: favoriteTrips.isEmpty
                    ? const Center(
                        child: Text(
                          "No favorites yet 🌍",
                        ),
                      )

                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: favoriteTrips.length,

                        itemBuilder: (context, index) {

                          final trip = favoriteTrips[index];

                          return Container(
                            width: 320, height: 160,
                            margin: const EdgeInsets.only(right: 16),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                              image: DecorationImage(
                                image: NetworkImage(
                                  trip["image"],
                                ),
=======
              // 📊 STATS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatCard(title: "Planned Trips", value: plannedTrips.length.toString()),
                  _StatCard(title: "Favorites", value :favoriteTrips.length.toString()),
                  _StatCard(title: "Journals", value: journals.length.toString()),
                ],
              ),

              const SizedBox(height: 40),
              
                // ❤️ FAVORITES
                const Text(
                  "Favorite Destinations ❤️",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 250,
                  child: favoriteTrips.isEmpty
                      ? const Center(
                          child: Text("No favorites yet 🌍"),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: favoriteTrips.length,
                          itemBuilder: (context, index) {
                            final trip = favoriteTrips[index];
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TripDetailsScreen(tripId: trip["id"]),
                                  ),
                                );
                              },

                              child: Container(
                                height: 160,
                                width: 320,
                                margin: const EdgeInsets.only(right: 16),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(trip["image"]), fit: BoxFit.cover,
                                  ),
                                ),

                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [Colors.transparent, Colors.black87],
                                      begin: Alignment.topCenter, 
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),

                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      trip["location"] ?? "",
                                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 40),

                // 📌 PLANNED
                const Text(
                  "Planned Journeys 📌",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                Column(
                  children: plannedTrips.map((trip) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TripDetailsScreen(tripId: trip["id"]),
                          ),
                        );
                      },

                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(18)),

                        child: Row(
                          children: [
                            // 🌄 IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                trip["image"],
                                width: 280,
                                height: 140,
>>>>>>> frontend-dev
                                fit: BoxFit.cover,
                              ),
                            ),

<<<<<<< HEAD
                            child: Container(
                              padding: const EdgeInsets.all(12),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black87,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),

                              child: Align(
                                alignment: Alignment.bottomLeft,

                                child: Text(
                                  trip["location"] ?? "",

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Planned Journeys 📌",
=======
                            const SizedBox(width: 16),

                            // 📄 INFO
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trip["location"] ?? "",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    "${trip["days"]} days planned",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              
              const SizedBox(height: 40),

              // ✍️ JOURNALS
              const Text(
                "Travel Journals ✍️",
>>>>>>> frontend-dev
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

<<<<<<< HEAD
              Column(
                children: plannedTrips.map((trip) {

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18)),

                    child: Row(
                      children: [

                        // 🌄 IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(trip["image"], width: 300, height: 150, fit: BoxFit.cover),
                        ),

                        const SizedBox(width: 16),

                        // 📄 TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                trip["location"] ?? "",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "${trip["days"]} days planned",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      )
=======
              isLoadingJournals
                  ? const Center(child: CircularProgressIndicator())
                  : recentJournals.isEmpty
                      ? const Center(child: Text("No memories recorded yet ✨"))
                      : Column(
                          children: recentJournals.map((journal) {
                            final matchingTrip = widget.trips.firstWhere(
                              (trip) =>
                                  trip["id"] == journal["trip_id"],
                              orElse: () => {},
                            );
                            if (matchingTrip.isEmpty) {
                              return const SizedBox();
                            }
                            final preview = journal["content"].length >80 ? 
                                "${journal["content"].substring(0, 80)}..." : journal["content"];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => JournalDetailScreen(
                                      journal: journal,
                                      trip: matchingTrip,
                                    ),
                                  ),
                                );
                              },

                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🌄 IMAGE
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child:
                                        Image.network(
                                          matchingTrip["image"],
                                          width: 200,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                    ),
                                    const SizedBox(width: 16),
                                    // 📄 CONTENT
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            journal["title"],
                                            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "📍 ${matchingTrip["location"]}",
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            journal["created_at"],
                                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                          const SizedBox(height:8),
                                          Text(preview),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Read More →",
                                            style: TextStyle(color:Colors.blue, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
            ],
          ),
        ),
      ),
>>>>>>> frontend-dev
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
<<<<<<< HEAD

  const _StatCard({
    required this.title,
    required this.value,
  });
=======
  const _StatCard({required this.title, required this.value});
>>>>>>> frontend-dev

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
<<<<<<< HEAD
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
=======
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey)),
>>>>>>> frontend-dev
        ],
      ),
    );
  }
}