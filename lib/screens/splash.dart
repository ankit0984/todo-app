import 'package:flutter/material.dart';
import 'package:todo/utils/constants/colors.dart';
import 'package:todo/utils/constants/image_string.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: Center(
        child: Column(
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.69,
              image: const AssetImage(AppAssets.splashScreen),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text(
                'Task Management & To-Do List',
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                'This productive tool is designed to help you better manage your task project-wise conveniently!',
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: GestureDetector(
                onTap: () => Get.offNamed('/login'), // Use offNamed to prevent going back to splash
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [TColors.primary, Color(0xFFFFB800)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: TColors.primary.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          color: TColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, color: TColors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
