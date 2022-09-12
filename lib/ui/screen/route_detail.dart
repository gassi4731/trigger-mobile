import 'package:flutter/material.dart';
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/component/hotel_route.dart';
import 'package:trigger/ui/component/spot_route.dart';
import 'package:trigger/ui/component/transportation_route.dart';

class RouteDetail extends StatefulWidget {
  const RouteDetail({Key? key}) : super(key: key);
  // const RouteDetail({Key? key, required this.detail}) : super(key: key);

  // final RecommendedRouteDetail detail;

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  final details = <RecommendedRouteDetail>[];
  final detailsComponents = <Widget>[];

  @override
  void initState() {
    super.initState();
    fetchMockDetail();
  }

  Future<void> fetchMockDetail() async {
    details.addAll(await mockRecommendedRouteDetails());
    setState(createRouteComponent);
  }

  void createRouteComponent() {
    if (details.length == 1) {
      detailsComponents
        ..add(SpotRoute(detail: details[0], isFirst: true))
        ..add(selectRouteWidget(details[0]))
        ..add(SpotRoute(detail: details[0], isLast: true));
    } else {
      details.asMap().forEach((i, detail) {
        if (i == 0) {
          // 最初の場合
          detailsComponents
            ..add(SpotRoute(detail: detail, isFirst: true))
            ..add(selectRouteWidget(detail))
            ..add(SpotRoute(detail: detail, afterDetail: details[i + 1]));
        } else if (i == details.length - 1) {
          // 最後の場合
          detailsComponents
            ..add(selectRouteWidget(detail))
            ..add(SpotRoute(detail: detail, isLast: true));
        } else {
          // それ以外の場合
          detailsComponents
            ..add(selectRouteWidget(detail))
            ..add(
              SpotRoute(
                detail: detail,
                afterDetail: details[i + 1],
              ),
            );
        }
      });
    }
  }

  Widget selectRouteWidget(RecommendedRouteDetail detail) {
    late Widget widget;

    switch (detail.method) {
      case 'walk':
      case 'train':
      case 'taxi':
        widget = TransportationRoute(detail: detail);
        break;
      case 'hotel':
        widget = const HotelRoute();
        break;
      default:
        widget = Container();
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ルートの詳細')),
      body: SingleChildScrollView(
        child: Column(
          children: detailsComponents,
        ),
      ),
    );
  }
}
