import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  // সুইচ স্টেটগুলোর জন্য ভেরিয়েবল
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _darkMode = false;
  bool _locationTracking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ১. কালারফুল টপ ব্যানার কার্ড
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: lightTeal.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.settings_suggest, color: Colors.amber, size: 45),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "App Preferences",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Customize your app experience, notifications, and security settings.",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ২. নোটিফিকেশন সেকশন
          const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          _buildSwitchTile(
            icon: Icons.notifications_active_rounded,
            iconColor: Colors.blue,
            title: "Push Notifications",
            subtitle: "Receive alerts for new shifts and updates",
            value: _pushNotifications,
            onChanged: (val) {
              setState(() {
                _pushNotifications = val;
              });
            },
          ),
          _buildSwitchTile(
            icon: Icons.mark_email_unread_rounded,
            iconColor: Colors.orange,
            title: "Email Notifications",
            subtitle: "Get weekly summary and payment statements",
            value: _emailNotifications,
            onChanged: (val) {
              setState(() {
                _emailNotifications = val;
              });
            },
          ),
          const SizedBox(height: 10),

          // ৩. অ্যাপ প্রেফারেন্স সেকশন
          const Text(
            "Preferences",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          _buildSwitchTile(
            icon: Icons.dark_mode_rounded,
            iconColor: Colors.purple,
            title: "Dark Mode",
            subtitle: "Switch between light and dark theme",
            value: _darkMode,
            onChanged: (val) {
              setState(() {
                _darkMode = val;
              });
            },
          ),
          _buildSwitchTile(
            icon: Icons.location_on_rounded,
            iconColor: Colors.green,
            title: "Location Access",
            subtitle: "Required for shift tracking and check-ins",
            value: _locationTracking,
            onChanged: (val) {
              setState(() {
                _locationTracking = val;
              });
            },
          ),
          _buildActionTile(
            icon: Icons.language_rounded,
            iconColor: Colors.teal,
            title: "App Language",
            subtitle: "English (US) / বাংলা",
            onTap: () {
              // ভাষা পরিবর্তন বা সিলেকশন পেজে যাওয়ার লজিক
            },
          ),
          const SizedBox(height: 10),

          // ৪. সিকিউরিটি এবং অ্যাকাউন্ট সেকশন
          const Text(
            "Security & Account",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          _buildActionTile(
            icon: Icons.lock_reset_rounded,
            iconColor: Colors.indigo,
            title: "Change Password",
            subtitle: "Update your account password regularly",
            onTap: () {
              // পাসওয়ার্ড চেঞ্জ লজিক
            },
          ),
          _buildActionTile(
            icon: Icons.privacy_tip_rounded,
            iconColor: Colors.brown,
            title: "Privacy Policy",
            subtitle: "Read our terms and data policy",
            onTap: () {
              // প্রাইভেসি পলিসি পেজ
            },
          ),
          const SizedBox(height: 10),

          // ৫. লগআউট বাটন
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.red.withValues(alpha: 0.12),
                child: const Icon(Icons.logout_rounded, color: Colors.red),
              ),
              title: const Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
              subtitle: const Text(
                "Sign out from your account safely",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.red,
              ),
              onTap: () {
                // লগআউট ডায়ালগ বা লজিক
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // সুইচ টাইলের জন্য উইজেট (সংশোধিত কালার প্রপার্টিসহ)
  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: lightTeal.withValues(alpha: 0.15), width: 1),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        secondary: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.12),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        value: value,

        activeTrackColor: primaryTeal,
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade200,
        onChanged: onChanged,
      ),
    );
  }

  // অ্যাকশন টাইলের জন্য উইজেট
  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: lightTeal.withValues(alpha: 0.15), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.12),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: primaryTeal),
        onTap: onTap,
      ),
    );
  }
}
