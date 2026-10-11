import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    // পেমেন্ট ডেটার একটি বর্ধিত ও সমৃদ্ধ লিস্ট
    final List<Map<String, String>> paymentList = [
      {
        "title": "Shift Payment Received",
        "date": "May 01, 2026",
        "method": "Bkash",
        "amount": "+৳ 1,500",
        "status": "Successful",
        "transactionId": "TXN-984201",
      },
      {
        "title": "Monthly Bonus",
        "date": "May 02, 2026",
        "method": "Bank Transfer",
        "amount": "+৳ 3,000",
        "status": "Successful",
        "transactionId": "TXN-984202",
      },
      {
        "title": "Shift Payment Received",
        "date": "May 03, 2026",
        "method": "Nagad",
        "amount": "+৳ 1,200",
        "status": "Successful",
        "transactionId": "TXN-984203",
      },
      {
        "title": "Overtime Allowance",
        "date": "May 04, 2026",
        "method": "Bkash",
        "amount": "+৳ 800",
        "status": "Successful",
        "transactionId": "TXN-984204",
      },
      {
        "title": "Shift Payment Received",
        "date": "May 05, 2026",
        "method": "Bank Transfer",
        "amount": "+৳ 2,000",
        "status": "Successful",
        "transactionId": "TXN-984205",
      },
      {
        "title": "Emergency Care Bonus",
        "date": "May 07, 2026",
        "method": "Bkash",
        "amount": "+৳ 500",
        "status": "Successful",
        "transactionId": "TXN-984206",
      },
      {
        "title": "Weekly Performance Reward",
        "date": "May 10, 2026",
        "method": "Nagad",
        "amount": "+৳ 1,000",
        "status": "Successful",
        "transactionId": "TXN-984207",
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
                  "${payment["date"]} • Via ${payment["method"]}",
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
              // প্রতিটি পেমেন্ট অপশন সচল করার জন্য onTap যুক্ত করা হলো
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
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
                              CircleAvatar(
                                backgroundColor: lightTeal.withValues(
                                  alpha: 0.15,
                                ),
                                child: Icon(
                                  Icons.receipt_long,
                                  color: primaryTeal,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  payment["title"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Amount: ${payment["amount"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryTeal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Date: ${payment["date"]}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Payment Method: ${payment["method"]}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Status: ${payment["status"]}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Transaction ID: ${payment["transactionId"]}",
                            style: const TextStyle(color: Colors.grey),
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
            ),
          );
        },
      ),
    );
  }
}
