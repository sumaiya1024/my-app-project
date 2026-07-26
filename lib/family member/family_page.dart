import 'package:flutter/material.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  // ফ্যামিলি মেম্বারদের ডেটা (এটি আপনি পরবর্তীতে API থেকে আনতে পারবেন)
  final List<Map<String, String>> familyMembers = const [
    {"name": "Zilan Hasnath", "relation": "Son", "status": "Active"},
    {"name": "Fatema Begum", "relation": "Mother", "status": "Active"},
    {"name": "Sami Ahmed", "relation": "Brother", "status": "Away"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Members"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: familyMembers.length,
        itemBuilder: (context, index) {
          final member = familyMembers[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(member['name']!),
              subtitle: Text("${member['relation']} • ${member['status']}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // মেম্বারের ডিটেইলসে যাওয়ার জন্য নেভিগেশন
              },
            ),
          );
        },
      ),
      // নতুন মেম্বার যোগ করার বাটন
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // মেম্বার যোগ করার ফাংশন
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
