import 'package:flutter/material.dart';
import 'package:todo/utils/constants/colors.dart';
import 'login/clip.dart';
import 'login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPaths(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
