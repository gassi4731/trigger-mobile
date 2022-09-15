import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kitakatu/model/recommended_route_detail.dart';
import 'package:kitakatu/support_file/extension_string.dart';

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
    required this.description,
  });

  factory RecommendedRoute.fromJson(Map<dynamic, dynamic> json) {
    DateTime? timeLimit;
    if (json['time_limit'] != null && json['time_limit'] != '') {
      timeLimit = DateTime.parse(json['time_limit'].toString()).toLocal();
    } else {
      timeLimit = null;
    }

    final rawDetails = json['details'] as List<dynamic>;
    final details = <RecommendedRouteDetail>[];
    for (final item in rawDetails) {
      details
          .add(RecommendedRouteDetail.fromJson(item as Map<dynamic, dynamic>));
    }

    return RecommendedRoute(
      timeLimit: timeLimit,
      isEnableTimeLimit: timeLimit != null,
      price: int.parse(json['price'].toString()),
      allPoint: double.parse(json['all_point'].toString()),
      physicalPoint: double.parse(json['physical_point'].toString()),
      isUseTrain: (json['is_use_train'].toString()).parseBool(),
      isUseTaxi: (json['is_use_taxi'].toString()).parseBool(),
      isUseHotel: (json['is_use_hotel'].toString()).parseBool(),
      details: details,
      description: json['description'].toString(),
    );
  }

  final DateTime? timeLimit;
  final bool isEnableTimeLimit;
  final int price;
  final double allPoint;
  final double physicalPoint;
  final bool isUseTrain;
  final bool isUseTaxi;
  final bool isUseHotel;
  final List<RecommendedRouteDetail> details;
  final String description;

  String getTimeLimit() {
    if (isEnableTimeLimit && timeLimit != null) {
      initializeDateFormatting('ja');
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
