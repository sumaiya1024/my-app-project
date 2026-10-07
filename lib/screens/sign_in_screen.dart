import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// Ambassador Imports
import 'ambassador/ambassador_registration.dart';
import 'ambassador/ambassador_dashboard.dart';

// Other Roles Imports (Family & Elderly)
import 'elderly member/elderly_member_registration.dart';
import 'elderly member/elderly_page.dart';
import 'family member/family_registration.dart';
import 'family member/family_page.dart';

class SignInScreen extends StatefulWidget {
  final String role;
  const SignInScreen({super.key, required this.role});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Color primaryTeal = const Color(0xFF0F766E);
  bool isPasswordHidden = true;

  // Controllers for text fields & validation
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ফরেগট পাসওয়ার্ড ডায়ালগ পপআপ ফাংশন
  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController resetEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Reset Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter your email address to receive a password reset link.",
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: resetEmailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset link sent to your email!"),
                  ),
                );
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }

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

              // Email Field
              TextField(
                controller: emailController,
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

              // Password Field
              TextField(
                controller: passwordController,
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

              // Forgot Password Action
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _showForgotPasswordDialog(context);
                  },
                  child: Text(
                    "forgot_password".tr(),
                    style: TextStyle(color: primaryTeal),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // LOGIN BUTTON WITH VALIDATION
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
                    String passwordText = passwordController.text.trim();

                    // Validation check: Password must not be empty and at least 6 chars
                    if (passwordText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter your password!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (passwordText.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password must be at least 6 characters long!",
                          ),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    } else {
                      // Navigate based on role if validation passes
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
                            builder: (context) =>
                                const ElderlyDashboardScreen(),
                          ),
                        );
                      }
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
