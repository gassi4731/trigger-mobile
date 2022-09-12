import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class SpotRoute extends StatefulWidget {
  const SpotRoute({
    Key? key,
    required this.detail,
    this.afterDetail,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  final RecommendedRouteDetail detail;
  final RecommendedRouteDetail? afterDetail;
  final bool isFirst;
  final bool isLast;

  @override
  State<SpotRoute> createState() => _SpotRouteState();
}

class _SpotRouteState extends State<SpotRoute> {
  String? beforeTime;
  String? afterTime;
  late String title;
  final timeTextStyle = const TextStyle(fontSize: FontSize.pt20);

  @override
  void initState() {
    super.initState();
    final outputFormat = DateFormat('HH:mm');
    beforeTime = outputFormat.format(widget.detail.leaveAt!);
    title = widget.detail.from;

    if (widget.isFirst) {
      // 最初のオブジェクトの場合
      beforeTime = outputFormat.format(widget.detail.leaveAt!);
      afterTime = null;
      title = widget.detail.from;
    } else if (widget.isLast) {
      // 最後のオブジェクトの場合
      beforeTime = outputFormat.format(widget.detail.arriveAt!);
      afterTime = null;
      title = widget.detail.to;
    } else {
      // 途中のオブジェクトの場合
      beforeTime = outputFormat.format(widget.detail.arriveAt!);
      afterTime = outputFormat.format(widget.afterDetail!.leaveAt!);
      title = widget.detail.to;
    }
  }

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
                beforeTime != null
                    ? Text(
                        beforeTime!,
                        style: timeTextStyle,
                      )
                    : const SizedBox(),
                afterTime != null
                    ? Text(
                        afterTime!,
                        style: timeTextStyle,
                      )
                    : const SizedBox()
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
