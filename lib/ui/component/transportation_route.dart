import 'package:flutter/material.dart';
import 'package:kitakatu/model/recommended_route_next_action.dart';
import 'package:kitakatu/ui/theme/font_size.dart';
import 'package:kitakatu/ui/theme/padding_size.dart';

class TransportationRoute extends StatefulWidget {
  const TransportationRoute({Key? key, required this.nextAction})
      : super(key: key);

  final RecommendedRouteNextAction nextAction;

  @override
  State<TransportationRoute> createState() => _TransportationRouteState();
}

class _TransportationRouteState extends State<TransportationRoute> {
  late String title;
  late String description;
  late String price;

  @override
  void initState() {
    super.initState();

    switch (widget.nextAction.method) {
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
    title = widget.nextAction.train.line;
    description =
        '${widget.nextAction.train.direction} ${widget.nextAction.train.track}発';
    price = widget.nextAction.getPrice();
  }

  void walkRoute() {
    title = '徒歩${widget.nextAction.requiredMinute}分';
    description = '';
    price = '';
  }

  void taxiRoute() {
    title = 'タクシー';
    description =
        '所要時間:${widget.nextAction.requiredMinute}分 目安の費用:${widget.nextAction.getPrice()}';
    price = '';
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
          const SizedBox(width: 75),
          Expanded(
            child: Padding(
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
            ),
          ),
          price != '' ? Text(price) : const SizedBox(),
        ],
      ),
    );
  }
}
