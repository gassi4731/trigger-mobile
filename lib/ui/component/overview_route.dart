import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_overview_route.dart';
import 'package:trigger/ui/component/use_route_facilities.dart';
import 'package:trigger/ui/theme/font_size.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class OverviewRoute extends StatefulWidget {
  const OverviewRoute({Key? key, required this.route}) : super(key: key);

  final RecommendedOverviewRoute route;

  @override
  State<OverviewRoute> createState() => _OverviewRouteState();
}

class _OverviewRouteState extends State<OverviewRoute> {
  /// 破線単体の幅
  final double dashedWidth = 5;

  /// 破線の高さ
  final double dashedHeight = 0.5;

  /// 破線の色
  final Color color = Colors.black45;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: PaddingSize.ps15,
        left: PaddingSize.ps15,
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
                      const Text('出発まで'),
                      const SizedBox(height: 12),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '10',
                              style: TextStyle(
                                fontSize: FontSize.pt60,
                                fontWeight: FontWeight.w600,
                                height: 0.8,
                              ),
                            ),
                            TextSpan(
                              text: 'min',
                              style: TextStyle(
                                fontSize: FontSize.pt20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '出発時間: ${widget.route.getTimeLimit()}',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  // 経路上でなにをつかうか
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
                ],
              ),
            ),
            // 波線
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
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
    );
  }
}
