import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route.dart';
import 'package:trigger/ui/component/use_route_facilities.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class OverviewRoute extends StatefulWidget {
  const OverviewRoute({Key? key, required this.route}) : super(key: key);

  final RecommendedRoute route;

  @override
  State<OverviewRoute> createState() => _OverviewRouteState();
}

class _OverviewRouteState extends State<OverviewRoute> {
  late Timer timer;

  bool isShowRoute = true;

  late String subtitle;
  String timeLeft = ''; // 残り時間
  String unit = ''; // 残り時間の単位
  late Color textColor; // 残り時間の表示色
  bool isShowDepartureTime = true;

  final double dashedWidth = 5; // 破線単体の幅
  final double dashedHeight = 0.5; // 破線の高さ
  final Color color = Colors.black45; // 破線の色

  @override
  void initState() {
    super.initState();

    updateTimeLeft();
    updateRouteStatus();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void startTimer() {
    const oneMin = Duration(seconds: 1);

    if (mounted) {
      timer = Timer.periodic(oneMin, (timer) {
        updateRouteStatus();
        updateTimeLeft();
      });
    }
  }

  void updateTimeLeft() {
    if (widget.route.isEnableTimeLimit) {
      final now = DateTime.now();
      final diff = widget.route.timeLimit!.difference(now);

      setState(() {
        if (diff.inHours > 0) {
          timeLeft = diff.inHours.toString().padLeft(2, '0');
          if (diff.inHours == 1) {
            unit = 'hr.';
          } else {
            unit = 'hrs.';
          }
        } else if (diff.inMinutes > 0) {
          timeLeft = diff.inMinutes.toString().padLeft(2, '0');
          unit = 'min.';
        }

        isShowDepartureTime = true;
      });
    } else {
      setState(() {
        timeLeft = '∞';
        unit = 'min.';
        isShowDepartureTime = false;
      });
    }
  }

  void updateRouteStatus() {
    if (widget.route.isEnableTimeLimit) {
      final now = DateTime.now();
      final diff = widget.route.timeLimit!.difference(now);
      if (diff.inMilliseconds < 0) {
        isShowRoute = false;
      } else if (diff.inMinutes <= 5) {
        isShowRoute = true;
        textColor = Colors.red;
      } else if (diff.inMinutes <= 30) {
        isShowRoute = true;
        textColor = Colors.blue;
      } else {
        textColor = Colors.black;
      }
      subtitle = '出発まで';
    } else {
      subtitle = '終電なし';
      textColor = Colors.black;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isShowRoute
        ? Padding(
            padding: const EdgeInsets.only(
              right: PaddingSize.ps15,
              left: PaddingSize.ps15,
              top: PaddingSize.ps15,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 9,
                    offset: Offset(3, 6),
                  )
                ],
              ),
              child: Column(
                children: [
                  // 帰宅情報
                  Padding(
                    padding: const EdgeInsets.all(PaddingSize.ps15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 出発まで〇〇分
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subtitle),
                            const SizedBox(height: 12),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: timeLeft,
                                    style: TextStyle(
                                      fontSize: FontSize.pt60,
                                      fontWeight: FontWeight.w600,
                                      height: 0.8,
                                      color: textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: unit,
                                    style: TextStyle(
                                      fontSize: FontSize.pt20,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isShowDepartureTime
                                ? Text(
                                    '出発時間: ${widget.route.getTimeLimit()}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        // 経路上でなにをつかうか
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UseRouteFacilities(
                                  icon: Icons.train_outlined,
                                  isUse: widget.route.isUseTrain,
                                ),
                                const SizedBox(width: PaddingSize.ps15),
                                UseRouteFacilities(
                                  icon: Icons.local_taxi_outlined,
                                  isUse: widget.route.isUseTaxi,
                                ),
                                const SizedBox(width: PaddingSize.ps15),
                                UseRouteFacilities(
                                  icon: Icons.hotel_outlined,
                                  isUse: widget.route.isUseHotel,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(widget.route.description),
                          ],
                        )
                      ],
                    ),
                  ),
                  // 波線
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final dashedCount =
                          (constraints.maxWidth / (2 * dashedWidth)).floor();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(dashedCount, (_) {
                          return Container(
                            width: dashedWidth,
                            height: dashedHeight,
                            color: color,
                          );
                        }),
                      );
                    },
                  ),
                  // 料金
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: PaddingSize.ps15),
                        child: const Text('料金'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: PaddingSize.ps15,
                          top: PaddingSize.ps15,
                          bottom: PaddingSize.ps15,
                        ),
                        child: Text(
                          widget.route.getAmount(),
                          style: const TextStyle(fontSize: FontSize.pt20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
