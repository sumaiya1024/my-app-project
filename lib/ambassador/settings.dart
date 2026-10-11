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

  // ভাষা সিলেকশনের ভেরিয়েবল
  String _selectedLanguage = "English (US)";

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
              _showToast(
                context,
                "Push Notifications ${val ? 'Enabled' : 'Disabled'}",
              );
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
              _showToast(
                context,
                "Email Notifications ${val ? 'Enabled' : 'Disabled'}",
              );
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
              _showToast(context, "Dark Mode is coming soon!");
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
              _showToast(
                context,
                "Location Access ${val ? 'Allowed' : 'Denied'}",
              );
            },
          ),
          _buildActionTile(
            icon: Icons.language_rounded,
            iconColor: Colors.teal,
            title: "App Language",
            subtitle: _selectedLanguage,
            onTap: () {
              _showLanguageDialog(context);
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
              _showChangePasswordDialog(context);
            },
          ),
          _buildActionTile(
            icon: Icons.privacy_tip_rounded,
            iconColor: Colors.brown,
            title: "Privacy Policy",
            subtitle: "Read our terms and data policy",
            onTap: () {
              _showPrivacyPolicyBottomSheet(context);
            },
          ),
          const SizedBox(height: 10),

          // ৫. লগআউট বাটন (ফুললি সচল)
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
                _showLogoutDialog(context);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ছোট নোটিফিকেশন দেখানোর জন্য টোস্ট বা স্নাকবার ফাংশন
  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: primaryTeal,
      ),
    );
  }

  // ভাষা পরিবর্তনের ডায়ালগ
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English (US)"),
              leading: Radio<String>(
                value: "English (US)",
                groupValue: _selectedLanguage,
                activeColor: primaryTeal,
                onChanged: (val) {
                  setState(() => _selectedLanguage = val!);
                  Navigator.pop(context);
                },
              ),
              onTap: () {
                setState(() => _selectedLanguage = "English (US)");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("বাংলা (Bangla)"),
              leading: Radio<String>(
                value: "বাংলা (Bangla)",
                groupValue: _selectedLanguage,
                activeColor: primaryTeal,
                onChanged: (val) {
                  setState(() => _selectedLanguage = val!);
                  Navigator.pop(context);
                },
              ),
              onTap: () {
                setState(() => _selectedLanguage = "বাংলা (Bangla)");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // পাসওয়ার্ড পরিবর্তনের ডায়ালগ
  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController oldPassController = TextEditingController();
    final TextEditingController newPassController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Current Password"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "New Password (min 6 chars)",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _showToast(context, "Password updated successfully!");
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  // প্রাইভেসি পলিসি বটম শিট
  void _showPrivacyPolicyBottomSheet(BuildContext context) {
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
              const Text(
                "Privacy Policy & Terms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Your data security is our top priority. We encrypt all your personal information and documents securely. Location data is only used during active shifts.",
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: Colors.white,
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
  }

  // লগআউট কনফার্মেশন ডায়ালগ
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Log Out"),
        content: const Text(
          "Are you sure you want to sign out from your account?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _showToast(context, "Logged out successfully!");
              // এখানে চাইলে লগইন পেজে রিডাইরেক্ট করার কোড বসাতে পারো
            },
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }

  // সুইচ টাইলের জন্য উইজেট
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
