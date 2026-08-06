import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'lang.dart';

// Ambassador Imports (Ambassador ড্যাশবোর্ড ও রেজিস্ট্রেশন)
import 'ambassador/ambassador_registration.dart';
import 'ambassador/ambassador_dashboard.dart';

// Other Roles Imports (Family & Elderly)
import 'elderly member/elderly_member_registration.dart';
import 'elderly member/elderly_page.dart'; // এখানে ElderlyDashboardScreen রয়েছে
import 'family member/family_registration.dart';
import 'family member/family_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const Splashscreen(),
    );
  }
}

// ==========================================
// ১. স্প্ল্যাশ স্ক্রিন
// ==========================================
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LanguageSelectionScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF14B8A6).withValues(alpha: 0.1),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Kinvera',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F766E),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Connect, Care, Comfort',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'v2.6.2.256',
                style: TextStyle(
                  color: Colors.grey.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ২. রোল সিলেকশন স্ক্রিন
// ==========================================
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.co_present_outlined,
                  color: Color(0xFF0F766E),
                  size: 50,
                ),
                const SizedBox(height: 16),
                const Text(
                  "welcome_message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                const SizedBox(height: 30),

                // Care Ambassador Role
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignInScreen(role: "Care Ambassador"),
                      ),
                    );
                  },
                  child: const RoleCard(
                    title: "care_ambassador_title",
                    subtitle: "care_ambassador_subtitle",
                    icon: Icons.volunteer_activism,
                    avatarLeft: true,
                  ),
                ),
                const SizedBox(height: 16),

                // Family Member Role
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignInScreen(role: "Family Member"),
                      ),
                    );
                  },
                  child: const RoleCard(
                    title: "family_member_title",
                    subtitle: "family_member_subtitle",
                    icon: Icons.family_restroom,
                    avatarLeft: false,
                  ),
                ),
                const SizedBox(height: 16),

                // Elderly Member Role
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignInScreen(role: "Elderly Member"),
                      ),
                    );
                  },
                  child: const RoleCard(
                    title: "elderly_member_title",
                    subtitle: "elderly_member_subtitle",
                    icon: Icons.elderly,
                    avatarLeft: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// ৩. রোল কার্ড উইজেট
// ==========================================
class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool avatarLeft;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.avatarLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14B8A6).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF0F766E).withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, size: 40, color: const Color(0xFF0F766E)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: avatarLeft ? 16.0 : 0,
                left: avatarLeft ? 0 : 16.0,
                top: 12,
                bottom: 12,
              ),
              child: Column(
                crossAxisAlignment: avatarLeft
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    title.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle.tr(),
                    textAlign: avatarLeft ? TextAlign.left : TextAlign.right,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ৪. কমন Sign In স্ক্রিন
// ==========================================
class SignInScreen extends StatefulWidget {
  final String role;
  const SignInScreen({super.key, required this.role});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Color primaryTeal = const Color(0xFF0F766E);
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryTeal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.role == "Care Ambassador"
                      ? Icons.volunteer_activism
                      : widget.role == "Family Member"
                      ? Icons.family_restroom
                      : Icons.elderly,
                  size: 60,
                  color: primaryTeal,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.role,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                "sign_in_continue",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ).tr(),
              const SizedBox(height: 40),

              TextField(
                decoration: InputDecoration(
                  labelText: "email_address".tr(),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryTeal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "password".tr(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryTeal, width: 2),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "forgot_password".tr(),
                    style: TextStyle(color: primaryTeal),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // LOGIN BUTTON ACTION
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (widget.role == "Care Ambassador") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AmbassadorDashboard(),
                        ),
                      );
                    } else if (widget.role == "Family Member") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FamilyPage(),
                        ),
                      );
                    } else if (widget.role == "Elderly Member") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ElderlyDashboardScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "sign_in_btn",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ),
              ),
              const SizedBox(height: 20),

              // SIGN UP BUTTON ACTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("no_account").tr(),
                  TextButton(
                    onPressed: () {
                      if (widget.role == "Care Ambassador") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AmbassadorRegistrationScreen(),
                          ),
                        );
                      } else if (widget.role == "Family Member") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FamilyRegistrationScreen(),
                          ),
                        );
                      } else if (widget.role == "Elderly Member") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ElderlyRegistrationScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "sign_up_btn".tr(),
                      style: TextStyle(
                        color: primaryTeal,
                        fontWeight: FontWeight.bold,
                      ),
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
