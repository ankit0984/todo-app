import 'package:amicons/amicons.dart';
import 'package:avatar_plus/avatar_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/bottom_navigation.dart';
import 'package:todo/utils/helpers/storage_utility.dart';
import '../utils/constants/size.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isLoading = false;
  bool isFetching = true;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final dio = Dio();
      final accessToken = TLocalStorage.readData('accessToken');

      // Add interceptor to log request/response for debugging
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print("REQUEST[${options.method}] => PATH: ${options.path}");
          print("HEADERS: ${options.headers}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
          return handler.next(e);
        },
      ));

      final response = await dio.get(
        'https://authentication-liart-kappa.vercel.app/api/user/details',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          setState(() {
            user = UserModel.fromJson(responseData['data']);
          });
        } else {
          print("API error: ${responseData['message']}");
        }
      }
    } catch (e) {
      print("Fetch Error: $e");
      Get.snackbar('Error', 'Failed to load user details');
    } finally {
      if (mounted) {
        setState(() => isFetching = false);
      }
    }
  }

  Future<void> logout() async {
    setState(() => isLoading = true);

    try {
      final dio = Dio();
      final refreshToken = TLocalStorage.readData('refreshToken');

      final response = await dio.post(
        'https://authentication-liart-kappa.vercel.app/api/auth/logout',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await TLocalStorage.clearAll();
        Get.offAllNamed("/");
      }
    } catch (e) {
      await TLocalStorage.clearAll();
      Get.offAllNamed("/");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Get.isRegistered<NavigationController>()) {
              Get.find<NavigationController>().selectedIndex.value = 0;
            } else {
              Get.offAll(() => const BottomNavigation());
            }
          },
          icon: const Icon(Amicons.iconly_arrow_left_2_sharp_fill, color: Colors.black, size: 20),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Amicons.lucide_settings, size: 24),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: isFetching
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF5f33e1)))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    
                    // Avatar
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF5f33e1), width: 2),
                            ),
                            child: AvatarPlus(
                              user?.username ?? "user",
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF5f33e1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    
                    // User Information
                    _buildProfileField(
                      label: "Username",
                      value: user?.username ?? "N/A",
                      icon: Amicons.iconly_profile_curved_fill,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),
                    
                    _buildProfileField(
                      label: "Full Name",
                      value: user?.fullName ?? "N/A",
                      icon: Amicons.iconly_profile_curved_fill,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),
                    
                    _buildProfileField(
                      label: "Email",
                      value: user?.email ?? "N/A",
                      icon: Amicons.iconly_message_curved_fill,
                    ),
                    
                    const SizedBox(height: AppSizes.spaceBtwSections * 2),
                    
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: isLoading ? null : logout,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: isLoading 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2))
                          : const Text(
                              "Logout",
                              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileField({required String label, required String value, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEE9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF5f33e1), size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
