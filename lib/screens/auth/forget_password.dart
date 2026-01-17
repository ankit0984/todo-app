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
                alignment: .center,
                child: Lottie.asset(AppAssets.forgetPassword,
                  width: TDeviceUtils.getScreenHeight() * 0.2,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections/2),
              Text(
                AppTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                "Your productivity journey is about to begin. Please verify your email address to start creating tasks and managing your day effectively.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your registered email'
                ),
              )



            ]
          )
        ),
      ),
    );
  }
}
