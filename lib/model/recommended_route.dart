import 'package:intl/intl.dart';
import 'package:trigger/model/recommended_route_detail.dart';

class RecommendedRoute {
  RecommendedRoute({
    this.timeLimit,
    required this.isEnableTimeLimit,
    required this.price,
    required this.allPoint,
    required this.physicalPoint,
    required this.isUseTrain,
    required this.isUseTaxi,
    required this.isUseHotel,
    required this.details,
  });
  final DateTime? timeLimit;
  final bool isEnableTimeLimit;
  final int price;
  final double allPoint;
  final double physicalPoint;
  final bool isUseTrain;
  final bool isUseTaxi;
  final bool isUseHotel;
  final List<RecommendedRouteDetail> details;

  String getTimeLimit() {
    if (isEnableTimeLimit && timeLimit != null) {
      final formatter = DateFormat('HH:mm');
      return formatter.format(timeLimit!);
    } else {
      return '∞';
    }
  }

  String getAmount() {
    final formatter = NumberFormat('#,###');
    return '￥${formatter.format(price)}';
  }
}
