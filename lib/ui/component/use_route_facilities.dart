import 'package:flutter/material.dart';

class UseRouteFacilities extends StatelessWidget {
  const UseRouteFacilities({Key? key, required this.icon, required this.isUse})
      : super(key: key);
  final IconData icon;
  final bool isUse;

  @override
  Widget build(BuildContext context) {
    final color = isUse ? Colors.black87 : Colors.black26;

    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),
        Text(
          isUse ? '○' : '×',
          style: TextStyle(
            fontSize: 25,
            color: color,
          ),
        )
      ],
    );
  }
}
