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

  factory RecommendedRouteDetail.fromJson(Map<dynamic, dynamic> json) {
    final leaveAt = json['leave_at'] != ''
        ? DateTime.parse(json['leave_at'].toString())
        : null;
    final arriveAt = json['arrive_at'] != ''
        ? DateTime.parse(json['arrive_at'].toString())
        : null;

    return RecommendedRouteDetail(
      from: json['from'].toString(),
      to: json['to'].toString(),
      leaveAt: leaveAt,
      arriveAt: arriveAt,
      requiredMinute: int.parse(json['required_minute'].toString()),
      price: int.parse(json['price'].toString()),
      method: json['method'].toString(),
      train: RecommendedRouteDetailTrain.fromJson(
        json['train'] as Map<dynamic, dynamic>,
      ),
    );
  }

  final String from;
  final String to;
  final DateTime? leaveAt;
  final DateTime? arriveAt;
  final int requiredMinute;
  final int price;
  final String method;
  final RecommendedRouteDetailTrain train;
}
