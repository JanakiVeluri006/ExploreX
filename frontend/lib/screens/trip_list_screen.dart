import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/trip_service.dart';
import 'trip_details_screen.dart';
import 'add_trip_screen.dart';
import '../theme/app_colors.dart';

class TripListPage extends StatefulWidget {
  const TripListPage({super.key});

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  List trips = [];
  List filteredTrips = [];
  Set<String> favoriteIds = <String>{};

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      final data = await TripService.getTrips();
      setState(() {
        trips = data;
        filteredTrips = data; // baseline shows all
      });
    } catch (e) {
      print("FETCH ERROR: $e");
    }
  }

Future<void> toggleFavorite(String id) async {
  try {
    final response = await http.post(
      Uri.parse("http://localhost:5000/toggle-favorite/$id"),
    );

    if (response.statusCode == 200) {
      fetchTrips(); // refresh UI
    }
  } catch (e) {
    print("FAVORITE ERROR: $e");
  }
}

Future<void> togglePlanned(String id) async {

  try {

    final response = await http.post(
      Uri.parse(
        "http://localhost:5000/toggle-planned/$id",
      ),
    );

    if (response.statusCode == 200) {
      fetchTrips();
    }

  } catch (e) {
    print("PLANNED ERROR: $e");
  }
}

  String getImage(trip) {
    if (trip["image"] != null && trip["image"] != "") {
      return trip["image"];
    }
    final location = trip["location"] ?? "travel";
    return "https://picsum.photos/seed/$location/600/400";
  }

