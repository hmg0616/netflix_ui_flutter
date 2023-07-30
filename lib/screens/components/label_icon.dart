import 'package:flutter/material.dart';

/*
 아이콘과 그 밑에 텍스트가 존재하는 위젯
 */
class LabelIcon extends StatelessWidget {

  final IconData icon;
  final String label;
  final TextStyle? style;

  const LabelIcon({super.key, required this.icon, required this.label, this.style});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: 5.0),
          Text(
            label,
            style: style ?? TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
