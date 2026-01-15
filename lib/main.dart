import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/auth/login.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      // home: SplashScreen(),
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/home", page: () => const LoginScreen()),
      ],
    );
  }
}