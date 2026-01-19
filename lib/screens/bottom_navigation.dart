// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:todo/screens/home_screen.dart';
//
// class BottomNavigation extends StatelessWidget {
//   const BottomNavigation({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         ()=> NavigationBar(
//           height: 60,
//           elevation: 0,
//           backgroundColor: Colors.white,
//           indicatorColor: Colors.blue,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) => controller.selectedIndex.value = index,
//           destinations: const [
//             NavigationDestination(icon: Icon(Icons.home), label: 'home',),
//             NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
//             NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
//             NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
//             NavigationDestination(icon: Icon(Icons.more_vert), label: 'More'),
//           ],
//         ),
//       ),
//       body: Obx(()=>controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }
//
// class NavigationController extends GetxController {
//   final RxInt selectedIndex = 0.obs;
//
//   final screens = [
//     HomeScreen(),
//     Container(color: Colors.amber),
//     Container(color: Colors.blue),
//     Container(color: Colors.green),
//     Container(color: Colors.red),
//   ];
// }
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/home_screen.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.green),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
          buttonBackgroundColor: Color(0xFFEEE9FF),
        backgroundColor: Colors.transparent,
          color: Color(0xFFEEE9FF),
          items: [
            Icon(Icons.home_rounded,size: 25, color: Color(0xFF5f33e1)),
            Icon(Icons.calendar_month_outlined,size: 25, color:Color(0xFF5f33e1)),
            Icon(Icons.add_circle_outline, size: 25,color:Color(0xFF5f33e1),),
            Icon(Icons.dashboard_outlined, size: 25,color:Color(0xFF5f33e1)),
            Icon(Icons.person_outline, size: 25,color:Color(0xFF5f33e1)),
            ]
      ),
      body: _pages[_currentIndex],
    );
  }
}
