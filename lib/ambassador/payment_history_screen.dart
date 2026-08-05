import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

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
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        title: const Text("Payment History"),
        backgroundColor: const Color(0xFF1E3C72),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: paymentList.length,
        itemBuilder: (context, index) {
          final payment = paymentList[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(Icons.arrow_downward, color: Colors.green),
              ),
              title: Text(
                payment["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text("${payment["date"]} • ${payment["method"]}"),
              trailing: Text(
                payment["amount"]!,
                style: const TextStyle(
                  color: Colors.green,
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
