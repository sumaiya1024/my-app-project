import 'package:flutter/material.dart';

class ConfirmationLettersScreen extends StatelessWidget {
  const ConfirmationLettersScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    // কনফার্মেশন লেটারগুলোর একটি স্যাম্পল লিস্ট
    final List<Map<String, String>> letterList = [
      {
        "title": "Shift Appointment Confirmation",
        "date": "May 05, 2026",
        "location": "Gulshan, Dhaka",
        "status": "Verified & Active",
        "refNo": "REF-CONF-901",
      },
      {
        "title": "Elderly Care Service Agreement",
        "date": "April 20, 2026",
        "location": "Banani, Dhaka",
        "status": "Verified & Active",
        "refNo": "REF-CONF-902",
      },
      {
        "title": "Monthly Performance Endorsement",
        "date": "April 01, 2026",
        "location": "Dhanmondi, Dhaka",
        "status": "Verified & Active",
        "refNo": "REF-CONF-903",
      },
      {
        "title": "Emergency Support Authorization",
        "date": "March 15, 2026",
        "location": "Uttara, Dhaka",
        "status": "Verified & Active",
        "refNo": "REF-CONF-904",
      },
      {
        "title": "Ambassador Program Acceptance",
        "date": "January 10, 2026",
        "location": "Central Office, Dhaka",
        "status": "Verified & Active",
        "refNo": "REF-CONF-905",
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Confirmation Letters"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: letterList.length,
        itemBuilder: (context, index) {
          final letter = letterList[index];
          return GestureDetector(
            onTap: () {
              // যেকোনো লেটারে ক্লিক করলে ডিটেইলস বটম শিট ওপেন হবে
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
                        Row(
                          children: [
                            Icon(Icons.email, color: primaryTeal, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                letter["title"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Reference No: ${letter["refNo"]}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text("Issued Date: ${letter["date"]}"),
                        const SizedBox(height: 6),
                        Text("Location: ${letter["location"]}"),
                        const SizedBox(height: 6),
                        Text(
                          "Status: ${letter["status"]}",
                          style: TextStyle(
                            color: primaryTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryTeal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: lightTeal.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: lightTeal.withValues(alpha: 0.15),
                    child: Icon(Icons.email_outlined, color: primaryTeal),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          letter["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Ref: ${letter["refNo"]} • ${letter["date"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          letter["status"]!,
                          style: TextStyle(
                            color: primaryTeal,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: primaryTeal),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
