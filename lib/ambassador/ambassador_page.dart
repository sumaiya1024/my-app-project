import 'package:flutter/material.dart';

class AmbasadorDashboard extends StatelessWidget {
  const AmbasadorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Jennie Akter"),
              accountEmail: Text("jennieakter@gmail.com"),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            ),

            // ২. ব্যক্তিগত ও কাজের তথ্য
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text("Certificate"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text("Payment History"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text("My Documents"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star_rate),
              title: const Text("My Reviews & Ratings"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Shift Scheduler"),
              onTap: () {},
            ),

            const Divider(),

            // ৩. অ্যাপ সেটিংস ও কাস্টমার সাপোর্ট
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

            // ৪. কমিউনিটি ও শেয়ারিং
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text("Refer and Earn"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text("How it Works"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Join Community"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text("Important Notes"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Share this App"),
              onTap: () {},
            ),

            const Divider(),

            // ৫. লগআউট
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
          ],
        ),
      ),
      // ২. বডি কন্টেন্ট
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // স্ট্যাটাস বার
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(12),
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
            ),
            const SizedBox(height: 16),

            // ২. Share Feedback / Health Report
            Card(
              child: ListTile(
                leading: const Icon(Icons.note_alt, color: Colors.blue),
                title: const Text("Share Feedback"),
                subtitle: const Text("Please let us know your care update."),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),

            // ৩. Notice Board
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Notice Board",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text("Our Care Ambassador of the Month, May 2026 is..."),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ৪. Recognition
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.star)),
                title: const Text("Care Ambassador of the Month"),
                subtitle: const Text("ID: 418613 | 5.0 Rating"),
              ),
            ),
            const SizedBox(height: 16),

            // ৫. ভেরিফিকেশন ও জবস
            Row(
              children: [
                Expanded(child: _infoBox("100% Verified", Icons.verified)),
                Expanded(
                  child: _infoBox("Nearby Jobs", Icons.work, count: "99+"),
                ),
                Expanded(
                  child: _infoBox(
                    "Confirmation Letter",
                    Icons.email,
                    count: "5",
                  ),
                ),
                Expanded(
                  child: _infoBox("Invoices", Icons.receipt_long, count: "1"),
                ),
              ],
            ),
          ],
        ),
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
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 9)),
    ],
  );

  Widget _infoBox(String title, IconData icon, {String? count}) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue),
          if (count != null)
            Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    ),
  );
}
