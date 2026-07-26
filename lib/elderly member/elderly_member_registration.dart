import 'package:flutter/material.dart';
import 'elderly_page.dart';

class ElderlyRegistrationScreen extends StatelessWidget {
  const ElderlyRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color.fromARGB(255, 39, 255, 183);

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
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField("Full Name *", primaryGreen),
            const SizedBox(height: 15),
            _buildTextField("Age *", primaryGreen),
            const SizedBox(height: 15),
            _buildTextField("Emergency Contact Number *", primaryGreen),
            const SizedBox(height: 15),
            _buildTextField(
              "Primary Health Conditions (e.g. Diabetes, BP)",
              primaryGreen,
            ),
            const SizedBox(height: 15),
            _buildTextField("Password *", primaryGreen, isPassword: true),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // এই onPressed এর ভেতর কোডটি বসবে
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ElderlyDashboardScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }
}
