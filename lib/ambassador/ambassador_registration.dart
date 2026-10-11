import 'package:flutter/material.dart';
import 'ambassador_dashboard.dart';

class AmbassadorRegistrationScreen extends StatefulWidget {
  const AmbassadorRegistrationScreen({super.key});

  @override
  State<AmbassadorRegistrationScreen> createState() =>
      _AmbassadorRegistrationScreenState();
}

class _AmbassadorRegistrationScreenState
    extends State<AmbassadorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailOrPhoneController.dispose();
    _nidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AmbassadorDashboard()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryTeal = Color(0xFF0F766E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Care Ambassador Registration",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Full Name
              _buildTextFormField(
                controller: _nameController,
                label: "Full Name *",
                borderColor: primaryTeal,
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your full name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Email or Phone Number (Strict Validation)
              _buildTextFormField(
                controller: _emailOrPhoneController,
                label: "Email Address / Phone Number *",
                borderColor: primaryTeal,
                prefixIcon: Icons.contact_mail_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your email or phone number";
                  }
                  String input = value.trim();

                  // নিখুঁত ইমেইল ভ্যালিডেশন যা অবশ্যই @ এবং ডোমেইন (যেমন .com) থাকতে বাধ্য করবে
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  // বাংলাদেশি সঠিক ফোন নম্বর
                  final phoneRegex = RegExp(r'^(\+88)?01[3-9]\d{8}$');

                  if (!emailRegex.hasMatch(input) &&
                      !phoneRegex.hasMatch(input)) {
                    return "Enter a valid email (e.g., user@gmail.com) or phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // NID / Passport
              _buildTextFormField(
                controller: _nidController,
                label: "NID / Passport Number *",
                borderColor: primaryTeal,
                prefixIcon: Icons.badge_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your NID or Passport number";
                  }
                  if (value.trim().length < 8) {
                    return "NID/Passport number must be at least 8 digits";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password *",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: primaryTeal,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
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
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
                  if (!specialCharRegex.hasMatch(value)) {
                    return "Password must include a special character (@, #, \$ etc.)";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _isLoading ? null : _handleRegistration,
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
                          "Register & Continue",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required Color borderColor,
    required IconData prefixIcon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: encryptedController(controller),
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon, color: borderColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }

  TextEditingController encryptedController(TextEditingController controller) =>
      controller;
}
