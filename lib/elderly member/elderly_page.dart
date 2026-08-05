import 'package:flutter/material.dart';

class ElderlyDashboardScreen extends StatelessWidget {
  const ElderlyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Teal & Mint Green Theme Colors
    const Color primaryTeal = Color(0xFF0F766E);
    const Color mintAccent = Color(0xFF14B8A6);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA), // Soft Modern Background
      appBar: AppBar(
        title: const Text(
          'আমার ড্যাশবোর্ড',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ১. বড় ইমার্জেন্সি (SOS) বাটন
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                ),
                onPressed: () {
                  // এখানে SOS কল যাওয়ার লজিক থাকবে
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ইমার্জেন্সি অ্যালার্ট পাঠানো হচ্ছে...'),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_rounded, size: 40, color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      'জরুরি সাহায্য (SOS)',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // ২. আজকের ভিজিট (Today's Visit)
              const Text(
                'আজকের ভিজিট',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: mintAccent.withValues(alpha: 0.15),
                        child: const Icon(
                          Icons.person,
                          size: 45,
                          color: primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'রহিম উদ্দিন',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'আপনার কেয়ারগিভার',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'সময়: বিকেল ৪:০০ টা',
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryTeal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // ৩. কুইক কল অপশন (Quick Calls)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: primaryTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        // সন্তানকে কল করার লজিক
                      },
                      icon: const Icon(
                        Icons.phone,
                        size: 30,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'ছেলেকে\nকল করুন',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        // কেয়ারগিভারকে কল করার লজিক
                      },
                      icon: const Icon(
                        Icons.health_and_safety,
                        size: 30,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'রহিমকে\nকল করুন',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // ৪. ওষুধের রিমাইন্ডার (Medication Reminder)
              const Text(
                'ওষুধের সময়সূচী',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.orange.shade50,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.orange.shade200, width: 1),
                ),
                child: const ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  leading: Icon(
                    Icons.medication,
                    size: 40,
                    color: Colors.orange,
                  ),
                  title: Text(
                    'প্রেসারের ওষুধ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'আজ রাত ৮:০০ টা',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
