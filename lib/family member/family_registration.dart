import 'package:flutter/material.dart';
import 'family_page.dart';

class FamilyRegistrationScreen extends StatefulWidget {
  const FamilyRegistrationScreen({super.key});

  @override
  State<FamilyRegistrationScreen> createState() =>
      _FamilyRegistrationScreenState();
}

class _FamilyRegistrationScreenState extends State<FamilyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ড্রপডাউনের নির্বাচিত ভ্যালু রাখার জন্য ভেরিয়েবল
  String? _selectedRelation;
  final List<String> _relations = [
    "Parent",
    "Son",
    "Daughter",
    "Grandparent",
    "Spouse",
    "Other",
  ];

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // রেজিস্ট্রেশন বা সাবমিট হ্যান্ডেল করার ফাংশন
  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // ২ সেকেন্ড ফেক লোডিং বা সার্ভার প্রসেসিং সিমুলেশন
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FamilyPage()),
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
          "Family Registration",
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

              // Phone Number
              _buildTextFormField(
                controller: _phoneController,
                label: "Phone Number *",
                borderColor: primaryTeal,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your phone number";
                  }
                  final phoneRegex = RegExp(r'^(\+88)?01[3-9]\d{8}$');
                  if (!phoneRegex.hasMatch(value.trim())) {
                    return "Enter a valid Bangladeshi phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Email Address (Universal Validation)
              _buildTextFormField(
                controller: _emailController,
                label: "Email Address *",
                borderColor: primaryTeal,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your email address";
                  }
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Enter a valid email address (e.g., user@gmail.com)";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Dropdown Field (Relation to Elderly) - ফুললি সচল করা হয়েছে
              DropdownButtonFormField<String>(
                value: _selectedRelation,
                decoration: InputDecoration(
                  labelText: "Relation to Elderly *",
                  prefixIcon: const Icon(
                    Icons.family_restroom,
                    color: primaryTeal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryTeal, width: 2),
                  ),
                ),
                items: _relations.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedRelation = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select your relation";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Password with Visibility Toggle & Strict Rules
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
                    borderSide: const BorderSide(color: primaryTeal, width: 2),
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

              // Sign Up Button with Loading State
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

  // কাস্টম টেক্সটFormField উইজেট
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
