import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class TransportationRoute extends StatefulWidget {
  const TransportationRoute({Key? key, required this.detail}) : super(key: key);

  final RecommendedRouteDetail detail;

  @override
  State<TransportationRoute> createState() => _TransportationRouteState();
}

class _TransportationRouteState extends State<TransportationRoute> {
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    switch (widget.detail.method) {
      case 'train':
        trainRoute();
        break;
      case 'walk':
        walkRoute();
        break;
      case 'taxi':
        taxiRoute();
        break;
      default:
    }
  }

  void trainRoute() {
    title = widget.detail.train.line;
    description =
        '${widget.detail.train.direction} ${widget.detail.train.track}番線発';
  }

  void walkRoute() {
    title = '徒歩${widget.detail.requiredMinute}分';
    description = '';
  }

  void taxiRoute() {
    title = 'タクシー';
    description =
        '所要時間:${widget.detail.requiredMinute}分 目安の費用:¥${widget.detail.price}';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: FontSize.pt18),
                ),
                description != ''
                    ? Text(
                        description,
                        style: const TextStyle(fontSize: FontSize.pt12),
                      )
                    : const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
