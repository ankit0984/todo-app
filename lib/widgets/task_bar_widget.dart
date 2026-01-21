import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/size.dart';

class TaskFilterBar extends StatefulWidget {
  final ValueChanged<String>? onFilterChanged;

  const TaskFilterBar({super.key, this.onFilterChanged});

  @override
  State<TaskFilterBar> createState() => _TaskFilterBarState();
}

class _TaskFilterBarState extends State<TaskFilterBar> {
  int selectedIndex = 0;

  final List<String> filters = [
    'All',
    'Todo',
    'In Progress',
    'Complete',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSizes.spaceBtwItems),
        itemBuilder: (context, index) {
          final bool isSelected = selectedIndex == index;

          return OutlinedButton(
            onPressed: () {
              setState(() => selectedIndex = index);
              widget.onFilterChanged?.call(filters[index]);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? TColors.primaryLight : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              side: BorderSide(
                color: isSelected ? TColors.primaryLight : Colors.grey.shade300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              filters[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
