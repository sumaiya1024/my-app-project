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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryTeal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, size: 40, color: AppColors.primaryTeal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: avatarLeft ? 16.0 : 0,
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
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
