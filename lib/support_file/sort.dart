import 'package:trigger/model/recommended_route.dart';

List<RecommendedRoute> sort(List<RecommendedRoute> routes, int id) {
  var sortedRoutes = <RecommendedRoute>[];
  switch (id) {
    case 0:
      sortedRoutes = sortRouteByPhysical(routes);
      break;
    case 1:
      sortedRoutes = sortRouteByPrice(routes);
      break;
    case 2:
      sortedRoutes = sortRouteByTime(routes);
      break;
    default:
  }
  return sortedRoutes;
}

List<RecommendedRoute> sortRouteByTime(List<RecommendedRoute> routes) {
  routes.sort((a, b) {
    final aTimeLimit = a.timeLimit;
    final bTimeLimit = b.timeLimit;

    if (aTimeLimit != null && bTimeLimit != null) {
      return aTimeLimit.compareTo(bTimeLimit);
    } else if (aTimeLimit == null && bTimeLimit == null) {
      return 0;
    } else if (aTimeLimit == null) {
      return 1;
    } else if (bTimeLimit == null) {
      return -1;
    } else {
      return 0;
    }
  });
  return routes;
}

List<RecommendedRoute> sortRouteByPrice(List<RecommendedRoute> routes) {
  routes.sort((a, b) => a.price.compareTo(b.price));
  return routes;
}

List<RecommendedRoute> sortRouteByPhysical(List<RecommendedRoute> routes) {
  routes.sort((a, b) => a.physicalPoint.compareTo(b.physicalPoint));
  return routes;
}
