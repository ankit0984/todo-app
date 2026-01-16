import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/size.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Lottie.asset('')
            ]
          )
        ),
      ),
    );
  }
}
