import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class TrainRoute extends StatefulWidget {
  const TrainRoute({Key? key, required this.detail}) : super(key: key);

  final RecommendedRouteDetail detail;

  @override
  State<TrainRoute> createState() => _TrainRouteState();
}

class _TrainRouteState extends State<TrainRoute> {
  late String line;
  late String description;

  @override
  void initState() {
    super.initState();

    line = widget.detail.train.line;
    description =
        '${widget.detail.train.direction} ${widget.detail.train.track}番線発';
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
                  line,
                  style: const TextStyle(fontSize: FontSize.pt18),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: FontSize.pt12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
