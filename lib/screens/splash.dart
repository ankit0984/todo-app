import 'package:flutter/material.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/utils/constants/image_string.dart';
import 'package:todo/utils/constants/size.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: .center,
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.69,
              image: const AssetImage(AppAssets.splashScreen),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                'Task Management & To-Do List',
                style: const TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 24,
                  fontWeight: FontWeight.w600, // Bold
                ),
                textAlign: .center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'This productive tool is designed to help you better manage your task project-wise conveniently!',
                style: const TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: .center,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/home'),
                // {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const HomeScreen()),
                //   );
                // },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // set radius
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Text(
                      'Get Started',
                      style: const TextStyle(
                        fontFamily: 'Poppins', // your font name
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
