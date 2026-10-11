import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'sign_in_screen.dart';
import '../widgets/role_card.dart';
import '../constants.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // অ্যাপ লোগো বা আইকন (প্রফেশনাল লুকের জন্য ব্যাকগ্রাউন্ড সার্কেলসহ)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.co_present_outlined,
                      color: AppColors.primaryTeal,
                      size: 45,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ওয়েলকাম মেসেজ
                  const Text(
                    "welcome_message",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                  const SizedBox(height: 6),
                  const Text(
                    "Please select your role to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 30),

                  // Care Ambassador Role (Fully Active)
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

                  // Family Member Role (Fully Active)
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

                  // Elderly Member Role (Fully Active)
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
      ),
    );
  }
}
