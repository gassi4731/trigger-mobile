import 'package:trigger/model/recommended_route_next_action.dart';

class RecommendedRouteDetail {
  RecommendedRouteDetail({
    required this.name,
    required this.nextAction,
    this.arriveAt,
    this.leaveAt,
    required this.price,
  });

  factory RecommendedRouteDetail.fromJson(Map<dynamic, dynamic> json) {
    final leaveAt = json['leave_at'] != null
        ? DateTime.parse(json['leave_at'].toString())
        : null;
    final arriveAt = json['arrive_at'] != null
        ? DateTime.parse(json['arrive_at'].toString())
        : null;

    return RecommendedRouteDetail(
      name: json['name'].toString(),
      nextAction: RecommendedRouteNextAction.fromJson(
        json['next_action'] as Map<dynamic, dynamic>,
      ),
      arriveAt: arriveAt,
      leaveAt: leaveAt,
      price: int.parse(json['price'].toString()),
    );
  }

  final String name;
  final RecommendedRouteNextAction nextAction;
  final DateTime? arriveAt;
  final DateTime? leaveAt;
  final int price;
}
