import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//
// class HorizontalCalendar extends StatefulWidget {
//   final DateTime initialDate;
//   final ValueChanged<DateTime>? onDateSelected;
//
//   const HorizontalCalendar({
//     super.key,
//     required this.initialDate,
//     this.onDateSelected,
//   });
//
//   @override
//   State<HorizontalCalendar> createState() => _HorizontalCalendarState();
// }
//
// class _HorizontalCalendarState extends State<HorizontalCalendar> {
//   late DateTime selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDate = widget.initialDate;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 30,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         itemBuilder: (context, index) {
//           DateTime date = DateTime.now().add(Duration(days: index - 3));
//
//           bool isSelected =
//               date.year == selectedDate.year &&
//                   date.month == selectedDate.month &&
//                   date.day == selectedDate.day;
//
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedDate = date;
//               });
//
//               widget.onDateSelected?.call(date);
//             },
//             child: Container(
//               width: 70,
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xFF5f33e1) : Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 border: isSelected
//                     ? null
//                     : Border.all(color: Colors.grey.shade200),
//                 boxShadow: [
//                   if (!isSelected)
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                     ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     DateFormat('MMM').format(date),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white70 : Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     date.day.toString(),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     DateFormat('E').format(date),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white70 : Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


class HorizontalCalender extends StatefulWidget {
  const HorizontalCalender({super.key});

  @override
  State<HorizontalCalender> createState() => _HorizontalCalenderState();
}

class _HorizontalCalenderState extends State<HorizontalCalender> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30, // Show 30 days
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index - 3)); // Show 3 days before today
          bool isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF5f33e1) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                ],
                border: isSelected
                    ? null
                    : Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
