import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/create_todo.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/todo_list.dart';
import 'package:todo/screens/user_profile.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          index: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex.value = index,
          buttonBackgroundColor: const Color(0xFFEEE9FF),
          backgroundColor: Colors.white,
          color: const Color(0xFFEEE9FF),
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(Icons.home_rounded, size: 25, color: Color(0xFF5f33e1)),
            Icon(Icons.calendar_month_outlined, size: 25, color: Color(0xFF5f33e1)),
            Icon(Icons.add_circle_outline, size: 25, color: Color(0xFF5f33e1)),
            // Icon(Icons.dashboard_outlined, size: 25, color: Color(0xFF5f33e1)),
            Icon(Icons.person_outline, size: 25, color: Color(0xFF5f33e1)),
          ],
        ),
      ),
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  
  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    const HomeScreen(),
    const TodoListScreen(),
    const CreateTodoScreen(),
    const UserProfileScreen(),
    Container(color: Colors.orange),
  ];
}
