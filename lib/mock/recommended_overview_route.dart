import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:trigger/model/recommended_route.dart';
import 'package:trigger/model/recommended_route_detail.dart';

Future<List<RecommendedRoute>> mockRecommendedRoutes() async {
  final converted = <RecommendedRoute>[];

  final loadData = await rootBundle.loadString('assets/json/mock_routes.json');
  final jsonResponse = jsonDecode(loadData) as List<dynamic>;
  final jsonResponseMap =
      jsonResponse.map((dynamic e) => e as Map<dynamic, dynamic>);

  for (final i in jsonResponseMap) {
    converted.add(RecommendedRoute.fromJson(i));
  }

  return converted;
}

Future<List<RecommendedRouteDetail>> mockRecommendedRouteDetails() async {
  final routes = await mockRecommendedRoutes();
  final route = routes[0];
  return route.details;
}
