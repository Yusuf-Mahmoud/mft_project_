import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardContainer extends StatelessWidget {
  final String number;
  final IconData icon;
  final String label;
  const DashBoardContainer({
    super.key,
    required this.number,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: 70.w,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(number, style: Theme.of(context).textTheme.displayLarge),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 25,
                    )),
              ],
            ),
            Row(
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            )
          ],
        ));
  }
}
