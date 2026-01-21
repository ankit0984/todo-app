import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/constants/size.dart';
import 'bottom_navigation.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  DateTime? startDate;
  DateTime? endDate;
  String selectedGroup = "Work";

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5f33e1),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
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
          'Add Project',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Amicons.iconly_notification_curved_fill, size: 26),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5f33e1),
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Task Group Dropdown
              _buildInputContainer(
                label: "Task Group",
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBF5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Amicons.lucide_briefcase_business, color: Color(0xFFFF5CB8), size: 20),
                    ),
                    SizedBox(width: 18),
                    DropdownButton<String>(
                      value: selectedGroup,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGroup = newValue!;
                        });
                      },
                      items: <String>['Work', 'Personal', 'Shopping', 'Health']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              // Project Name
              _buildInputContainer(
                label: "Project Name",
                child: TextField(
                  controller: projectNameController,
                  decoration: const InputDecoration(
                    hintText: "Enter Project Name",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              // Description
              _buildInputContainer(
                label: "Description",
                child: TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Enter Project Description",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              // Start Date
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: _buildInputContainer(
                  label: "Start Date",
                  child: Row(
                    children: [
                      const Icon(Amicons.iconly_calendar_curved_fill, color: Color(0xFF5f33e1), size: 24),
                      const SizedBox(width: 12),
                      Text(
                        startDate == null ? "Select Start Date" : DateFormat('dd MMM, yyyy').format(startDate!),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              // End Date
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: _buildInputContainer(
                  label: "End Date",
                  child: Row(
                    children: [
                      const Icon(Amicons.iconly_calendar_curved_fill, color: Color(0xFF5f33e1), size: 24),
                      const SizedBox(width: 12),
                      Text(
                        endDate == null ? "Select End Date" : DateFormat('dd MMM, yyyy').format(endDate!),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              // Logo Section (Example static)
              _buildInputContainer(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF007A7C),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text("Logo", style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Grocery", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF007A7C))),
                        Text("shop", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFF5CB8))),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFEEE9FF),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Change Logo", style: TextStyle(color: Color(0xFF5f33e1), fontSize: 12)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Add Project Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to create task
                    print("Project: ${projectNameController.text}");
                    print("Description: ${descriptionController.text}");
                    print("Start Date: $startDate");
                    print("End Date: $endDate");
                    print("Group: $selectedGroup");
                    
                    // Navigate back to home
                    if (Get.isRegistered<NavigationController>()) {
                      Get.find<NavigationController>().selectedIndex.value = 0;
                    } else {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5f33e1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    shadowColor: const Color(0xFF5f33e1).withValues(alpha: 0.4),
                  ),
                  child: const Text("Add Project", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              
              // Added responsive spacing to avoid overlap with bottom navigation bar
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputContainer({String? label, required Widget child}) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 8),
          ],
          child,
        ],
      ),
    );
  }
}
