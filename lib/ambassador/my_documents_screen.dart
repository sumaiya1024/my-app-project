import 'package:flutter/material.dart';

class MyDocumentsScreen extends StatelessWidget {
  const MyDocumentsScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("My Documents"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDocCard("NID Card / Passport", "Verified", primaryTeal),
          _buildDocCard("Nursing Certificate", "Verified", primaryTeal),
          _buildDocCard(
            "Police Clearance",
            "Pending Review",
            Colors.orange.shade800,
          ),
          _buildDocCard("Medical Fitness Report", "Verified", primaryTeal),
        ],
      ),
    );
  }

  Widget _buildDocCard(String title, String status, Color statusColor) {
    // এখানে isVerified ঠিকঠাক কাজ করবে
    final bool isVerified = status == "Verified";

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: lightTeal.withValues(alpha: 0.15), width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: lightTeal.withValues(alpha: 0.15),
          child: Icon(Icons.description_outlined, color: primaryTeal),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            status,
            style: TextStyle(
              color: isVerified ? primaryTeal : statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: lightTeal.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.remove_red_eye_outlined,
            color: primaryTeal,
            size: 20,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
