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

          // কন্টাক্ট কার্ডসমূহ (ফুললি সচল)
          _buildSupportCard(
            context,
            icon: Icons.phone_in_talk_rounded,
            iconColor: Colors.green,
            title: "Call Helpline",
            subtitle: "+880 9612-345678 (24/7)",
            onTap: () {
              _showActionDialog(
                context,
                "Call Helpline",
                "Do you want to call our 24/7 helpline at +880 9612-345678?",
                Icons.phone,
                Colors.green,
              );
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.chat_bubble_rounded,
            iconColor: Colors.blue,
            title: "Live Chat Support",
            subtitle: "Chat instantly with our support executive",
            onTap: () {
              _showActionDialog(
                context,
                "Live Chat",
                "Connecting you to an available support executive...",
                Icons.chat,
                Colors.blue,
              );
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.message_rounded,
            iconColor: Colors.teal,
            title: "WhatsApp Support",
            subtitle: "Chat with us directly on WhatsApp",
            onTap: () {
              _showActionDialog(
                context,
                "WhatsApp Support",
                "Opening WhatsApp chat channel with Kinvera Care...",
                Icons.message,
                Colors.teal,
              );
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.email_rounded,
            iconColor: Colors.orange,
            title: "Email Support",
            subtitle: "support@kinvera.com",
            onTap: () {
              _showActionDialog(
                context,
                "Email Support",
                "Send your queries to support@kinvera.com. We reply within 2 hours.",
                Icons.email,
                Colors.orange,
              );
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
              _showFaqBottomSheet(context);
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.menu_book_rounded,
            iconColor: Colors.pink,
            title: "Ambassador Guidebook",
            subtitle: "Learn how to manage shifts and services",
            onTap: () {
              _showGuidebookBottomSheet(context);
            },
          ),
          _buildSupportCard(
            context,
            icon: Icons.bug_report_rounded,
            iconColor: Colors.redAccent,
            title: "Report a Technical Issue",
            subtitle: "Facing app bugs? Let us know",
            onTap: () {
              _showBugReportDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // কাস্টম কালারফুল সাপোর্ট কার্ড উইজেট
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

  // সাধারণ ইনফো বা অ্যাকশন দেখানোর ডায়ালগ
  void _showActionDialog(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color color,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // FAQ দেখানোর জন্য বটম শিট
  void _showFaqBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Q: How do I get paid?\nA: Payments are processed weekly via Bkash, Nagad, or Bank transfer.",
              ),
              const SizedBox(height: 10),
              const Text(
                "Q: How to cancel a shift?\nA: You can manage shifts from the Shift Scheduler section.",
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // গাইডবুক দেখানোর জন্য বটম শিট
  void _showGuidebookBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ambassador Guidebook",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "• Always arrive 10 minutes prior to shift time.\n• Keep your documents verified to get premium shifts.\n• Maintain professional behavior with clients.",
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Got It"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // বাগ রিপোর্ট ডায়ালগ
  void _showBugReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Report an Issue"),
        content: const TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Describe the bug or issue...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Bug report submitted successfully! Thank you.",
                  ),
                ),
              );
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
