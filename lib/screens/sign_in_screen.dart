import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// Ambassador Imports
import 'package:kinvera/ambassador/ambassador_registration.dart';
import 'package:kinvera/ambassador/ambassador_dashboard.dart';
import 'package:kinvera/elderly%20member/elderly_member_registration.dart';
import 'package:kinvera/elderly%20member/elderly_page.dart';
import 'package:kinvera/family%20member/family_page.dart';
import 'package:kinvera/family%20member/family_registration.dart';

class SignInScreen extends StatefulWidget {
  final String role;
  const SignInScreen({super.key, required this.role});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Color primaryTeal = const Color(0xFF0F766E);
  bool isPasswordHidden = true;
  bool _isLoading = false; // লোডিং স্টেট

  // Controllers for text fields & validation
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ফরেগট পাসওয়ার্ড ডায়ালগ পপআপ ফাংশন (ভ্যালিডেশনসহ)
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
                String resetEmail = resetEmailController.text.trim();
                final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );

                if (resetEmail.isEmpty || !emailRegex.hasMatch(resetEmail)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid email address!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset link sent to your email!"),
                    backgroundColor: Colors.green,
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

  // লগইন প্রসেস হ্যান্ডেল করার ফাংশন
  void _handleSignIn() async {
    String emailText = emailController.text.trim();
    String passwordText = passwordController.text.trim();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // স্ট্রিক্ট ভ্যালিডেশন চেক
    if (emailText.isEmpty || !emailRegex.hasMatch(emailText)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your password!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordText.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 6 characters long!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // সব ঠিক থাকলে লোডিং শুরু হবে
    setState(() {
      _isLoading = true;
    });

    // ২ সেকেন্ড ফেক সার্ভার অথেন্টিকেশন সিমুলেশন
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // রোল অনুযায়ী নেভিগেশন
    if (widget.role == "Care Ambassador") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AmbassadorDashboard()),
      );
    } else if (widget.role == "Family Member") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FamilyPage()),
      );
    } else if (widget.role == "Elderly Member") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ElderlyDashboardScreen()),
      );
    }
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
                keyboardType: TextInputType.emailAddress,
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

              // LOGIN BUTTON WITH LOADING STATE
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
                  onPressed: _isLoading ? null : _handleSignIn,
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
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
