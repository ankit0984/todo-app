import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:todo/common/styles/spacing.dart';
import 'package:todo/utils/constants/size.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image with height of 150 logo
                  Text(
                    'Welcome Back,',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: AppSizes.sm),
                  Text(
                    'Make it work, make it right, make it fast.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
                  child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(prefixIcon: Icon(LucideIcons.mail), labelText: 'email'),
                    ),
                    SizedBox(height: AppSizes.spaceBtwInputFields,),
                    TextFormField(
                      decoration: InputDecoration(prefixIcon: Icon(Iconsax.password_check), labelText: 'password', suffixIcon: Icon(Iconsax.eye_slash)),
                    ),
                    SizedBox(height: AppSizes.spaceBtwInputFields/2,),

                    // remember me / forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            Text('Remember me'),
                          ],
                        ),
                        TextButton(onPressed: () {}, child: Text('Forgot Password?'))
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems,),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){}, child: Text('Login'))
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(onPressed: (){}, child: Text('Create Account'))
                    ),


                  ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(color: Colors.grey,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
