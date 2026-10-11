import 'package:flutter/material.dart';
import '../theme_manager.dart';
import '../constants.dart';
import 'admin_data_store.dart';
import '../ambassador/ambassador_dashboard.dart';
import '../elderly%20member/elderly_page.dart';
import '../family%20member/family_page.dart';
import '../screens/role_selection_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AdminDataStore store = AdminDataStore.instance;

  int _selectedTab = 0; // Current active section

  final List<String> _tabs = [
    "Overview",
    "Ambassadors",
    "Elderly Care",
    "Family Members",
    "Shifts & Bookings",
    "Finance & Payouts",
    "Verifications",
    "CEO Messages",
    "Notice Board",
    "System Settings",
  ];

  final List<IconData> _tabIcons = [
    Icons.dashboard_rounded,
    Icons.volunteer_activism_rounded,
    Icons.elderly_rounded,
    Icons.family_restroom_rounded,
    Icons.calendar_month_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.verified_user_rounded,
    Icons.mark_email_unread_rounded,
    Icons.campaign_rounded,
    Icons.settings_suggest_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([store, ThemeManager.themeModeNotifier]),
      builder: (context, _) {
        final isDark = ThemeManager.isDarkMode;
        final Color bgColor =
            isDark ? AppColors.darkBackground : const Color(0xFFF4F7FA);
        final Color cardBg = isDark ? AppColors.darkCard : Colors.white;
        final Color textPrimary =
            isDark ? AppColors.darkTextPrimary : Colors.black87;
        final Color textSecondary =
            isDark ? AppColors.darkTextSecondary : Colors.black54;
        final Color borderColor =
            isDark ? AppColors.darkBorder : const Color(0xFFE2E8F0);
        final Color primaryTeal = AppColors.primaryTeal;
        final Color lightTeal = AppColors.lightTeal;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: _buildAdminAppBar(
            context,
            isDark,
            primaryTeal,
            lightTeal,
            textPrimary,
            cardBg,
          ),
          drawer: _buildAdminSidebar(
            context,
            isDark,
            cardBg,
            textPrimary,
            textSecondary,
            primaryTeal,
            lightTeal,
          ),
          body: Row(
            children: [
              // Permanent Sidebar for Large Screens (Desktop/Web)
              if (MediaQuery.of(context).size.width >= 900)
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: cardBg,
                    border: Border(right: BorderSide(color: borderColor)),
                  ),
                  child: _buildSidebarContent(
                    context,
                    isDark,
                    cardBg,
                    textPrimary,
                    textSecondary,
                    primaryTeal,
                    lightTeal,
                  ),
                ),

              // Main Body Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sub-header Breadcrumb & Quick Search
                      _buildHeaderToolbar(
                        isDark,
                        cardBg,
                        textPrimary,
                        textSecondary,
                        primaryTeal,
                        borderColor,
                      ),
                      const SizedBox(height: 20),

                      // Tab Specific View
                      _buildActiveTabView(
                        context,
                        isDark,
                        cardBg,
                        textPrimary,
                        textSecondary,
                        primaryTeal,
                        lightTeal,
                        borderColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- APPBAR ---
  PreferredSizeWidget _buildAdminAppBar(
    BuildContext context,
    bool isDark,
    Color primaryTeal,
    Color lightTeal,
    Color textPrimary,
    Color cardBg,
  ) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "Kinvera Admin Command Center",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
      backgroundColor: isDark ? const Color(0xFF131D24) : primaryTeal,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        // Role Switcher / Impersonate Quick Menu
        PopupMenuButton<String>(
          icon: const Tooltip(
            message: "Impersonate / Role Switcher",
            child: Icon(Icons.swap_horiz_rounded),
          ),
          onSelected: (val) {
            if (val == "Ambassador") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AmbassadorDashboard(),
                ),
              );
            } else if (val == "Elderly") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ElderlyDashboardScreen(),
                ),
              );
            } else if (val == "Family") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FamilyPage()),
              );
            } else if (val == "Logout") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoleSelectionScreen(),
                ),
                (route) => false,
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: "Ambassador",
              child: Row(
                children: [
                  Icon(Icons.volunteer_activism, color: Colors.teal),
                  SizedBox(width: 10),
                  Text("Open Ambassador Portal"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "Elderly",
              child: Row(
                children: [
                  Icon(Icons.elderly, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Open Elderly Member View"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "Family",
              child: Row(
                children: [
                  Icon(Icons.family_restroom, color: Colors.purple),
                  SizedBox(width: 10),
                  Text("Open Family Member View"),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: "Logout",
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Logout to Role Selection"),
                ],
              ),
            ),
          ],
        ),

        // Dark Mode Header Toggle
        IconButton(
          tooltip: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: Colors.amber,
          ),
          onPressed: () {
            ThemeManager.toggleTheme();
          },
        ),

        // Notifications Badge
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_none_rounded),
              if (store.ceoMessages.any((m) => m['status'] == 'Unread') ||
                  store.payouts.any((p) => p['status'] == 'Pending'))
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            _showQuickAlertsDialog(context, isDark, cardBg, textPrimary);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- SIDEBAR DRAWER (FOR MOBILE) ---
  Widget _buildAdminSidebar(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color lightTeal,
  ) {
    return Drawer(
      backgroundColor: cardBg,
      child: _buildSidebarContent(
        context,
        isDark,
        cardBg,
        textPrimary,
        textSecondary,
        primaryTeal,
        lightTeal,
      ),
    );
  }

  // --- SIDEBAR CONTENT ---
  Widget _buildSidebarContent(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color lightTeal,
  ) {
    final unreadMsgs =
        store.ceoMessages.where((m) => m['status'] == 'Unread').length;
    final pendingPayouts =
        store.payouts.where((p) => p['status'] == 'Pending').length;
    final pendingDocs =
        store.documents.where((d) => d['status'] == 'Pending').length;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: isDark
                ? const LinearGradient(
                    colors: [Color(0xFF131D24), Color(0xFF163238)],
                  )
                : LinearGradient(colors: [primaryTeal, lightTeal]),
          ),
          accountName: const Text(
            "Super Administrator",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          accountEmail: const Text("admin@kinvera.org | Master Control"),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.security_rounded, size: 36, color: Color(0xFF0F766E)),
          ),
        ),
        for (int i = 0; i < _tabs.length; i++)
          ListTile(
            selected: _selectedTab == i,
            selectedTileColor:
                isDark
                    ? lightTeal.withValues(alpha: 0.15)
                    : primaryTeal.withValues(alpha: 0.1),
            leading: Icon(
              _tabIcons[i],
              color:
                  _selectedTab == i
                      ? (isDark ? lightTeal : primaryTeal)
                      : (isDark ? Colors.white60 : Colors.black54),
            ),
            title: Text(
              _tabs[i],
              style: TextStyle(
                fontWeight:
                    _selectedTab == i ? FontWeight.bold : FontWeight.w500,
                color:
                    _selectedTab == i
                        ? (isDark ? lightTeal : primaryTeal)
                        : textPrimary,
                fontSize: 14,
              ),
            ),
            trailing: _buildTabBadge(i, unreadMsgs, pendingPayouts, pendingDocs),
            onTap: () {
              setState(() {
                _selectedTab = i;
              });
              if (Scaffold.of(context).isDrawerOpen) {
                Navigator.pop(context);
              }
            },
          ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app, color: Colors.red),
          title: const Text("Exit to Main App", style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  Widget? _buildTabBadge(
    int index,
    int unreadMsgs,
    int pendingPayouts,
    int pendingDocs,
  ) {
    int count = 0;
    Color color = Colors.orange;

    if (index == 5 && pendingPayouts > 0) {
      count = pendingPayouts;
      color = Colors.amber.shade800;
    } else if (index == 6 && pendingDocs > 0) {
      count = pendingDocs;
      color = Colors.blue;
    } else if (index == 7 && unreadMsgs > 0) {
      count = unreadMsgs;
      color = Colors.red;
    }

    if (count > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "$count",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return null;
  }

  // --- HEADER TOOLBAR ---
  Widget _buildHeaderToolbar(
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(_tabIcons[_selectedTab], color: primaryTeal, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _tabs[_selectedTab],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                Text(
                  "Manage, audit, and configure platform components in real-time.",
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
              ],
            ),
          ),
          // Live status chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 4, backgroundColor: Colors.green),
                SizedBox(width: 6),
                Text(
                  "Live & Synced",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- ACTIVE TAB ROUTER ---
  Widget _buildActiveTabView(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color lightTeal,
    Color borderColor,
  ) {
    switch (_selectedTab) {
      case 0:
        return _buildOverviewTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          lightTeal,
          borderColor,
        );
      case 1:
        return _buildAmbassadorsTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          lightTeal,
          borderColor,
        );
      case 2:
        return _buildElderlyTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 3:
        return _buildFamilyTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 4:
        return _buildShiftsTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 5:
        return _buildFinanceTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 6:
        return _buildVerificationsTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 7:
        return _buildCeoMessagesTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 8:
        return _buildNoticeBoardTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      case 9:
        return _buildSystemSettingsTab(
          context,
          isDark,
          cardBg,
          textPrimary,
          textSecondary,
          primaryTeal,
          borderColor,
        );
      default:
        return const SizedBox();
    }
  }

  // ==========================================
  // TAB 0: EXECUTIVE OVERVIEW
  // ==========================================
  Widget _buildOverviewTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color lightTeal,
    Color borderColor,
  ) {
    final totalAmbassadors = store.ambassadors.length;
    final totalElderly = store.elderlyMembers.length;
    final totalFamily = store.familyMembers.length;
    final activeShifts =
        store.shifts
            .where((s) => s['status'] == 'In Progress' || s['status'] == 'Scheduled')
            .length;
    final pendingPayouts =
        store.payouts.where((p) => p['status'] == 'Pending').length;
    final unreadMsgs =
        store.ceoMessages.where((m) => m['status'] == 'Unread').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. KPI Metrics Grid
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.6,
              children: [
                _buildKpiCard(
                  "Total Ambassadors",
                  "$totalAmbassadors",
                  "Verified: ${store.ambassadors.where((a) => a['status'] == 'Verified').length}",
                  Icons.volunteer_activism,
                  Colors.teal,
                  cardBg,
                  textPrimary,
                  textSecondary,
                  borderColor,
                ),
                _buildKpiCard(
                  "Elderly & Families",
                  "$totalElderly",
                  "$totalFamily Linked Families",
                  Icons.elderly,
                  Colors.blue,
                  cardBg,
                  textPrimary,
                  textSecondary,
                  borderColor,
                ),
                _buildKpiCard(
                  "Active Shifts Today",
                  "$activeShifts",
                  "In Progress & Scheduled",
                  Icons.calendar_today,
                  Colors.green,
                  cardBg,
                  textPrimary,
                  textSecondary,
                  borderColor,
                ),
                _buildKpiCard(
                  "Pending Approvals",
                  "${pendingPayouts + unreadMsgs}",
                  "$pendingPayouts Payouts • $unreadMsgs Messages",
                  Icons.pending_actions,
                  Colors.orange,
                  cardBg,
                  textPrimary,
                  textSecondary,
                  borderColor,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),

        // 2. Emergency SOS Alert Bar
        if (store.emergencyLogs.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.warning_amber_rounded, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Emergency SOS Log Status",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Latest incident: ${store.emergencyLogs.first['elderly']} (${store.emergencyLogs.first['location']}) - ${store.emergencyLogs.first['status']}",
                        style: TextStyle(color: textPrimary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _showSosDetailsDialog(context, isDark, cardBg, textPrimary);
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text("View SOS"),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24),

        // 3. Quick Action Hub
        Text(
          "Quick Actions & Operations",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () => _showAddAmbassadorDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.person_add),
              label: const Text("Register Ambassador"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () => _showAddShiftDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.add_task),
              label: const Text("Create Shift"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () => _showAddAnnouncementDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.campaign),
              label: const Text("Post Announcement"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  _selectedTab = 5; // Jump to payouts
                });
              },
              icon: const Icon(Icons.payments),
              label: Text("Process Payouts ($pendingPayouts)"),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // 4. Recent Shifts Table
        Text(
          "Recent Care Shifts",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: store.shifts.take(4).length,
            separatorBuilder: (_, _) => Divider(color: borderColor, height: 1),
            itemBuilder: (context, index) {
              final shift = store.shifts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: primaryTeal.withValues(alpha: 0.15),
                  child: Icon(Icons.schedule, color: primaryTeal),
                ),
                title: Text(
                  "${shift['ambassador']} ➔ ${shift['elderly']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  "${shift['date']} • ${shift['time']} • ${shift['location']}",
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                trailing: _buildStatusBadge(shift['status']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color borderColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: AMBASSADORS MANAGEMENT
  // ==========================================
  Widget _buildAmbassadorsTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color lightTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Care Ambassadors Directory (${store.ambassadors.length})",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _showAddAmbassadorDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.add),
              label: const Text("Add Ambassador"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.ambassadors.length,
          itemBuilder: (context, index) {
            final amb = store.ambassadors[index];
            final bool isOnDuty = amb['isOnDuty'] == true;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: primaryTeal.withValues(alpha: 0.15),
                    child: Text(
                      amb['name'].toString().substring(0, 1),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryTeal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              amb['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildStatusBadge(amb['status']),
                            if (amb['badge'] != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  amb['badge'],
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ID: ${amb['id']} • ${amb['email']} • ${amb['phone']}",
                          style: TextStyle(color: textSecondary, fontSize: 12),
                        ),
                        Text(
                          "Area: ${amb['area']} • Shifts Done: ${amb['shiftsCompleted']} • Rating: ${amb['rating']} ⭐",
                          style: TextStyle(color: textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  // Duty Toggle & Actions
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            isOnDuty ? "Online" : "Offline",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isOnDuty ? Colors.green : Colors.grey,
                            ),
                          ),
                          Switch(
                            value: isOnDuty,
                            activeThumbColor: Colors.green,
                            onChanged: (_) {
                              store.toggleDutyStatus(amb['id']);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: textSecondary),
                        onSelected: (val) {
                          if (val == "Verify") {
                            store.updateAmbassadorStatus(amb['id'], "Verified");
                          } else if (val == "Suspend") {
                            store.updateAmbassadorStatus(amb['id'], "Suspended");
                          } else if (val == "Delete") {
                            store.deleteAmbassador(amb['id']);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "Verify",
                            child: Text("Mark as Verified"),
                          ),
                          const PopupMenuItem(
                            value: "Suspend",
                            child: Text("Suspend Account"),
                          ),
                          const PopupMenuItem(
                            value: "Delete",
                            child: Text("Delete Ambassador", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 2: ELDERLY MEMBERS
  // ==========================================
  Widget _buildElderlyTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Elderly Members Care Profiles (${store.elderlyMembers.length})",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _showAddElderlyDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.add),
              label: const Text("New Profile"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.elderlyMembers.length,
          itemBuilder: (context, index) {
            final eld = store.elderlyMembers[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue.withValues(alpha: 0.15),
                            child: const Icon(Icons.elderly, color: Colors.blue),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${eld['name']} (${eld['age']} Yrs, ${eld['gender']})",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Blood: ${eld['bloodGroup']}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => store.deleteElderly(eld['id']),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Address: ${eld['address']}",
                    style: TextStyle(fontSize: 12, color: textSecondary),
                  ),
                  Text(
                    "Medical Conditions: ${eld['medicalCondition']}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  Text(
                    "Emergency: ${eld['emergencyContact']}",
                    style: TextStyle(fontSize: 12, color: textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Assigned Caregiver: ${eld['assignedCaregiver']}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: primaryTeal,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryTeal.withValues(alpha: 0.1),
                          foregroundColor: primaryTeal,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        onPressed: () {
                          _showReassignCaregiverDialog(
                            context,
                            eld['id'],
                            cardBg,
                            textPrimary,
                          );
                        },
                        child: const Text("Reassign Caregiver"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 3: FAMILY MEMBERS
  // ==========================================
  Widget _buildFamilyTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Registered Family Members (${store.familyMembers.length})",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _showAddFamilyDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.add),
              label: const Text("Add Family"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.familyMembers.length,
          itemBuilder: (context, index) {
            final fam = store.familyMembers[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.purple.withValues(alpha: 0.15),
                  child: const Icon(Icons.family_restroom, color: Colors.purple),
                ),
                title: Text(
                  "${fam['name']} (${fam['relation']} of ${fam['linkedElderly']})",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  "${fam['phone']} • ${fam['email']} • Billing: ${fam['paymentMethod']}",
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => store.deleteFamilyMember(fam['id']),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 4: SHIFTS & BOOKINGS
  // ==========================================
  Widget _buildShiftsTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Care Shift Dispatcher & Schedule (${store.shifts.length})",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _showAddShiftDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.add),
              label: const Text("Dispatch Shift"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.shifts.length,
          itemBuilder: (context, index) {
            final shift = store.shifts[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryTeal.withValues(alpha: 0.15),
                    child: Icon(Icons.calendar_month, color: primaryTeal),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Caregiver: ${shift['ambassador']} ➔ Client: ${shift['elderly']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${shift['date']} • ${shift['time']} • Fee: ৳ ${shift['fee']}",
                          style: TextStyle(color: textSecondary, fontSize: 12),
                        ),
                        Text(
                          "Location: ${shift['location']}",
                          style: TextStyle(color: textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(shift['status']),
                  const SizedBox(width: 10),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.edit_note, color: textSecondary),
                    onSelected: (val) {
                      if (val == "Delete") {
                        store.deleteShift(shift['id']);
                      } else {
                        store.updateShiftStatus(shift['id'], val);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "Scheduled",
                        child: Text("Set as Scheduled"),
                      ),
                      const PopupMenuItem(
                        value: "In Progress",
                        child: Text("Set as In Progress"),
                      ),
                      const PopupMenuItem(
                        value: "Completed",
                        child: Text("Mark as Completed"),
                      ),
                      const PopupMenuItem(
                        value: "Cancelled",
                        child: Text("Cancel Shift"),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: "Delete",
                        child: Text("Delete Record", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 5: FINANCE & PAYOUTS
  // ==========================================
  Widget _buildFinanceTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    final pendingPayouts =
        store.payouts.where((p) => p['status'] == 'Pending').toList();
    final completedPayouts =
        store.payouts.where((p) => p['status'] != 'Pending').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ambassador Payout Requests & Financial Reconciliation",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        if (pendingPayouts.isNotEmpty) ...[
          const Text(
            "Pending Payout Approvals (Action Required)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pendingPayouts.length,
            itemBuilder: (context, index) {
              final pay = pendingPayouts[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.currency_exchange, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${pay['ambassador']} - ৳ ${pay['amount']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            "Method: ${pay['method']} • Account: ${pay['account']} • Date: ${pay['date']}",
                            style: TextStyle(color: textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _showApprovePayoutDialog(
                          context,
                          pay['id'],
                          cardBg,
                          textPrimary,
                        );
                      },
                      child: const Text("Approve Payout"),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: () => store.rejectPayout(pay['id']),
                      child: const Text("Reject"),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],

        Text(
          "Payout History & Completed Statements",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: completedPayouts.length,
          itemBuilder: (context, index) {
            final pay = completedPayouts[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.15),
                  child: const Icon(Icons.check_circle, color: Colors.green),
                ),
                title: Text(
                  "${pay['ambassador']} • ৳ ${pay['amount']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                subtitle: Text(
                  "Trx ID: ${pay['trxId']} • ${pay['method']} (${pay['account']})",
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                trailing: _buildStatusBadge(pay['status']),
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 6: VERIFICATIONS & DOCUMENTS
  // ==========================================
  Widget _buildVerificationsTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Document Verifications & Compliance Queue (${store.documents.length})",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.documents.length,
          itemBuilder: (context, index) {
            final doc = store.documents[index];
            final bool isPending = doc['status'] == "Pending";

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isPending ? Colors.blue.withValues(alpha: 0.4) : borderColor,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.withValues(alpha: 0.15),
                    child: const Icon(Icons.file_copy, color: Colors.blue),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc['applicant']} - ${doc['docType']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        Text(
                          "Submitted: ${doc['date']} • Notes: ${doc['notes']}",
                          style: TextStyle(color: textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(doc['status']),
                  if (isPending) ...[
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => store.approveDocument(doc['id']),
                      child: const Text("Approve"),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: () => store.rejectDocument(doc['id']),
                      child: const Text("Reject"),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 7: CEO MESSAGES
  // ==========================================
  Widget _buildCeoMessagesTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Direct Messages to CEO & Executive Feedback (${store.ceoMessages.length})",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.ceoMessages.length,
          itemBuilder: (context, index) {
            final msg = store.ceoMessages[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color:
                      msg['priority'] == 'High'
                          ? Colors.orange.withValues(alpha: 0.5)
                          : borderColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: primaryTeal.withValues(alpha: 0.15),
                            child: Icon(Icons.person, size: 18, color: primaryTeal),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${msg['sender']} (${msg['role']})",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildPriorityBadge(msg['priority']),
                          const SizedBox(width: 8),
                          _buildStatusBadge(msg['status']),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    msg['subject'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg['message'],
                    style: TextStyle(fontSize: 13, color: textSecondary, height: 1.4),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        msg['date'],
                        style: TextStyle(fontSize: 11, color: textSecondary),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              store.updateCeoMessageStatus(msg['id'], "Resolved");
                            },
                            child: const Text("Mark Resolved"),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () => store.deleteCeoMessage(msg['id']),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 8: NOTICE BOARD
  // ==========================================
  Widget _buildNoticeBoardTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Public Announcements & Notice Board (${store.announcements.length})",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _showAddAnnouncementDialog(context, cardBg, textPrimary),
              icon: const Icon(Icons.add),
              label: const Text("New Notice"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: store.announcements.length,
          itemBuilder: (context, index) {
            final ann = store.announcements[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber.withValues(alpha: 0.15),
                    child: const Icon(Icons.campaign, color: Colors.amber),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ann['title'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimary,
                                ),
                              ),
                            ),
                            if (ann['isPinned'] == true)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "PINNED",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ann['content'],
                          style: TextStyle(fontSize: 13, color: textSecondary),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Date: ${ann['date']} • Target: ${ann['target']}",
                          style: TextStyle(fontSize: 11, color: textSecondary),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => store.deleteAnnouncement(ann['id']),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 9: SYSTEM SETTINGS
  // ==========================================
  Widget _buildSystemSettingsTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color primaryTeal,
    Color borderColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Global Platform Configuration & System Controls",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(
                  "Automated Caregiver Dispatcher",
                  style: TextStyle(fontWeight: FontWeight.bold, color: textPrimary),
                ),
                subtitle: Text(
                  "Automatically match nearby on-duty ambassadors to elderly bookings",
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                value: store.autoDispatch,
                activeThumbColor: primaryTeal,
                onChanged: (val) {
                  store.updateSettings(autoDispatch: val);
                },
              ),
              const Divider(),
              SwitchListTile(
                title: Text(
                  "Emergency Maintenance Mode",
                  style: TextStyle(fontWeight: FontWeight.bold, color: textPrimary),
                ),
                subtitle: Text(
                  "Temporarily disable client booking forms for scheduled database maintenance",
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                value: store.maintenanceMode,
                activeThumbColor: Colors.red,
                onChanged: (val) {
                  store.updateSettings(maintenanceMode: val);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "Platform Commission Fee",
                  style: TextStyle(fontWeight: FontWeight.bold, color: textPrimary),
                ),
                subtitle: Text(
                  "Currently ${store.platformCommissionRate}% deducted on caregiver completed shift earnings",
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                trailing: Text(
                  "${store.platformCommissionRate}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryTeal,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "Central 24/7 Helpline Number",
                  style: TextStyle(fontWeight: FontWeight.bold, color: textPrimary),
                ),
                subtitle: Text(
                  store.supportHotline,
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                trailing: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Helpline is active and online")),
                    );
                  },
                  child: const Text("Verified"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- BADGES ---
  Widget _buildStatusBadge(String status) {
    Color color = Colors.grey;
    if (status == "Verified" || status == "Approved" || status == "Completed") {
      color = Colors.green;
    } else if (status == "In Progress" || status == "Scheduled" || status == "Confirmed") {
      color = Colors.blue;
    } else if (status == "Pending" || status == "In Review" || status == "Unread") {
      color = Colors.orange;
    } else if (status == "Suspended" || status == "Rejected" || status == "Cancelled") {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = Colors.blue;
    if (priority == "High" || priority == "Urgent") {
      color = Colors.red;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        priority,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ==========================================
  // DIALOGS & ACTIONS
  // ==========================================

  void _showAddAmbassadorDialog(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
  ) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final areaCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("Register New Ambassador", style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email Address"),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            TextField(
              controller: areaCtrl,
              decoration: const InputDecoration(labelText: "Service Area (e.g. Gulshan, Dhaka)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                store.addAmbassador({
                  "id": "AMB-${DateTime.now().millisecondsSinceEpoch % 10000}",
                  "name": nameCtrl.text.trim(),
                  "email": emailCtrl.text.trim(),
                  "phone": phoneCtrl.text.trim(),
                  "area": areaCtrl.text.trim().isEmpty ? "Dhaka" : areaCtrl.text.trim(),
                  "rating": 5.0,
                  "shiftsCompleted": 0,
                  "status": "Verified",
                  "isOnDuty": true,
                  "earnings": 0.0,
                  "badge": "Newly Verified",
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ambassador registered successfully!")),
                );
              }
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }

  void _showAddElderlyDialog(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
  ) {
    final nameCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    final medCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("Add Elderly Profile", style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Elderly Full Name"),
            ),
            TextField(
              controller: ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age (e.g. 75)"),
            ),
            TextField(
              controller: medCtrl,
              decoration: const InputDecoration(labelText: "Medical Conditions"),
            ),
            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(labelText: "Address / Location"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                store.addElderly({
                  "id": "ELD-${DateTime.now().millisecondsSinceEpoch % 10000}",
                  "name": nameCtrl.text.trim(),
                  "age": int.tryParse(ageCtrl.text) ?? 70,
                  "gender": "Senior",
                  "address": addressCtrl.text.trim().isEmpty ? "Dhaka" : addressCtrl.text.trim(),
                  "emergencyContact": "+880 1711-000000",
                  "medicalCondition": medCtrl.text.trim().isEmpty ? "Regular check-up" : medCtrl.text.trim(),
                  "assignedCaregiver": store.ambassadors.first['name'],
                  "medicationStatus": true,
                  "bloodGroup": "O+",
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Elderly profile created!")),
                );
              }
            },
            child: const Text("Add Profile"),
          ),
        ],
      ),
    );
  }

  void _showAddFamilyDialog(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
  ) {
    final nameCtrl = TextEditingController();
    final relCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("Add Family Member", style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Family Member Name"),
            ),
            TextField(
              controller: relCtrl,
              decoration: const InputDecoration(labelText: "Relation (e.g. Son, Daughter)"),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                store.addFamilyMember({
                  "id": "FAM-${DateTime.now().millisecondsSinceEpoch % 10000}",
                  "name": nameCtrl.text.trim(),
                  "phone": phoneCtrl.text.trim(),
                  "email": "${nameCtrl.text.toLowerCase().replaceAll(' ', '')}@gmail.com",
                  "relation": relCtrl.text.trim().isEmpty ? "Guardian" : relCtrl.text.trim(),
                  "linkedElderly": store.elderlyMembers.first['name'],
                  "status": "Active",
                  "paymentMethod": "Bkash Auto-Pay",
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Family member added!")),
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showAddShiftDialog(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
  ) {
    String selectedAmb = store.ambassadors.first['name'];
    String selectedEld = store.elderlyMembers.first['name'];
    final timeCtrl = TextEditingController(text: "10:00 AM - 02:00 PM");
    final locCtrl = TextEditingController(text: "Gulshan 2, Dhaka");

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: cardBg,
            title: Text("Dispatch Care Shift", style: TextStyle(color: textPrimary)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: selectedAmb,
                  decoration: const InputDecoration(labelText: "Assign Ambassador"),
                  items: store.ambassadors
                      .map((a) => DropdownMenuItem(
                            value: a['name'] as String,
                            child: Text(a['name']),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedAmb = val);
                  },
                ),
                DropdownButtonFormField<String>(
                  initialValue: selectedEld,
                  decoration: const InputDecoration(labelText: "Care For (Elderly)"),
                  items: store.elderlyMembers
                      .map((e) => DropdownMenuItem(
                            value: e['name'] as String,
                            child: Text(e['name']),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedEld = val);
                  },
                ),
                TextField(
                  controller: timeCtrl,
                  decoration: const InputDecoration(labelText: "Shift Timing"),
                ),
                TextField(
                  controller: locCtrl,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  store.addShift({
                    "id": "SHF-${DateTime.now().millisecondsSinceEpoch % 10000}",
                    "ambassador": selectedAmb,
                    "elderly": selectedEld,
                    "date": "Today, Oct 12",
                    "time": timeCtrl.text.trim(),
                    "location": locCtrl.text.trim(),
                    "status": "Scheduled",
                    "fee": 1200.0,
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Shift dispatched successfully!")),
                  );
                },
                child: const Text("Dispatch"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddAnnouncementDialog(
    BuildContext context,
    Color cardBg,
    Color textPrimary,
  ) {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();
    String target = "All";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("Post Public Announcement", style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: "Announcement Title"),
            ),
            TextField(
              controller: bodyCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Message Content"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.isNotEmpty) {
                store.addAnnouncement({
                  "id": "ANN-${DateTime.now().millisecondsSinceEpoch % 10000}",
                  "title": titleCtrl.text.trim(),
                  "content": bodyCtrl.text.trim(),
                  "date": "Today",
                  "target": target,
                  "isPinned": true,
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Announcement published to all portals!")),
                );
              }
            },
            child: const Text("Publish"),
          ),
        ],
      ),
    );
  }

  void _showApprovePayoutDialog(
    BuildContext context,
    String id,
    Color cardBg,
    Color textPrimary,
  ) {
    final trxCtrl = TextEditingController(text: "BK${DateTime.now().millisecondsSinceEpoch % 1000000}");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("Confirm Payout Disbursement", style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Please verify that the money transfer has been initiated, and specify the Transaction ID:",
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: trxCtrl,
              decoration: const InputDecoration(labelText: "Transaction Reference ID"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              store.approvePayout(id, trxCtrl.text.trim());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Payout approved and transaction completed!")),
              );
            },
            child: const Text("Confirm Disbursement"),
          ),
        ],
      ),
    );
  }

  void _showReassignCaregiverDialog(
    BuildContext context,
    String elderlyId,
    Color cardBg,
    Color textPrimary,
  ) {
    String selected = store.ambassadors.first['name'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: cardBg,
          title: Text("Select New Caregiver", style: TextStyle(color: textPrimary)),
          content: DropdownButtonFormField<String>(
            initialValue: selected,
            decoration: const InputDecoration(labelText: "Select Ambassador"),
            items: store.ambassadors
                .map((a) => DropdownMenuItem(
                      value: a['name'] as String,
                      child: Text(a['name']),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null) setDialogState(() => selected = val);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                store.updateElderlyCaregiver(elderlyId, selected);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Caregiver updated to $selected")),
                );
              },
              child: const Text("Reassign"),
            ),
          ],
        ),
      ),
    );
  }

  void _showSosDetailsDialog(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("Emergency SOS Logs", style: TextStyle(color: textPrimary)),
        content: SizedBox(
          width: 400,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: store.emergencyLogs.length,
            itemBuilder: (context, index) {
              final sos = store.emergencyLogs[index];
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text(
                  "${sos['elderly']} (${sos['location']})",
                  style: TextStyle(fontWeight: FontWeight.bold, color: textPrimary),
                ),
                subtitle: Text(
                  "${sos['time']} • ${sos['notes']}",
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: _buildStatusBadge(sos['status']),
              );
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showQuickAlertsDialog(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textPrimary,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        title: Text("System Notifications", style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• ${store.payouts.where((p) => p['status'] == 'Pending').length} pending payouts awaiting verification"),
            const SizedBox(height: 6),
            Text("• ${store.ceoMessages.where((m) => m['status'] == 'Unread').length} unread direct CEO feedback inquiries"),
            const SizedBox(height: 6),
            Text("• ${store.documents.where((d) => d['status'] == 'Pending').length} ambassador compliance documents in queue"),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Dismiss"),
          ),
        ],
      ),
    );
  }
}
