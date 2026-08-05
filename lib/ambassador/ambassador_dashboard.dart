import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'certificate_screen.dart';
import 'payment_history_screen.dart';
import 'my_documents_screen.dart';
import 'shift_scheduler_screen.dart';
import 'my_reviews.dart'; // নতুন রিভিউ স্ক্রিন ইমপোর্ট করা হলো

class AmbassadorDashboard extends StatefulWidget {
  const AmbassadorDashboard({super.key});

  @override
  State<AmbassadorDashboard> createState() => _AmbassadorDashboardState();
}

class _AmbassadorDashboardState extends State<AmbassadorDashboard> {
  bool isOnDuty = true; // Duty Status Toggle State

  // Teal & Mint Green Theme Colors
  final Color primaryTeal = const Color(0xFF0F766E);
  final Color mintAccent = const Color(0xFF14B8A6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        title: const Text("Ambassador Dashboard"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryTeal, mintAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Stack(
              children: [
                Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildAppDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDutyStatusCard(),
            const SizedBox(height: 16),
            _buildEarningsCard(),
            const SizedBox(height: 16),
            _buildStatsBar(),
            const SizedBox(height: 16),
            _buildShiftReminderCard(context),
            const SizedBox(height: 16),
            _buildFeedbackCard(),
            const SizedBox(height: 16),
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildQuickInfoGrid(context),
            const SizedBox(height: 16),
            _buildNoticeBoard(),
            const SizedBox(height: 16),
            _buildRecognitionCard(),
            const SizedBox(height: 24),
            _buildHelplineSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- Drawer Widget with Navigation ---
  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [primaryTeal, mintAccent]),
            ),
            accountName: const Text("Jennie Akter"),
            accountEmail: const Text("jennieakter@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: primaryTeal),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text("Certificate"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CertificateScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment History"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentHistoryScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("My Documents"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyDocumentsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text("My Reviews & Ratings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyReviewsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text("Shift Scheduler"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShiftSchedulerScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text("Message to CEO"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text("Help & Support"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDutyStatusCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.fiber_manual_record,
                color: isOnDuty ? Colors.green : Colors.grey,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                isOnDuty
                    ? "You are Online (Ready for Duty)"
                    : "You are Offline",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Switch(
            value: isOnDuty,
            activeThumbColor: Colors.green,
            onChanged: (value) {
              setState(() {
                isOnDuty = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryTeal, mintAccent]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Earnings (This Month)",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                "৳ 15,400",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: primaryTeal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text("Withdraw"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryTeal, mintAccent]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: mintAccent.withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("Applied", "1026"),
          _statItem("Shortlisted", "0"),
          _statItem("Appointed", "1"),
          _statItem("Confirmed", "14"),
          _statItem("Cancelled", "31"),
        ],
      ),
    );
  }

  Widget _statItem(String label, String count) => Column(
    children: [
      Text(
        count,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9)),
    ],
  );

  Widget _buildShiftReminderCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: mintAccent.withValues(alpha: 0.15),
          child: Icon(Icons.access_time, color: primaryTeal),
        ),
        title: const Text(
          "Next Shift Scheduled",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: const Text("Tomorrow, 09:00 AM - Gulshan, Dhaka"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShiftSchedulerScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8F5E9),
          child: Icon(Icons.note_alt, color: Colors.green),
        ),
        title: const Text(
          "Share Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: const Text("Please let us know your care update."),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildQuickInfoGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        _infoBox(
          "100% Verified",
          Icons.verified,
          Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyDocumentsScreen(),
              ),
            );
          },
        ),
        _infoBox("Nearby Jobs", Icons.work, primaryTeal, count: "99+"),
        _infoBox("Confirmation Letter", Icons.email, Colors.orange, count: "5"),
        _infoBox(
          "Invoices",
          Icons.receipt_long,
          Colors.purple,
          count: "1",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentHistoryScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _infoBox(
    String title,
    IconData icon,
    Color color, {
    String? count,
    VoidCallback? onTap,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (count != null)
                  Text(
                    count,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildNoticeBoard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.campaign, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Text(
                  "Notice Board",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Our Care Ambassador of the Month, May 2026 is announced! Check details inside.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecognitionCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.star, color: Colors.white),
        ),
        title: Text(
          "Care Ambassador of the Month",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text("ID: 418613 | 5.0 Rating ⭐"),
      ),
    );
  }

  Widget _buildHelplineSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mintAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: mintAccent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.headset_mic, color: primaryTeal),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Need Help? Call Helpline",
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
              Text(
                "+880 9612-345678",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryTeal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
