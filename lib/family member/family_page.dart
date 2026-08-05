import 'package:flutter/material.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  // ফ্যামিলি মেম্বারদের ডেটা
  final List<Map<String, String>> familyMembers = const [
    {"name": "Zilan Hasnath", "relation": "Son", "status": "Active"},
    {"name": "Fatema Begum", "relation": "Mother", "status": "Active"},
    {"name": "Sami Ahmed", "relation": "Brother", "status": "Away"},
  ];

  @override
  Widget build(BuildContext context) {
    // Teal & Mint Green Theme Colors
    const Color primaryTeal = Color(0xFF0F766E);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA), // Soft Modern Background
      appBar: AppBar(
        title: const Text(
          "Family Members",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: familyMembers.length,
        itemBuilder: (context, index) {
          final member = familyMembers[index];
          bool isActive = member['status'] == "Active";

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: primaryTeal.withValues(alpha: 0.1),
                child: const Icon(Icons.person, color: primaryTeal),
              ),
              title: Text(
                member['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Text(
                      member['relation']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Text(" • ", style: TextStyle(color: Colors.grey)),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      member['status']!,
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
              onTap: () {
                // মেম্বারের ডিটেইলসে যাওয়ার জন্য নেভিগেশন
              },
            ),
          );
        },
      ),
      // নতুন মেম্বার যোগ করার স্টাইলিশ বাটন
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 2,
        onPressed: () {
          // মেম্বার যোগ করার ফাংশন
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
