import 'package:flutter/material.dart';

class UseRouteFacilities extends StatelessWidget {
  const UseRouteFacilities({Key? key, required this.icon, required this.isUse})
      : super(key: key);
  final IconData icon;
  final bool isUse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40),
        Text(
          isUse ? '○' : '×',
          style: const TextStyle(fontSize: 25),
        )
      ],
    );
  }
}
