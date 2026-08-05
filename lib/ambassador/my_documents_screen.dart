import 'package:flutter/material.dart';

class MyDocumentsScreen extends StatelessWidget {
  const MyDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        title: const Text("My Documents"),
        backgroundColor: const Color(0xFF1E3C72),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDocCard("NID Card / Passport", "Verified", Colors.green),
          _buildDocCard("Nursing Certificate", "Verified", Colors.green),
          _buildDocCard("Police Clearance", "Pending Review", Colors.orange),
          _buildDocCard("Medical Fitness Report", "Verified", Colors.green),
        ],
      ),
    );
  }

  Widget _buildDocCard(String title, String status, Color statusColor) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.description, color: Color(0xFF1E3C72)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          status,
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.remove_red_eye, color: Colors.blue),
        onTap: () {},
      ),
    );
  }
}
