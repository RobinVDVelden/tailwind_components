import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({this.backgroundColor, required this.stripeColor, required this.title, required this.subtitle, this.action, Key? key, this.elevation,}) : super(key: key);

  final Color? backgroundColor;
  final Color stripeColor;
  final String title;
  final String subtitle;
  final Widget? action;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: elevation ?? 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: stripeColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                        const SizedBox(height: 5),
                        Text(subtitle, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ],
              ),

              action ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}