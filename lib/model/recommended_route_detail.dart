import 'package:trigger/model/recommended_route_detail_train.dart';

class RecommendedRouteDetail {
  RecommendedRouteDetail({
    required this.from,
    required this.to,
    required this.leaveAt,
    required this.arriveAt,
    required this.requiredMinute,
    required this.price,
    required this.method,
    required this.train,
  });

  final String from;
  final String to;
  final DateTime leaveAt;
  final DateTime arriveAt;
  final DateTime requiredMinute;
  final int price;
  final String method;
  final RecommendedRouteDetailTrain train;
}
