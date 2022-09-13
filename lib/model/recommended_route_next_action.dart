import 'package:trigger/model/recommended_route_detail_train.dart';

class RecommendedRouteNextAction {
  RecommendedRouteNextAction({
    required this.method,
    required this.price,
    required this.requiredMinute,
    required this.train,
  });

  factory RecommendedRouteNextAction.fromJson(Map<dynamic, dynamic> json) {
    return RecommendedRouteNextAction(
      method: json['method'].toString(),
      price: int.parse(json['price'].toString()),
      requiredMinute: int.parse(json['required_minute'].toString()),
      train: RecommendedRouteDetailTrain.fromJson(
        json['train'] as Map<dynamic, dynamic>,
      ),
    );
  }

  final String method;
  final int price;
  final int requiredMinute;
  final RecommendedRouteDetailTrain train;
}
