class RecommendedRouteDetailTrain {
  RecommendedRouteDetailTrain({
    required this.line,
    required this.direction,
    required this.track,
  });

  factory RecommendedRouteDetailTrain.fromJson(Map<dynamic, dynamic> json) {
    return RecommendedRouteDetailTrain(
      line: json['line'].toString(),
      direction: json['direction'].toString(),
      track: json['track'].toString(),
    );
  }

  final String line;
  final String direction;
  final String track;
}
