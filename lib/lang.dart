import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kinvera/main.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ইংরেজি বাটনের জন্য
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('en', 'US'));

                // পরের স্ক্রিনে যাওয়ার জন্য
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoleSelectionScreen(),
                  ),
                );
              },
              child: const Text("welcome_text").tr(),
            ),

            // বাংলা বাটনের জন্য
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('bn', 'BD'));

                // পরের স্ক্রিনে যাওয়ার জন্য একই কমান্ড
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoleSelectionScreen(),
                  ),
                );
              },
              child: const Text("বাংলা"),
            ),
          ],
        ),
      ),
    );
  }
}
