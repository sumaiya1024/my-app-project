import 'package:flutter/material.dart';
import 'elderly_page.dart';

class ElderlyRegistrationScreen extends StatefulWidget {
  const ElderlyRegistrationScreen({super.key});

  @override
  State<ElderlyRegistrationScreen> createState() =>
      _ElderlyRegistrationScreenState();
}

class _ElderlyRegistrationScreenState extends State<ElderlyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _healthController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // ২ সেকেন্ড ফেক লোডিং বা সার্ভার রিকোয়েস্ট সিমুলেশন
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ElderlyDashboardScreen()),
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
          "Elderly Registration",
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

              // Age
              _buildTextFormField(
                controller: _ageController,
                label: "Age *",
                borderColor: primaryTeal,
                prefixIcon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your age";
                  }
                  int? age = int.tryParse(value.trim());
                  if (age == null || age <= 0 || age > 120) {
                    return "Please enter a valid age";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Emergency Contact Number
              _buildTextFormField(
                controller: _phoneController,
                label: "Emergency Contact Number *",
                borderColor: primaryTeal,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter emergency contact number";
                  }
                  final phoneRegex = RegExp(r'^(\+88)?01[3-9]\d{8}$');
                  if (!phoneRegex.hasMatch(value.trim())) {
                    return "Enter a valid Bangladeshi phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Primary Health Conditions (Optional/Flexible)
              _buildTextFormField(
                controller: _healthController,
                label: "Primary Health Conditions (e.g. Diabetes, BP)",
                borderColor: primaryTeal,
                prefixIcon: Icons.medical_services_outlined,
              ),
              const SizedBox(height: 15),

              // Password with Visibility Toggle
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

              // Sign Up Button with Loading
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
                          "Sign Up",
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
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
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
}
