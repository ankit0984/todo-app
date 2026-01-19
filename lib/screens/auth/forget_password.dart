import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/utils/constants/image_string.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/size.dart';
import '../../utils/constants/text_string.dart';
import '../../utils/device_utility/device_utility.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              Align(
                alignment: Alignment.center,
                child: Lottie.asset(
                  AppAssets.forgetPassword,
                  width: TDeviceUtils.getScreenHeight() * 0.2,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections / 2),
              Text(
                AppTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: AppTexts.email,
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              GestureDetector(
                onTap: () => Get.toNamed('/reset-password'), // Handle Continue
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
                      AppTexts.submit,
                      style: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
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
