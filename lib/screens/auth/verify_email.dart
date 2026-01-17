import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/utils/constants/colors.dart';
import 'package:todo/utils/constants/image_string.dart';
import 'package:todo/utils/constants/size.dart';
import 'package:todo/utils/constants/text_string.dart';
import 'package:todo/utils/device_utility/device_utility.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: TColors.white,
          statusBarIconBrightness: Brightness.dark, // For Android
          statusBarBrightness: Brightness.light, // For iOS
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
            child: IconButton(
              onPressed: () => Get.offAllNamed('/login'),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Lottie Animation
              Lottie.asset(
                AppAssets.verifyEmail,
                width: TDeviceUtils.getScreenWidth(context) * 0.6,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// -- Title & Sub-Title
              Text(
                AppTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                "support@todoapp.com", // Example email
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                "Your productivity journey is about to begin. Please verify your email address to start creating tasks and managing your day effectively.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// -- Buttons
              GestureDetector(
                onTap: () {}, // Handle Continue
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
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
                  child: const Center(
                    child: Text(
                      AppTexts.tContinue,
                      style: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    AppTexts.resendEmail,
                    style: TextStyle(color: TColors.dark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
