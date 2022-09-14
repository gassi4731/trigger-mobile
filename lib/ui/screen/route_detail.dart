import 'package:flutter/material.dart';
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/model/recommended_route.dart';
import 'package:trigger/model/recommended_route_detail.dart';
import 'package:trigger/ui/component/spot_route.dart';
import 'package:trigger/ui/component/transportation_route.dart';

class RouteDetail extends StatefulWidget {
  const RouteDetail({Key? key, required this.route}) : super(key: key);

  final RecommendedRoute route;

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  final details = <RecommendedRouteDetail>[];
  final detailsComponents = <Widget>[];

  @override
  void initState() {
    super.initState();

    details.addAll(widget.route.details);
    createRouteComponent();
  }

  void createRouteComponent() {
    details.asMap().forEach((i, detail) {
      if (i == details.length - 1) {
        // 最後の場合
        detailsComponents.add(SpotRoute(detail: detail));
      } else {
        // それ以外の場合
        detailsComponents
          ..add(SpotRoute(detail: detail))
          ..add(TransportationRoute(nextAction: detail.nextAction));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.route.description,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: detailsComponents,
        ),
      ),
    );
  }
}
