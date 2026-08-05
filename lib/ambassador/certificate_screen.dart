import 'package:flutter/material.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // অর্জিত সার্টিফিকেটগুলোর একটি লিস্ট
    final List<Map<String, String>> certificateList = [
      {
        "title": "Professional Caregiver Training",
        "issueDate": "January 15, 2026",
        "status": "Verified & Active",
        "id": "CERT-849201",
      },
      {
        "title": "Elderly First Aid & Safety",
        "issueDate": "March 10, 2026",
        "status": "Verified & Active",
        "id": "CERT-849202",
      },
      {
        "title": "Advanced Health Support Provider",
        "issueDate": "Pending Assessment",
        "status": "In Progress",
        "id": "CERT-PENDING",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        title: const Text("My Certificates"),
        backgroundColor: const Color(0xFF1E3C72),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // উপরের ব্যানার কার্ড
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.workspace_premium, color: Colors.amber, size: 45),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Achievements",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Download and share your verified professional care certificates.",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Available Certificates",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          // সার্টিফিকেট লিস্ট
          ...certificateList.map((cert) {
            bool isVerified = cert["status"] == "Verified & Active";
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: isVerified
                        ? Colors.green.shade50
                        : Colors.orange.shade50,
                    child: Icon(
                      isVerified ? Icons.verified : Icons.hourglass_top,
                      color: isVerified ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ID: ${cert["id"]} • ${cert["issueDate"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cert["status"]!,
                          style: TextStyle(
                            color: isVerified ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isVerified)
                    IconButton(
                      icon: const Icon(
                        Icons.download,
                        color: Color(0xFF1E3C72),
                      ),
                      onPressed: () {
                        // ডাউনলোড বা ভিউ করার অপশন
                      },
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