Widget buildCategoryChip(String label) {

  return Container(
    margin: const EdgeInsets.only(right: 12),

    padding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 10,
    ),

    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(30),

      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),

    child: Center(
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    //final favoriteTrips = trips.where((trip) => trip["isFavorite"] == true).toList();
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ExploreX ✈️", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                       Text("Discover your next journey ✨",
                           style: AppTextStyles.lightSubtitle),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, animation, secondaryAnimation) =>
                  const AddTripPage(),

              transitionsBuilder:
                  (_, animation, secondaryAnimation, child) {

                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          fetchTrips();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 10),

          // 🔍 SEARCH BAR (always visible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (q) async {

                // if search empty → show all trips again
                if (q.trim().isEmpty) {
                  setState(() {
                    filteredTrips = trips;
                  });
                  return;
                }

                try {
                  final results = await TripService.searchTrips(q);

                  setState(() {
                    filteredTrips = results;
                  });

                } catch (e) {
                  print("SEARCH UI ERROR: $e");
                }
              },
              decoration: InputDecoration(
                hintText: "Search trips...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          // 🌍 CATEGORY CHIPS
          /*SizedBox(
            height: 50,

            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),

              children: [

                buildCategoryChip("🛕 Spiritual"),
                buildCategoryChip("🏔 Mountains"),
                buildCategoryChip("🌊 Beaches"),
                buildCategoryChip("🏰 Historical"),
                buildCategoryChip("🚵 Adventure"),
                buildCategoryChip("🌿 Nature"),

              ],
            ),
          ),
          */
          const SizedBox(height: 10),

          // 🔥 THIS PART HANDLES EMPTY STATE
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchTrips,
            child: filteredTrips.isEmpty
                ? Center(
                    child: Text(
                      trips.isEmpty
                          ? "No trips added yet.. \nStart Exploring! 🌍"
                          : "Oops! No results found.. \nTry Another Destination!  🌍",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.darkSubtitle,
                    ),
                  )
                : ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Explore Destinations...", style: AppTextStyles.darkTitle),
                      ),

                      SizedBox(height: 10),
                      // 🌍 ALL TRIPS CAROUSEL
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredTrips.length,

                          itemBuilder: (context, index) {

                            final trip = filteredTrips[index];

                            return _TripCard(
                              trip: trip,
                              image: getImage(trip),

                              isFavorite: trip["isFavorite"] == true,
                              isPlanned: trip["isPlanned"] == true,

                              onFavoriteToggle: () =>
                                  toggleFavorite(trip["id"]),
                              onPlannedToggle: () =>
                                  togglePlanned(trip["id"]),

                              onTap: () async {

                                final tripId =
                                    (trip["id"] ?? trip["_id"]).toString();

                                final result = await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, animation, secondaryAnimation) =>
                                        TripDetailsScreen(
                                          tripId: tripId,
                                        ),

                                    transitionsBuilder:
                                        (_, animation, secondaryAnimation, child) {

                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );

                                if (result == true) {
                                  fetchTrips();
                                }
                              },
                            );
                          },
                        ),
                      ),

                      // ❤️ FAVORITES SECTION
                      if (filteredTrips
                          .where((trip) => trip["isFavorite"] == true)
                          .isNotEmpty) ...[

                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
                          child: Text(
                            "Favorites ❤️",
                            style: AppTextStyles.darkTitle,
                          ),
                        ),

                        SizedBox(
                          height: 150,

                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),

                            itemCount: filteredTrips
                                .where((trip) =>
                                    trip["isFavorite"] == true)
                                .length,

                            itemBuilder: (context, index) {

                              final favoriteTrips = filteredTrips
                                  .where((trip) =>
                                      trip["isFavorite"] == true)
                                  .toList();

                              final trip = favoriteTrips[index];

                              return _TripCard(
                                trip: trip,
                                image: getImage(trip),

                                isFavorite: trip["isFavorite"] == true,
                                isPlanned: trip["isPlanned"] == true,

                                onFavoriteToggle: () => toggleFavorite(trip["id"]),
                                onPlannedToggle: () => togglePlanned(trip["id"]),
                                onTap: () async {

                                  final tripId =
                                      (trip["id"] ?? trip["_id"])
                                          .toString();

                                  final result =
                                      await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          TripDetailsScreen(
                                            tripId: tripId,
                                          ),
                                    ),
                                  );

                                  if (result == true) {
                                    fetchTrips();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    
                      // 📌 FUTURE TRIPS SECTION
                        if (filteredTrips
                            .where((trip) => trip["isPlanned"] == true)
                            .isNotEmpty) ...[

                          const Padding(
                            padding: EdgeInsets.fromLTRB(16, 24, 16, 12),

                            child: Text(
                              "Future Trips 📌",
                              style: AppTextStyles.darkTitle,
                            ),
                          ),

                          SizedBox(
                            height: 150,

                            child: ListView.builder(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),

                              itemCount: filteredTrips
                                  .where((trip) =>
                                      trip["isPlanned"] == true)
                                  .length,

                              itemBuilder: (context, index) {

                                final plannedTrips = filteredTrips
                                    .where((trip) =>
                                        trip["isPlanned"] == true)
                                    .toList();

                                final trip = plannedTrips[index];

                                return _TripCard(

                                  trip: trip,
                                  image: getImage(trip),

                                  isFavorite:
                                      trip["isFavorite"] == true,

                                  onFavoriteToggle: () =>
                                      toggleFavorite(trip["id"]),

                                  isPlanned:
                                      trip["isPlanned"] == true,

                                  onPlannedToggle: () =>
                                      togglePlanned(trip["id"]),

                                  onTap: () async {

                                    final tripId =
                                        (trip["id"] ?? trip["_id"])
                                            .toString();

                                    final result =
                                        await Navigator.push(

                                      context,

                                      MaterialPageRoute(
                                        builder: (_) =>
                                            TripDetailsScreen(
                                              tripId: tripId,
                                            ),
                                      ),
                                    );

                                    if (result == true) {
                                      fetchTrips();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],

                    ],
                  ),
          )
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatefulWidget {
  final dynamic trip;
  final String image;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final bool isPlanned;
  final VoidCallback onPlannedToggle;

  const _TripCard({
    required this.trip,
    required this.image,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.isPlanned,
    required this.onPlannedToggle,
  });

  @override
  State<_TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<_TripCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered
            ? Matrix4.translationValues(0, -6, 0)
            : Matrix4.identity(),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 260,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [

                  // 🌄 Image
                  Positioned.fill(
                    child:Image.network(
                      widget.image,
                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],

                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },

                      loadingBuilder: (
                        context,
                        child,
                        loadingProgress,
                      ) {

                        if (loadingProgress == null) {
                          return child;
                        }

                        return Container(
                          color: Colors.grey[200],

                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),

                  // 🌑 Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // ❤️ Favorite button (TOP RIGHT)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: widget.onFavoriteToggle,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorite ? Colors.red : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                    // 📅 Planned button (TOP LEFT) 
                    Positioned(
                      top: 55,
                      right: 10,

                      child: GestureDetector(

                        onTap: widget.onPlannedToggle,

                        child: Container(

                          padding: const EdgeInsets.all(6),

                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Icon(
                            widget.isPlanned
                                ? Icons.bookmark
                                : Icons.bookmark_border,

                            color:
                                widget.isPlanned
                                    ? Colors.amber
                                    : Colors.white,

                            size: 20,
                          ),
                        ),
                      ),
                    ),

                  // 📝 Bottom text
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.trip["title"] ?? "",
                          style: AppTextStyles.lightTitle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.trip["location"] ?? "",
                          style: AppTextStyles.lightSubtitle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}