import 'package:flutter/material.dart';

class ShiftSchedulerScreen extends StatelessWidget {
  const ShiftSchedulerScreen({super.key});

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  @override
  Widget build(BuildContext context) {
    // আরও কিছু প্রফেশনাল শিট ডেটা যোগ করা হলো
    final List<Map<String, String>> shiftList = [
      {
        "location": "Gulshan, Dhaka",
        "time": "Tomorrow, 09:00 AM - 05:00 PM",
        "status": "Confirmed",
        "patient": "Mr. Rahman (Elderly Care)",
        "rate": "৳ 1,500 / shift",
      },
      {
        "location": "Banani, Dhaka",
        "time": "May 10, 2026, 08:00 AM - 04:00 PM",
        "status": "Pending",
        "patient": "Mrs. Chowdhury (Post-Surgery Support)",
        "rate": "৳ 1,600 / shift",
      },
      {
        "location": "Dhanmondi, Dhaka",
        "time": "May 12, 2026, 10:00 AM - 06:00 PM",
        "status": "Confirmed",
        "patient": "Dr. Ahmed (Patient Care)",
        "rate": "৳ 1,400 / shift",
      },
      {
        "location": "Uttara, Dhaka",
        "time": "May 15, 2026, 09:00 AM - 05:00 PM",
        "status": "Confirmed",
        "patient": "Mrs. Jahan (General Care)",
        "rate": "৳ 1,500 / shift",
      },
      {
        "location": "Mirpur, Dhaka",
        "time": "May 18, 2026, 07:00 AM - 03:00 PM",
        "status": "Pending",
        "patient": "Mr. Karim (Elderly Support)",
        "rate": "৳ 1,300 / shift",
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Shift Scheduler"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upcoming Shifts",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: shiftList.length,
                itemBuilder: (context, index) {
                  final shift = shiftList[index];
                  return _buildShiftCard(
                    context,
                    shift["location"]!,
                    shift["time"]!,
                    shift["status"]!,
                    shift["patient"]!,
                    shift["rate"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftCard(
    BuildContext context,
    String location,
    String time,
    String status,
    String patient,
    String rate,
  ) {
    final bool isConfirmed = status == "Confirmed";

    return GestureDetector(
      onTap: () {
        // যেকোনো শিটে ক্লিক করলে সম্পূর্ণ ডিটেইলস পপআপ বা বটম শিট দেখাবে
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
                      Icon(Icons.location_on, color: primaryTeal, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isConfirmed
                              ? lightTeal.withValues(alpha: 0.15)
                              : Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: isConfirmed
                                ? primaryTeal
                                : Colors.orange.shade800,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Patient Details: $patient",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Schedule Time: $time",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Shift Earning: $rate",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primaryTeal,
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
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: lightTeal.withValues(alpha: 0.15), width: 1),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: primaryTeal,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        location,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isConfirmed
                          ? lightTeal.withValues(alpha: 0.15)
                          : Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: isConfirmed
                            ? primaryTeal
                            : Colors.orange.shade800,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: primaryTeal.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patient,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    rate,
                    style: TextStyle(
                      color: primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
