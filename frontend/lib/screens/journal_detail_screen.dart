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

      appBar: AppBar(
        title: const Text("Travel Memory"),
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // 🌄 IMAGE
            Image.network(
              trip["image"],

              width: double.infinity,
              height: 250,

              fit: BoxFit.cover,
            ),

            Padding(

              padding:
                  const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // ✍️ TITLE
                  Text(

                    journal["title"],

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 📍 LOCATION
                  Text(

                    "📍 ${trip["location"]}",

                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // 🕒 DATE
                  Text(

                    journal["created_at"],

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 📖 CONTENT
                  Text(

                    journal["content"],

                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.6,
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