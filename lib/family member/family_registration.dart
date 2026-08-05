// ৫. Family Member Registration
import 'package:flutter/material.dart';
import 'family_page.dart';

class FamilyRegistrationScreen extends StatelessWidget {
  const FamilyRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Teal & Mint Green Theme Colors
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
        child: Column(
          children: [
            _buildTextField("Full Name *", primaryTeal),
            const SizedBox(height: 15),
            _buildTextField("Phone Number *", primaryTeal),
            const SizedBox(height: 15),
            _buildTextField("Email Address *", primaryTeal),
            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Relation to Elderly *",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryTeal, width: 2),
                ),
              ),
              items:
                  [
                    "Parent",
                    "Son",
                    "Daughter",
                    "Grandparent",
                    "Spouse",
                    "Other",
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (val) {},
            ),

            const SizedBox(height: 15),
            _buildTextField("Password *", primaryTeal, isPassword: true),
            const SizedBox(height: 30),

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FamilyPage()),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    Color borderColor, {
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }
}
