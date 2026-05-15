import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  final List trips;

  ProfileScreen({super.key, required this.trips});

  final Map<String, String> user = {
    "name": "Traveler",
    "bio": "Seeking stories across Bharat ✨",
    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREVluEKIh35maMSougzs5yDZLcu3W-veUaGg&s",
  };

  @override
  Widget build(BuildContext context) {
    final favoriteTrips = trips.where((trip) => trip["isFavorite"] == true).toList();
    final plannedTrips = trips.where((trip) => trip["isPlanned"] == true).toList();//trips.take(4).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 👤 PROFILE HEADER
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user["image"]!),
                ),
              ),

              const SizedBox(height: 16),

              // 👤 USERNAME
              Center(
                child: Text(
                  user["name"]!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 8),

              // ✨ BIO
              Center(
                child: Text(
                  user["bio"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

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
                                fit: BoxFit.cover,
                              ),
                            ),

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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

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
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
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
        ],
      ),
    );
  }
}