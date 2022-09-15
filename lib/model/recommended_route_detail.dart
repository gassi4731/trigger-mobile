import 'package:intl/intl.dart';
import 'package:kitakatu/model/recommended_route_next_action.dart';

class RecommendedRouteDetail {
  RecommendedRouteDetail({
    required this.name,
    required this.nextAction,
    this.arriveAt,
    this.leaveAt,
    required this.price,
    required this.placeGenre,
  });

  factory RecommendedRouteDetail.fromJson(Map<dynamic, dynamic> json) {
    final leaveAt = json['leave_at'] != null
        ? DateTime.parse(json['leave_at'].toString()).toLocal()
        : null;
    final arriveAt = json['arrive_at'] != null
        ? DateTime.parse(json['arrive_at'].toString()).toLocal()
        : null;

    return RecommendedRouteDetail(
      name: json['name'].toString(),
      nextAction: RecommendedRouteNextAction.fromJson(
        json['next_action'] as Map<dynamic, dynamic>,
      ),
      arriveAt: arriveAt,
      leaveAt: leaveAt,
      price: int.parse(json['price'].toString()),
      placeGenre: json['place_genre'].toString(),
    );
  }

  final String name;
  final RecommendedRouteNextAction nextAction;
  final DateTime? arriveAt;
  final DateTime? leaveAt;
  final int price;
  final String placeGenre;

  String getPrice() {
    final formatter = NumberFormat('#,###');
    return '￥${formatter.format(price)}';
  }
}
