import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class SpotRoute extends StatefulWidget {
  const SpotRoute({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final RecommendedRouteDetail detail;

  @override
  State<SpotRoute> createState() => _SpotRouteState();
}

class _SpotRouteState extends State<SpotRoute> {
  String? arriveTime;
  String? leaveTime;
  late String title;
  late String price;
  final timeTextStyle = const TextStyle(fontSize: FontSize.pt20);

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('ja_JP');
    final outputFormat = DateFormat('HH:mm');
    title = widget.detail.name;

    if (widget.detail.arriveAt != null) {
      arriveTime = outputFormat.format(widget.detail.arriveAt!);
    }

    if (widget.detail.leaveAt != null) {
      leaveTime = outputFormat.format(widget.detail.leaveAt!);
    }

    if (widget.detail.placeGenre == 'hotel') {
      price = widget.detail.getPrice();
    } else {
      price = '';
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
          arriveTime != null || leaveTime != null
              ? SizedBox(
                  width: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      arriveTime != null
                          ? Text(
                              arriveTime!,
                              style: timeTextStyle,
                            )
                          : const SizedBox(),
                      leaveTime != null
                          ? Text(
                              leaveTime!,
                              style: timeTextStyle,
                            )
                          : const SizedBox()
                    ],
                  ),
                )
              : const SizedBox(),
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
                  style: const TextStyle(
                    fontSize: FontSize.pt24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                price.isNotEmpty ? Text(price) : const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
