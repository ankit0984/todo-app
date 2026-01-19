import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/size.dart';
import '../../../utils/constants/text_string.dart';
import '../../bottom_navigation.dart';




class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title & Sub-Title
          Text(
            AppTexts.tLoginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            AppTexts.tLoginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          /// Form
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
              child: Column(
                children: [
                  /// Email
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(LucideIcons.mailbox),
                      labelText: AppTexts.tEmail,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),

                  /// Password
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: AppTexts.tPassword,
                      suffixIcon: Icon(Iconsax.eye_slash),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

                  /// Remember Me & Forget Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Forget Password
                      TextButton(
                        onPressed: ()=>Get.toNamed('/forget_password'),
                        child: const Text(
                          AppTexts.tForgetPassword,
                          style: TextStyle(color: TColors.dark),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  /// Sign In Button with Gradient
                  GestureDetector(
                    onTap: () => Get.to(()=> BottomNavigation()),
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
                          AppTexts.tLogin,
                          style: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Create Account Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: ()=> Get.toNamed('/signup'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: TColors.grey),
                      ),
                      child: const Text(AppTexts.tSignup),
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
