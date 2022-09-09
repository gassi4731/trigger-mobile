class RecommendedOverviewRoute {
  RecommendedOverviewRoute({
    this.timeLimit,
    required this.isEnableTimeLimit,
    required this.amount,
    required this.allPoint,
    required this.physicalPoint,
    required this.isUseTrain,
    required this.isUseTaxi,
    required this.isUseHotel,
  });
  final DateTime? timeLimit;
  final bool isEnableTimeLimit;
  final int amount;
  final double allPoint;
  final double physicalPoint;
  final bool isUseTrain;
  final bool isUseTaxi;
  final bool isUseHotel;
}
