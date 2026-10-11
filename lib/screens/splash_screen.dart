import 'package:flutter/material.dart';

// যেহেতু এটি screens ফোল্ডারে আছে, তাই ../lang.dart দিয়ে বাইরে বের হতে হবে
import '../lang.dart';
import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // প্রফেশনাল স্মুথ অ্যানিমেশনের জন্য কন্ট্রোলার সেটআপ
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // ২ সেকেন্ড পর অটোমেটিক ল্যাঙ্গুয়েজ সিলেকশন স্ক্রিনে রিডাইরেক্ট হবে
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LanguageSelectionScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // ব্যাকগ্রাউন্ড ডেকোরেশন সার্কেল
          Center(
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightTeal.withValues(alpha: 0.1),
              ),
            ),
          ),
          // মেইন লোগো ও টেক্সট সেকশন (অ্যানিমেশনসহ)
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      size: 60,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kinvera',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryTeal,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Connect, Care, Comfort',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 35),
                  // প্রফেশনাল লোডিং স্পিনার
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryTeal,
                      strokeWidth: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // অ্যাপ ভার্সন ফুটার
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'v2.6.2.256',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
