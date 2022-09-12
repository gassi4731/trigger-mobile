import 'package:flutter/material.dart';
import 'package:trigger/model/recommended_route_detail.dart';

class TrainRoute extends StatefulWidget {
  const TrainRoute({Key? key, required this.detail}) : super(key: key);

  final RecommendedRouteDetail detail;

  @override
  State<TrainRoute> createState() => _TrainRouteState();
}

class _TrainRouteState extends State<TrainRoute> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
