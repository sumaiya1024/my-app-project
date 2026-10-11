import 'package:flutter/material.dart';

class ElderlyDashboardScreen extends StatefulWidget {
  const ElderlyDashboardScreen({super.key});

  @override
  State<ElderlyDashboardScreen> createState() => _ElderlyDashboardScreenState();
}

class _ElderlyDashboardScreenState extends State<ElderlyDashboardScreen> {
  // Teal & Mint Green Theme Colors
  final Color primaryTeal = const Color(0xFF0F766E);
  final Color mintAccent = const Color(0xFF14B8A6);

  // ওষুধ খাওয়া হয়েছে কি না তা ট্র্যাক করার স্টেট
  bool _isMedicineTaken = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA), // Soft Modern Background
      appBar: AppBar(
        title: const Text(
          'আমার ড্যাশবোর্ড',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryTeal, mintAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              // নোটিফিকেশন ডায়ালগ
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("বিজ্ঞপ্তি"),
                  content: const Text("আপনার আজকের কোনো নতুন রিমাইন্ডার নেই।"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("বন্ধ করুন"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ১. বড় ইমার্জেন্সি (SOS) বাটন (ফুললি সচল)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                ),
                onPressed: () {
                  _showEmergencyDialog(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_rounded, size: 36, color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      'জরুরি সাহায্য (SOS)',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // নতুন সংযোজন: অ্যাম্বুলেন্স সাপোর্ট বাটন
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.red.shade400, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  _showAmbulanceDialog(context);
                },
                icon: Icon(
                  Icons.local_hospital,
                  color: Colors.red.shade600,
                  size: 26,
                ),
                label: Text(
                  'অ্যাম্বুলেন্স কল করুন',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // ২. আজকের ভিজিট (Today's Visit)
              const Text(
                'আজকের ভিজিট',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
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
                        radius: 35,
                        backgroundColor: mintAccent.withValues(alpha: 0.15),
                        child: Icon(Icons.person, size: 40, color: primaryTeal),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'রহিম উদ্দিন',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'আপনার কেয়ারগিভার',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'সময়: বিকেল ৪:০০ টা',
                              style: TextStyle(
                                fontSize: 14,
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

              // ৩. কুইক কল অপশন (Quick Calls - ফুললি সচল)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: primaryTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        _showCallActionDialog(
                          context,
                          "ছেলের কাছে কল করা হচ্ছে...",
                          "মোবাইল: +880 1711-XXXXXX",
                        );
                      },
                      icon: const Icon(
                        Icons.phone,
                        size: 26,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'ছেলেকে কল করুন',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        _showCallActionDialog(
                          context,
                          "কেয়ারগিভার রহিমের কাছে কল করা হচ্ছে...",
                          "মোবাইল: +880 1811-XXXXXX",
                        );
                      },
                      icon: const Icon(
                        Icons.health_and_safety,
                        size: 26,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'রহিমকে কল করুন',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // ৪. ওষুধের রিমাইন্ডার (Medication Reminder - ইন্টারঅ্যাক্টিভ চেক বক্সসহ)
              const Text(
                'ওষুধের সময়সূচী',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.orange.shade50,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.orange.shade200, width: 1),
                ),
                child: CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  secondary: const Icon(
                    Icons.medication,
                    size: 38,
                    color: Colors.orange,
                  ),
                  title: const Text(
                    'প্রেসারের ওষুধ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'আজ রাত ৮:০০ টা',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  value: _isMedicineTaken,
                  activeColor: primaryTeal,
                  onChanged: (bool? value) {
                    setState(() {
                      _isMedicineTaken = value ?? false;
                    });
                    if (_isMedicineTaken) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'ধন্যবাদ! ওষুধের খাওয়া সম্পন্ন হিসেবে রেকর্ড করা হলো।',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SOS ইমার্জেন্সি ডায়ালগ
  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            SizedBox(width: 8),
            Text("জরুরি সাহায্য (SOS)"),
          ],
        ),
        content: const Text(
          "আপনি কি নিশ্চিতভাবে জরুরি সাহায্য বা ইমার্জেন্সি অ্যালার্ট পাঠাতে চান? আপনার কেয়ারগিভার এবং পরিবারকে তাৎক্ষণিকভাবে কল ও নোটিফিকেশন পাঠানো হবে।",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("বাতিল", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ইমার্জেন্সি অ্যালার্ট সফলভাবে পাঠানো হয়েছে!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text("অ্যালার্ট পাঠান"),
          ),
        ],
      ),
    );
  }

  // অ্যাম্বুলেন্স ডায়ালগ
  void _showAmbulanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("অ্যাম্বুলেন্স সহায়তা"),
        content: const Text(
          "নিকটস্থ হাসপাতালের অ্যাম্বুলেন্স সার্ভিসের সাথে যোগাযোগের জন্য কল করা হবে কি?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("বাতিল"),
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
                  content: Text('অ্যাম্বুলেন্স সার্ভিসে কল করা হচ্ছে...'),
                ),
              );
            },
            child: const Text("কল করুন"),
          ),
        ],
      ),
    );
  }

  // কল অ্যাকশন ডায়ালগ
  void _showCallActionDialog(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(subtitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("বন্ধ করুন"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('কল সংযোগ করা হচ্ছে...')),
              );
            },
            child: const Text("ডায়াল করুন"),
          ),
        ],
      ),
    );
  }
}
