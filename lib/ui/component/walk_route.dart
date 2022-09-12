import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/theme/padding_size.dart';

import '../theme/font_size.dart';

class WalkRoute extends StatefulWidget {
  const WalkRoute({Key? key, required this.detail}) : super(key: key);

  final RecommendedRouteDetail detail;

  @override
  State<WalkRoute> createState() => _WalkRouteState();
}

class _WalkRouteState extends State<WalkRoute> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = '徒歩${widget.detail.requiredMinute}分';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: PaddingSize.ps15,
        right: PaddingSize.ps15,
      ),
      child: Row(
        children: [
          const SizedBox(width: 70),
          Padding(
            padding: const EdgeInsets.only(
              top: PaddingSize.ps15,
              bottom: PaddingSize.ps15,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: FontSize.pt18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
