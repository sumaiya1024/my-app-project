import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'sign_in_screen.dart';
import '../widgets/role_card.dart'; // যদি উইজেট ফোল্ডার থেকে আনতে হয়
import '../constants.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.white,
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
                  color: AppColors.primaryTeal,
                  size: 50,
                ),
                const SizedBox(height: 16),
                const Text(
                  "welcome_message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black87,
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
