import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/bottom_navigation.dart';
import 'package:todo/utils/helpers/storage_utility.dart';
import '../../../utils/constants/size.dart';
import '../../../utils/constants/text_string.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  
  bool isLoading = false;
  bool hidePassword = true;

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final dio = Dio();
      
      // Add interceptor to debug login response
      dio.interceptors.add(InterceptorsWrapper(
        onResponse: (response, handler) {
          print("LOGIN RESPONSE HEADERS: ${response.headers}");
          print("LOGIN RESPONSE DATA: ${response.data}");
          return handler.next(response);
        },
      ));

      final response = await dio.post(
        'https://authentication-liart-kappa.vercel.app/api/auth/login',
        data: {
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseBody = response.data;
        
        String accessToken = '';
        String refreshToken = '';

        // Safely extract tokens from body if present
        if (responseBody is Map) {
          final dataField = responseBody['data'];
          if (dataField is Map) {
            accessToken = dataField['accessToken']?.toString() ?? '';
            refreshToken = dataField['refreshToken']?.toString() ?? '';
          }
          
          // Check top level too
          if (accessToken.isEmpty) accessToken = responseBody['accessToken']?.toString() ?? '';
          if (refreshToken.isEmpty) refreshToken = responseBody['refreshToken']?.toString() ?? '';
        }

        // Extract from Set-Cookie headers (Common for this specific API)
        final List<String>? cookies = response.headers['set-cookie'];
        if (cookies != null) {
          for (var cookie in cookies) {
            if (cookie.contains('accessToken=')) {
              final parts = cookie.split('accessToken=');
              if (parts.length > 1) {
                accessToken = parts[1].split(';')[0];
              }
            }
            if (cookie.contains('refreshToken=')) {
              final parts = cookie.split('refreshToken=');
              if (parts.length > 1) {
                refreshToken = parts[1].split(';')[0];
              }
            }
          }
        }

        print("FINAL EXTRACTED ACCESS TOKEN: $accessToken");

        if (accessToken.isNotEmpty) {
          await TLocalStorage.saveData('accessToken', accessToken);
          await TLocalStorage.saveData('refreshToken', refreshToken);
          Get.offAll(() => const BottomNavigation());
        } else {
          Get.snackbar('Login Error', 'Authentication successful but tokens not found.');
        }
      }
    } catch (e) {
      print("Login Error Exception: $e");
      String errorMessage = "Something went wrong";
      
      if (e is DioException) {
        final errorData = e.response?.data;
        if (errorData is Map) {
          errorMessage = errorData['message']?.toString() ?? errorMessage;
        } else if (errorData is String) {
          errorMessage = errorData;
        }
      } else {
        errorMessage = e.toString();
      }

      Get.snackbar(
        'Login Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          children: [
            // Username
            TextFormField(
              controller: usernameController,
              validator: (value) => value!.isEmpty ? 'Username is required' : null,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: "Username",
                contentPadding: EdgeInsets.all(AppSizes.md),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              controller: passwordController,
              validator: (value) => value!.isEmpty ? 'Password is required' : null,
              obscureText: hidePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: AppTexts.password,
                contentPadding: const EdgeInsets.all(AppSizes.md),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                  icon: Icon(hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

            // Forget Password & Remember Me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(value: true, onChanged: (value) {}),
                    ),
                    const Text(AppTexts.tRememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/forget_password'),
                  child: const Text(AppTexts.tForgetPassword),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: isLoading 
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text(AppTexts.tLogin, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
