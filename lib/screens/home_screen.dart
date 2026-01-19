import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/utils/constants/size.dart';

import '../utils/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: TColors.white,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: TColors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title: Row(
            children: [
              // Avatar
              AvatarPlus(
                "jonny",
                height: 40,
                width: 40,
              ),

              const SizedBox(width: 12),

              // Username
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello 👋",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    "Jonny",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Notification icon
              IconButton(
                onPressed: () {
                  // TODO: navigate to notifications
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spaceBtwItems * 3),
                // card for today's task
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                    color: const Color(0xFF5f33e1),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Your today’s task almost done!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF5f33e1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text("View Task"),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // RIGHT SIDE (Progress)
                      CircularStepProgressIndicator(
                        totalSteps: 100,
                        currentStep: 80,
                        stepSize: 8,
                        selectedColor: Colors.white,
                        unselectedColor: Colors.white24,
                        padding: 0,
                        width: 80,
                        height: 80,
                        selectedStepSize: 10,
                        child: const Center(
                            child: Text(
                          "80%",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        roundedCap: (_, __) => true,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSizes.spaceBtwSections),
                
                // Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See All", style: TextStyle(color: TColors.primary)),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSizes.spaceBtwItems),

                // HORIZONTAL SCROLLABLE ROW
                SizedBox(
                  height: 160, // Fixed height for the horizontal list
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 280, // Fixed width for each card
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: TColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                          border: Border.all(color: TColors.primary.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Project Management",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(Icons.more_horiz, size: 16),
                                )
                              ],
                            ),
                            const Text(
                              "Mobile App Development",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  "July 20, 2023",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const StepProgressIndicator(
                              totalSteps: 100,
                              currentStep: 60,
                              size: 6,
                              padding: 0,
                              selectedColor: TColors.primary,
                              unselectedColor: Colors.white,
                              roundedEdges: Radius.circular(10),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: AppSizes.spaceBtwSections),
                
                // Another section or bottom space
                const Text(
                  "Recent Tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                // Placeholder for recent tasks
                ...List.generate(6, (index) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: ListTile(
                    leading: Container(

                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Iconsax.briefcase, color: Color(0xFFF478B8)),
                    ),
                    title: const Text("Office Project"),
                    subtitle: const Text("23 Tasks", style: TextStyle(fontSize: 12,),),
                    trailing:                       CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 80,
                      stepSize: 8,
                      selectedColor: Color(0xFFF478B8),
                      unselectedColor: Colors.white24,
                      padding: 0,
                      width: 45,
                      height: 45,
                      selectedStepSize: 5,
                      child: const Center(
                          child: Text(
                            "70%",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          )),
                      roundedCap: (_, __) => true,
                    ),

                  ),
                )),
              ],
            ),
          ),
        )
    );
  }
}
