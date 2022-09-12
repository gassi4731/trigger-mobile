import 'package:flutter/material.dart';
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/component/spot_route.dart';
import 'package:trigger/ui/component/train_route.dart';
import 'package:trigger/ui/component/walk_route.dart';

class RouteDetail extends StatefulWidget {
  const RouteDetail({Key? key}) : super(key: key);
  // const RouteDetail({Key? key, required this.detail}) : super(key: key);

  // final RecommendedRouteDetail detail;

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  final details = <RecommendedRouteDetail>[];

  @override
  void initState() {
    super.initState();
    fetchMockDetail();
  }

  Future<void> fetchMockDetail() async {
    details.addAll(await mockRecommendedRouteDetails());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ルートの詳細')),
      body: SingleChildScrollView(
        child: Column(
          children: details.isNotEmpty
              ? [
                  SpotRoute(
                    detail: details[0],
                    isFirst: true,
                  ),
                  WalkRoute(detail: details[0]),
                  SpotRoute(
                    detail: details[0],
                    afterDetail: details[1],
                  ),
                  TrainRoute(detail: details[1])
                ]
              : [],
        ),
      ),
    );
  }
}
