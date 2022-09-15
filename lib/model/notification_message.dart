import 'package:kitakatu/model/recommended_route.dart';

class NotificationMessage {
  NotificationMessage({
    required this.hour,
    required this.minutes,
    required this.message,
  });

  factory NotificationMessage.fromRecommendedRoute(RecommendedRoute route) {
    final time = route.timeLimit!.add(const Duration(minutes: 30) * -1);

    return NotificationMessage(
      hour: time.hour,
      minutes: time.minute,
      message: '自宅まで「${route.description}のルートで帰るまで残り30分',
    );
  }

  final int hour;
  final int minutes;
  final String message;
}
