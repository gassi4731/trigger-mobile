import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route_detail.dart';

class RouteDetail extends StatefulWidget {
  const RouteDetail({Key? key, required this.detail}) : super(key: key);

  final RecommendedRouteDetail detail;

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ルートの詳細')),
      body: SingleChildScrollView(
          child: Column(
        children: const [],
      )),
    );
  }
}
