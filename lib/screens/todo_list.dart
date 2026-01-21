import 'dart:math';
import 'package:amicons/amicons.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/bottom_navigation.dart';
import 'package:todo/widgets/horizontal_calender.dart';
import 'package:todo/widgets/task_bar_widget.dart';
import '../utils/constants/size.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, dynamic>> _statusOptions = [
    {'label': 'Todo', 'color': Colors.orange},
    {'label': 'In Progress', 'color': const Color(0xFFAB94FF)},
    {'label': 'Done', 'color': Colors.green},
  ];

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
          'Today’s Tasks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Amicons.iconly_notification_curved_fill, size: 26),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.defaultSpace),
          const HorizontalCalender(),
          const SizedBox(height: AppSizes.defaultSpace),
          TaskFilterBar(
            onFilterChanged: (filter) {
              print('Selected Filter: $filter');
            },
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
                    child: Text(
                      "Tasks",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        // Logic for random status
                        final status = _statusOptions[Random().nextInt(_statusOptions.length)];
                        
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                            side: BorderSide(color: Colors.grey.shade100),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.md),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        'Grocery shopping app design ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Market Research ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Amicons.iconly_time_circle_fill, size: 14, color: Color(0xFFAB94FF)),
                                          const SizedBox(width: 4),
                                          const Text(
                                            '10:00 AM - 11:00 AM',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: (status['color'] as Color).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Amicons.lucide_briefcase_business, 
                                        size: 18, 
                                        color: status['color'] as Color,
                                      ),
                                    ),
                                    const SizedBox(height: AppSizes.md),
                                    badges.Badge(
                                      badgeContent: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        child: Text(
                                          status['label'], 
                                          style: const TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        badgeColor: status['color'] as Color,
                                        shape: badges.BadgeShape.square,
                                        borderRadius: BorderRadius.circular(8),
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.defaultSpace),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
