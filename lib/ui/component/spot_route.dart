import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class SpotRoute extends StatefulWidget {
  const SpotRoute({Key? key, this.beforeDetail, this.afterDetail})
      : super(key: key);

  final RecommendedRouteDetail? beforeDetail;
  final RecommendedRouteDetail? afterDetail;

  @override
  State<SpotRoute> createState() => _SpotRouteState();
}

class _SpotRouteState extends State<SpotRoute> {
  final beforeTime = '12:00';
  final afterTime = '12:10';
  final title = '渋谷駅';
  final timeTextStyle = const TextStyle(fontSize: FontSize.pt20);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: PaddingSize.ps15,
        right: PaddingSize.ps15,
      ),
      color: Colors.grey[200],
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beforeTime,
                  style: timeTextStyle,
                ),
                Text(
                  afterTime,
                  style: timeTextStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: PaddingSize.ps15,
              bottom: PaddingSize.ps15,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: FontSize.pt24,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
