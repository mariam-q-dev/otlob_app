import 'package:flutter/material.dart';
import 'package:otlob_app/core/utils/app_colors.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color:AppColors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Limited offer",
              style: TextStyle(color: AppColors.background, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Free delivery on\nyour first order",
            style: TextStyle(color:AppColors.background, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Use code BITE10 at checkout",
            style: TextStyle(color: AppColors.background, fontSize: 12),
          ),
        ],
      ),
    );
  }
}