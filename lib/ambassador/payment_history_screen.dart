import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    // পেমেন্ট ডেটার একটি লিস্ট তৈরি করা হলো
    final List<Map<String, String>> paymentList = [
      {
        "title": "Shift Payment Received",
        "date": "May 01, 2026",
        "method": "Bkash",
        "amount": "+৳ 1,500",
      },
      {
        "title": "Monthly Bonus",
        "date": "May 02, 2026",
        "method": "Bank",
        "amount": "+৳ 3,000",
      },
      {
        "title": "Shift Payment Received",
        "date": "May 03, 2026",
        "method": "Nagad",
        "amount": "+৳ 1,200",
      },
      {
        "title": "Overtime Allowance",
        "date": "May 04, 2026",
        "method": "Bkash",
        "amount": "+৳ 800",
      },
      {
        "title": "Shift Payment Received",
        "date": "May 05, 2026",
        "method": "Bank",
        "amount": "+৳ 2,000",
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Payment History"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: paymentList.length,
        itemBuilder: (context, index) {
          final payment = paymentList[index];
          return Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: lightTeal.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: lightTeal.withValues(alpha: 0.15),
                child: Icon(Icons.arrow_downward, color: primaryTeal),
              ),
              title: Text(
                payment["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "${payment["date"]} • ${payment["method"]}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              trailing: Text(
                payment["amount"]!,
                style: TextStyle(
                  color: primaryTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
