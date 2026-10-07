import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  // পিসি ও মোবাইল উভয়ের জন্য একদম নিরাপদ ডাউনলোড ফাংশন
  Future<void> _downloadAndOpenCertificate(
    BuildContext context,
    String title,
    String url,
  ) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Downloading $title..."),
          backgroundColor: primaryTeal,
          duration: const Duration(seconds: 2),
        ),
      );

      // ডেস্কটপ এবং মোবাইল সব জায়গার জন্যই ডকুমেন্টস ডিরেক্টরি সেফ ও কাজ করে
      Directory directory = await getApplicationDocumentsDirectory();

      String fileName = "${title.replaceAll(' ', '_')}.pdf";
      String filePath = "${directory.path}/$fileName";

      // Dio দিয়ে ফাইল ডাউনলোড করা
      await Dio().download(url, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Download Complete! Opening file..."),
          backgroundColor: Colors.green,
        ),
      );

      // ফাইল ওপেন করা
      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Download Failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> certificateList = [
      {
        "title": "Professional Caregiver Training",
        "issueDate": "January 15, 2026",
        "status": "Verified & Active",
        "id": "CERT-849201",
        "downloadUrl":
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      },
      {
        "title": "Elderly First Aid & Safety",
        "issueDate": "March 10, 2026",
        "status": "Verified & Active",
        "id": "CERT-849202",
        "downloadUrl":
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      },
      {
        "title": "Advanced Health Support Provider",
        "issueDate": "Pending Assessment",
        "status": "In Progress",
        "id": "CERT-PENDING",
        "downloadUrl": "",
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("My Certificates"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryTeal,
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
          ...certificateList.map((cert) {
            bool isVerified = cert["status"] == "Verified & Active";

            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Selected: ${cert["title"]} (${cert["id"]})"),
                    duration: const Duration(seconds: 2),
                  ),
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
                      backgroundColor: isVerified
                          ? lightTeal.withValues(alpha: 0.15)
                          : Colors.orange.withValues(alpha: 0.15),
                      child: Icon(
                        isVerified ? Icons.verified : Icons.hourglass_top,
                        color: isVerified
                            ? primaryTeal
                            : Colors.orange.shade800,
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
                              color: Colors.black87,
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
                              color: isVerified
                                  ? primaryTeal
                                  : Colors.orange.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isVerified)
                      IconButton(
                        icon: Icon(Icons.download_outlined, color: primaryTeal),
                        onPressed: () {
                          _downloadAndOpenCertificate(
                            context,
                            cert["title"]!,
                            cert["downloadUrl"]!,
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
