import 'dart:math';

import 'package:trigger/model/recommended_overview_route.dart';

List<RecommendedOverviewRoute> mockRecommendedOverviewRoute([int length = 1]) {
  final mocks = [
    RecommendedOverviewRoute(
      timeLimit: DateTime(2020, 10, 2, 12, 10),
      isEnableTimeLimit: true,
      amount: Random().nextInt(5000),
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
      timeLimit: DateTime(2020, 10, 2, 15, 10),
      isEnableTimeLimit: true,
      amount: Random().nextInt(5000),
      allPoint: Random().nextDouble() * 100,
      physicalPoint: Random().nextDouble() * 100,
      isUseTrain: true,
      isUseTaxi: true,
      isUseHotel: false,
    ),
    RecommendedOverviewRoute(
      timeLimit: DateTime(2020, 10, 2, 16, 10),
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
