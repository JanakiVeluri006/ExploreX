import 'package:flutter/material.dart';

class JournalDetailScreen extends StatelessWidget {

  final Map journal;
  final Map trip;

  const JournalDetailScreen({
    super.key,
    required this.journal,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: CustomScrollView(
        slivers: [

          // 🌄 BEAUTIFUL HEADER
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.deepPurple,

            flexibleSpace: FlexibleSpaceBar(

              title: Text(
                trip["location"] ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              background: Stack(
                fit: StackFit.expand,
                children: [

                  Image.network(
                    trip["image"],
                    fit: BoxFit.cover,
                  ),

                  Container(
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
                ],
              ),
            ),
          ),

          // 📄 BODY
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ✨ JOURNAL CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 14,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // ✍️ TITLE
                        Text(
                          journal["title"],

                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D1B69),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 📍 LOCATION
                        Row(
                          children: [

                            const Icon(
                              Icons.location_on,
                              color: Colors.deepPurple,
                              size: 20,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              trip["location"],

                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // 🕒 DATE
                        Row(
                          children: [

                            const Icon(
                              Icons.access_time,
                              size: 18,
                              color: Colors.grey,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              journal["created_at"],

                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // 📖 HEADING
                        const Text(
                          "Travel Memory ✨",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D1B69),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 📄 CONTENT
                        Text(
                          journal["content"],

                          style: const TextStyle(
                            fontSize: 17,
                            height: 1.8,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ✏️ ACTION BUTTONS
                  Row(
                    children: [

                      SizedBox(
                        width: 200,
                        child: ElevatedButton.icon(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          onPressed: () {
                            // TODO: Edit Journal
                          },

                          icon: const Icon(Icons.edit),

                          label: const Text(
                            "Edit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      SizedBox(
                        width: 200,
                        child: ElevatedButton.icon(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          onPressed: () {
                            // TODO: Delete Journal
                          },

                          icon: const Icon(Icons.delete),

                          label: const Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}