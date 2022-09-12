import 'dart:math';

import 'package:trigger/model/recommended_route.dart';

List<RecommendedOverviewRoute> mockRecommendedOverviewRoute([int length = 1]) {
  final now = DateTime.now();
  final year = now.year;
  final month = now.month;
  final day = now.day;

  final mocks = [
    RecommendedOverviewRoute(
      timeLimit: DateTime(year, month, day + 1, 1, 10),
      isEnableTimeLimit: true,
      amount: Random().nextInt(500),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: true,
      isUseTaxi: false,
      isUseHotel: false,
    ),
    RecommendedOverviewRoute(
      isEnableTimeLimit: false,
      amount: Random().nextInt(5000),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: false,
      isUseTaxi: true,
      isUseHotel: false,
    ),
    RecommendedOverviewRoute(
      timeLimit: DateTime(year, month, day, 16, 50),
      isEnableTimeLimit: true,
      amount: Random().nextInt(5000),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: true,
      isUseTaxi: true,
      isUseHotel: false,
    ),
    RecommendedOverviewRoute(
      timeLimit: DateTime(year, month, day, 23, 10),
      isEnableTimeLimit: true,
      amount: Random().nextInt(5000),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: true,
      isUseTaxi: false,
      isUseHotel: true,
    ),
    RecommendedOverviewRoute(
      isEnableTimeLimit: false,
      amount: Random().nextInt(5000),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: false,
      isUseTaxi: true,
      isUseHotel: true,
    ),
    RecommendedOverviewRoute(
      isEnableTimeLimit: false,
      amount: Random().nextInt(5000),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: false,
      isUseTaxi: false,
      isUseHotel: true,
    ),
  ];

  return mocks;
}
