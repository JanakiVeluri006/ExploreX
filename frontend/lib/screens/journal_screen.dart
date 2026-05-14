import 'package:flutter/material.dart';
import '../services/journal_service.dart';
import 'package:intl/intl.dart';

class JournalScreen extends StatefulWidget {

  final String tripId;
  final String tripTitle;

  const JournalScreen({
    super.key,
    required this.tripId,
    required this.tripTitle,
  });

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List journals = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchJournals();
  }

  Future<void> fetchJournals() async {
    final data = await JournalService.getTripJournals(widget.tripId);
    setState(() {
      journals = data;
      isLoading = false;
    });
  }

  Future<void> createJournal() async {

    final success = await JournalService.createJournal(
      tripId: widget.tripId,
      title: titleController.text.trim(),
      content: contentController.text.trim(),
    );

    if (success) {
      titleController.clear();
      contentController.clear();
      await fetchJournals();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Memory saved ✨"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.tripTitle} Journals"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Journal Title"),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Write your memory...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: createJournal,
              child: const Text("Save Memory"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : journals.isEmpty
                      ? const Center(
                          child: Text("No memories yet 📖"),
                        )
                      : ListView.builder(
                          itemCount: journals.length,
                          itemBuilder: (context, index) {
                            final journal = journals[index];
                            final createdAt = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parseUtc(journal["created_at"]).toLocal();
                            final formattedDate = DateFormat("dd MMM yyyy • hh:mm a").format(createdAt);
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      journal["title"],
                                      style:
                                          const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      formattedDate, style: const TextStyle(color: Colors.grey, fontSize: 12,),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(journal["content"]),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}