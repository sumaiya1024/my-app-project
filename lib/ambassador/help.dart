import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ১. কালারফুল টপ ব্যানার কার্ড
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: lightTeal.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.support_agent, color: Colors.amber, size: 45),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How can we help you?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Our support team is available 24/7 to assist you with any issues.",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ২. কুইক কন্টাক্ট সেকশন হেডিং
          const Text(
            "Quick Contact",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          // কন্টাক্ট কার্ডসমূহ (কালারফুল আইকনসহ)
          _buildSupportCard(
            context,
            icon: Icons.phone_in_talk_rounded,
            iconColor: Colors.green,
            title: "Call Helpline",
            subtitle: "+880 9612-345678 (24/7)",
            onTap: () {
              // কল করার লজিক
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.chat_bubble_rounded,
            iconColor: Colors.blue,
            title: "Live Chat Support",
            subtitle: "Chat instantly with our support executive",
            onTap: () {
              // লাইভ চ্যাট লজিক
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.email_rounded,
            iconColor: Colors.orange,
            title: "Email Support",
            subtitle: "support@kinvera.com",
            onTap: () {
              // ইমেইল লজিক
            },
          ),

          const SizedBox(height: 10),
          // ৩. এফএকিউ এবং গাইড সেকশন হেডিং
          const Text(
            "FAQs & Guides",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          _buildSupportCard(
            context,
            icon: Icons.help_center_rounded,
            iconColor: Colors.purple,
            title: "Frequently Asked Questions",
            subtitle: "Find answers to common questions",
            onTap: () {
              // FAQ লজিক
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.menu_book_rounded,
            iconColor: Colors.pink,
            title: "Ambassador Guidebook",
            subtitle: "Learn how to manage shifts and services",
            onTap: () {
              // গাইডবুক লজিক
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: lightTeal.withValues(alpha: 0.15), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.12),
          child: Icon(icon, color: iconColor),
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
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: primaryTeal),
        onTap: onTap,
      ),
    );
  }
}
