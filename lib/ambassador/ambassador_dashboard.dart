import 'package:flutter/material.dart';
import 'package:kinvera/ambassador/confirmation_letters_screen.dart';
import 'package:kinvera/screens/role_selection_screen.dart';
import 'profile_screen.dart';
import 'certificate_screen.dart';
import 'payment_history_screen.dart';
import 'my_documents_screen.dart';
import 'shift_scheduler_screen.dart';
import 'my_reviews.dart';
import 'message_to_ceo.dart';
import 'help.dart';
import 'settings.dart' as app_settings;
import '../theme_manager.dart';
import '../constants.dart';
import '../admin/admin_dashboard.dart';

class AmbassadorDashboard extends StatefulWidget {
  const AmbassadorDashboard({super.key});

  @override
  State<AmbassadorDashboard> createState() => _AmbassadorDashboardState();
}

class _AmbassadorDashboardState extends State<AmbassadorDashboard> {
  bool isOnDuty = true;

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color mintAccent = const Color(0xFF14B8A6);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeModeNotifier,
      builder: (context, themeMode, _) {
        final isDark = themeMode == ThemeMode.dark;
        final cardBg = isDark ? AppColors.darkCard : Colors.white;
        final textPrimary = isDark ? AppColors.darkTextPrimary : Colors.black87;
        final textSecondary = isDark ? AppColors.darkTextSecondary : Colors.black54;
        final bgColor = isDark ? AppColors.darkBackground : const Color(0xFFF4F7FA);

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: const Text("Ambassador Dashboard"),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: isDark
                    ? const LinearGradient(
                        colors: [Color(0xFF131D24), Color(0xFF162E33)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: cardBg,
                      title: Text("Notifications", style: TextStyle(color: textPrimary)),
                      content: Text("You have 3 new shift update alerts.", style: TextStyle(color: textSecondary)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: _buildAppDrawer(context, isDark, textPrimary, cardBg),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDutyStatusCard(isDark, cardBg, textPrimary),
                const SizedBox(height: 16),
                _buildEarningsCard(context),
                const SizedBox(height: 16),
                _buildStatsBar(context),
                const SizedBox(height: 16),
                _buildShiftReminderCard(context, cardBg, textPrimary, textSecondary),
                const SizedBox(height: 16),
                _buildFeedbackCard(context, cardBg, textPrimary, textSecondary),
                const SizedBox(height: 16),
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                _buildQuickInfoGrid(context, cardBg, textPrimary),
                const SizedBox(height: 16),
                _buildNoticeBoard(context, cardBg, textPrimary, textSecondary),
                const SizedBox(height: 16),
                _buildRecognitionCard(context, cardBg, textPrimary, textSecondary),
                const SizedBox(height: 24),
                _buildHelplineSection(context, isDark, textSecondary),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppDrawer(BuildContext context, bool isDark, Color textPrimary, Color cardBg) {
    return Drawer(
      backgroundColor: cardBg,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(colors: [Color(0xFF131D24), Color(0xFF162E33)])
                  : LinearGradient(colors: [primaryTeal, mintAccent]),
            ),
            accountName: const Text("Sumaiya Shahara"),
            accountEmail: const Text("sumaiyashahara@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: primaryTeal),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: isDark ? Colors.white70 : null),
            title: Text("Profile", style: TextStyle(color: textPrimary)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.workspace_premium, color: isDark ? Colors.white70 : null),
            title: Text("Certificate", style: TextStyle(color: textPrimary)),
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
            leading: Icon(Icons.payment, color: isDark ? Colors.white70 : null),
            title: Text("Payment History", style: TextStyle(color: textPrimary)),
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
            leading: Icon(Icons.description, color: isDark ? Colors.white70 : null),
            title: Text("My Documents", style: TextStyle(color: textPrimary)),
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
            leading: Icon(Icons.star_rate, color: isDark ? Colors.white70 : null),
            title: Text("My Reviews & Ratings", style: TextStyle(color: textPrimary)),
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
            leading: Icon(Icons.calendar_month, color: isDark ? Colors.white70 : null),
            title: Text("Shift Scheduler", style: TextStyle(color: textPrimary)),
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
          Divider(color: isDark ? AppColors.darkBorder : null),
          ListTile(
            leading: Icon(
              Icons.admin_panel_settings_outlined,
              color: isDark ? mintAccent : primaryTeal,
            ),
            title: Text("Message to CEO", style: TextStyle(color: textPrimary)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white54 : null),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessageToCeoScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent, color: isDark ? Colors.white70 : null),
            title: Text("Help & Support", style: TextStyle(color: textPrimary)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpSupportScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: isDark ? Colors.white70 : null),
            title: Text("Settings", style: TextStyle(color: textPrimary)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const app_settings.SettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.admin_panel_settings,
              color: Colors.amber.shade700,
            ),
            title: Text(
              "Admin Command Center",
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.amber,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminDashboardScreen(),
                ),
              );
            },
          ),
          Divider(color: isDark ? AppColors.darkBorder : null),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  bool rememberDevice = false;
                  return StatefulBuilder(
                    builder: (context, setDialogState) {
                      return AlertDialog(
                        backgroundColor: cardBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              color: Colors.red,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text("Log Out", style: TextStyle(color: textPrimary)),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Are you sure you want to sign out from your account?",
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Remember this device for quick login",
                                style: TextStyle(fontSize: 13, color: textPrimary),
                              ),
                              value: rememberDevice,
                              activeColor: primaryTeal,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setDialogState(() {
                                  rememberDevice = value ?? false;
                                });
                              },
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
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RoleSelectionScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text("Log Out"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDutyStatusCard(bool isDark, Color cardBg, Color textPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
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
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: textPrimary,
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

  Widget _buildEarningsCard(BuildContext context) {
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Withdraw Earnings"),
                  content: const Text(
                    "Your current balance is ৳ 15,400. Do you want to withdraw via Bkash?",
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Withdrawal request submitted successfully!",
                            ),
                          ),
                        );
                      },
                      child: const Text("Confirm"),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Withdraw"),
          ),
        ],
      ),
    );
  }

  // পরিসংখ্যান বারকে সচল করা হয়েছে
  Widget _buildStatsBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryTeal, mintAccent]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem(context, "Applied", "1026"),
          _statItem(context, "Shortlisted", "5"),
          _statItem(context, "Appointed", "1"),
          _statItem(context, "Confirmed", "14"),
          _statItem(context, "Cancelled", "31"),
        ],
      ),
    );
  }

  Widget _statItem(BuildContext context, String label, String count) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("$label Status"),
            content: Text(
              "You have $count $label shifts/applications recorded.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
      child: Column(
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
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftReminderCard(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Card(
      color: cardBg,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: mintAccent.withValues(alpha: 0.15),
          child: Icon(Icons.access_time, color: primaryTeal),
        ),
        title: Text(
          "Next Shift Scheduled",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: textPrimary,
          ),
        ),
        subtitle: Text(
          "Tomorrow, 09:00 AM - Gulshan, Dhaka",
          style: TextStyle(color: textSecondary),
        ),
        trailing: Icon(Icons.chevron_right, color: textSecondary),
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

  Widget _buildFeedbackCard(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Card(
      color: cardBg,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8F5E9),
          child: Icon(Icons.note_alt, color: Colors.green),
        ),
        title: Text(
          "Share Feedback",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: textPrimary,
          ),
        ),
        subtitle: Text(
          "Please let us know your care update.",
          style: TextStyle(color: textSecondary),
        ),
        trailing: Icon(Icons.chevron_right, color: textSecondary),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MessageToCeoScreen()),
          );
        },
      ),
    );
  }

  Widget _buildQuickInfoGrid(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
  ) {
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
          cardBg,
          textPrimary,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyDocumentsScreen(),
              ),
            );
          },
        ),
        _infoBox(
          "Nearby Jobs",
          Icons.work,
          primaryTeal,
          cardBg,
          textPrimary,
          count: "99+",
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: cardBg,
                title: Text("Nearby Jobs", style: TextStyle(color: textPrimary)),
                content: const Text(
                  "99+ Care shifts available in Gulshan, Banani, and Uttara.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          },
        ),
        _infoBox(
          "Confirmation Letter",
          Icons.email,
          Colors.orange,
          cardBg,
          textPrimary,
          count: "5",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConfirmationLettersScreen(),
              ),
            );
          },
        ),
        _infoBox(
          "Invoices",
          Icons.receipt_long,
          Colors.purple,
          cardBg,
          textPrimary,
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
    Color color,
    Color cardBg,
    Color textPrimary, {
    String? count,
    VoidCallback? onTap,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textPrimary,
                    ),
                  ),
                Text(
                  title,
                  style: TextStyle(fontSize: 11, color: textPrimary),
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

  Widget _buildNoticeBoard(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: cardBg,
            title: Text("Notice Board Details", style: TextStyle(color: textPrimary)),
            content: Text(
              "Our Care Ambassador of the Month, May 2026 has been successfully announced. Keep up the great work!",
              style: TextStyle(color: textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
      child: Card(
        color: cardBg,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.campaign, color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Notice Board",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Our Care Ambassador of the Month, May 2026 is announced! Check details inside.",
                style: TextStyle(fontSize: 13, color: textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecognitionCard(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Card(
      color: cardBg,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.star, color: Colors.white),
        ),
        title: Text(
          "Care Ambassador of the Month",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: textPrimary,
          ),
        ),
        subtitle: Text(
          "ID: 418613 | 5.0 Rating ⭐",
          style: TextStyle(color: textSecondary),
        ),
        trailing: Icon(Icons.chevron_right, color: textSecondary),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyReviewsScreen()),
          );
        },
      ),
    );
  }

  Widget _buildHelplineSection(
    BuildContext context,
    bool isDark,
    Color textSecondary,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: isDark ? AppColors.darkCard : Colors.white,
            title: Text(
              "Helpline Support",
              style: TextStyle(
                color: isDark ? AppColors.darkTextPrimary : Colors.black87,
              ),
            ),
            content: Text(
              "Do you want to call the 24/7 helpline at +880 9612-345678?",
              style: TextStyle(color: textSecondary),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Calling helpline...")),
                  );
                },
                child: const Text("Call Now"),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : mintAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : mintAccent.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.headset_mic, color: isDark ? mintAccent : primaryTeal),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Need Help? Call Helpline",
                  style: TextStyle(fontSize: 11, color: textSecondary),
                ),
                Text(
                  "+880 9612-345678",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? mintAccent : primaryTeal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
