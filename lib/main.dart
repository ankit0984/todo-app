import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/auth/forget_password.dart';
import 'package:todo/screens/auth/login.dart';
import 'package:todo/screens/auth/signup.dart';
import 'package:todo/screens/auth/verify_email.dart';
import 'package:todo/screens/bottom_navigation.dart';
import 'package:todo/screens/splash.dart';
import 'package:todo/utils/helpers/storage_utility.dart';
import 'package:todo/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check for tokens to determine initial route
    final String? accessToken = TLocalStorage.readData('accessToken');
    final String initialRoute = accessToken != null ? "/home-navigation" : "/";

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/login", page: () => const LoginScreen()),
        GetPage(name: "/signup", page: () => const SignupScreen()),
        GetPage(name: "/verify_email", page: () => const VerifyEmailScreen()),
        GetPage(name: "/home-navigation", page: () => const BottomNavigation()),
        GetPage(name: "/forget_password", page: () => const ForgetPasswordScreen()),
      ],
    );
  }
}
