import 'package:flutter/material.dart';
import '../theme_manager.dart';
import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color primaryTeal = AppColors.primaryTeal;
  final Color lightTeal = AppColors.lightTeal;

  // সুইচ স্টেটগুলোর জন্য ভেরিয়েবল
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  late bool _darkMode;
  bool _locationTracking = true;

  // ভাষা সিলেকশনের ভেরিয়েবল
  String _selectedLanguage = "English (US)";

  @override
  void initState() {
    super.initState();
    _darkMode = ThemeManager.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _darkMode;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.backgroundColor;
    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? AppColors.darkTextPrimary : Colors.black87;
    final subtitleColor = isDark ? AppColors.darkTextSecondary : Colors.grey;
    final borderColor = isDark ? AppColors.darkBorder : lightTeal.withValues(alpha: 0.15);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: isDark ? const Color(0xFF131D24) : primaryTeal,
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
              gradient: isDark
                  ? const LinearGradient(
                      colors: [Color(0xFF163238), Color(0xFF1F4A4E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [primaryTeal, lightTeal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black26
                      : lightTeal.withValues(alpha: 0.2),
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
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),

          _buildSwitchTile(
            icon: Icons.notifications_active_rounded,
            iconColor: Colors.blue,
            title: "Push Notifications",
            subtitle: "Receive alerts for new shifts and updates",
            value: _pushNotifications,
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
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
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
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
          Text(
            "Preferences",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),

          // ডার্ক মোড সুইচ (ফুললি এনাবল্ড)
          _buildSwitchTile(
            icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            iconColor: isDark ? Colors.amber : Colors.purple,
            title: "Dark Mode",
            subtitle: isDark
                ? "Dark theme active (switch for light mode)"
                : "Switch between light and dark theme",
            value: _darkMode,
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
            onChanged: (val) async {
              setState(() {
                _darkMode = val;
              });
              await ThemeManager.setDarkMode(val);
              if (context.mounted) {
                _showToast(
                  context,
                  val ? "🌙 Dark Mode Enabled" : "☀️ Light Mode Enabled",
                );
              }
            },
          ),
          _buildSwitchTile(
            icon: Icons.location_on_rounded,
            iconColor: Colors.green,
            title: "Location Access",
            subtitle: "Required for shift tracking and check-ins",
            value: _locationTracking,
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
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
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
            onTap: () {
              _showLanguageDialog(context, isDark, cardColor, textColor);
            },
          ),
          const SizedBox(height: 10),

          // ৪. সিকিউরিটি এবং অ্যাকাউন্ট সেকশন
          Text(
            "Security & Account",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),

          _buildActionTile(
            icon: Icons.lock_reset_rounded,
            iconColor: Colors.indigoAccent,
            title: "Change Password",
            subtitle: "Update your account password regularly",
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
            onTap: () {
              _showChangePasswordDialog(context, isDark, cardColor, textColor);
            },
          ),
          _buildActionTile(
            icon: Icons.privacy_tip_rounded,
            iconColor: Colors.brown,
            title: "Privacy Policy",
            subtitle: "Read our terms and data policy",
            cardColor: cardColor,
            textColor: textColor,
            subtitleColor: subtitleColor,
            borderColor: borderColor,
            onTap: () {
              _showPrivacyPolicyBottomSheet(context, isDark, cardColor, textColor, subtitleColor);
            },
          ),
          const SizedBox(height: 10),

          // ৫. লগআউট বাটন (ফুললি সচল)
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.withValues(alpha: 0.3),
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
              subtitle: Text(
                "Sign out from your account safely",
                style: TextStyle(color: subtitleColor, fontSize: 12),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.red,
              ),
              onTap: () {
                _showLogoutDialog(context, isDark, cardColor, textColor, subtitleColor);
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
  void _showLanguageDialog(
    BuildContext context,
    bool isDark,
    Color cardColor,
    Color textColor,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Select Language",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("English (US)", style: TextStyle(color: textColor)),
              leading: Radio<String>(
                value: "English (US)",
                groupValue: _selectedLanguage,
                activeColor: lightTeal,
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
              title: Text("বাংলা (Bangla)", style: TextStyle(color: textColor)),
              leading: Radio<String>(
                value: "বাংলা (Bangla)",
                groupValue: _selectedLanguage,
                activeColor: lightTeal,
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
  void _showChangePasswordDialog(
    BuildContext context,
    bool isDark,
    Color cardColor,
    Color textColor,
  ) {
    final TextEditingController oldPassController = TextEditingController();
    final TextEditingController newPassController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Change Password",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPassController,
              obscureText: true,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: "Current Password",
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPassController,
              obscureText: true,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: "New Password (min 6 chars)",
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
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
  void _showPrivacyPolicyBottomSheet(
    BuildContext context,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
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
              Text(
                "Privacy Policy & Terms",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Your data security is our top priority. We encrypt all your personal information and documents securely. Location data is only used during active shifts.",
                style: TextStyle(color: subtitleColor, fontSize: 13, height: 1.4),
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
  void _showLogoutDialog(
    BuildContext context,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Log Out",
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        content: Text(
          "Are you sure you want to sign out from your account?",
          style: TextStyle(color: subtitleColor),
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
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required Color borderColor,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        secondary: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: textColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(color: subtitleColor, fontSize: 12),
          ),
        ),
        value: value,
        activeTrackColor: lightTeal,
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: _darkMode ? Colors.grey.shade800 : Colors.grey.shade200,
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
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: textColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(color: subtitleColor, fontSize: 12),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: lightTeal),
        onTap: onTap,
      ),
    );
  }
}
