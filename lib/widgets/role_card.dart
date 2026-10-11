import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants.dart'; // AppColors ব্যবহারের জন্য

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool avatarLeft;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.avatarLeft,
  });

  @override
  Widget build(BuildContext context) {
    // লেআউট ডানে বা বামે সাজানোর জন্য চাইল্ড লিস্ট তৈরি
    List<Widget> rowChildren = [
      // গোল আইকন বা অবতার সেকশন
      Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(icon, size: 36, color: AppColors.primaryTeal),
      ),
      const SizedBox(width: 16),
      // টেক্সট সেকশন
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            right: avatarLeft ? 16.0 : 8.0,
            left: avatarLeft ? 0 : 16.0,
            top: 12,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: avatarLeft
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Text(
                title.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle.tr(),
                textAlign: avatarLeft ? TextAlign.left : TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.lightTeal.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              // avatarLeft ফলস হলে রো-এর চাইল্ডগুলোর অর্ডার উল্টে যাবে (প্রফেশনাল লেআউটের জন্য)
              children: avatarLeft
                  ? rowChildren
                  : rowChildren.reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }
}
