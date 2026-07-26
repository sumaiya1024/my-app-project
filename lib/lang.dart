import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main.dart'; // যদি RoleSelectionScreen ক্লাসটি main.dart ফাইলে থাকে

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

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoleSelectionScreen(),
                  ),
                );
              },
              child: Text("English".tr()), // .tr() এভাবে ব্যবহার করতে হবে
            ),

            const SizedBox(height: 20),

            // বাংলা বাটনের জন্য
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('bn', 'BD'));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoleSelectionScreen(),
                  ),
                );
              },
              child: Text("বাংলা".tr()), // এখানেও .tr() দিতে হবে
            ),
          ],
        ),
      ),
    );
  }
}
