import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/model/sort_mode.dart';
import 'package:trigger/support_file/sort.dart';
import 'package:trigger/ui/component/overview_route.dart';
import 'package:trigger/ui/screen/route_detail.dart';

import '../../model/recommended_route.dart';
import '../../support_file/position.dart';

class SearchCurrentLocation extends StatefulWidget {
  const SearchCurrentLocation({Key? key}) : super(key: key);

  @override
  State<SearchCurrentLocation> createState() => _SearchCurrentLocation();
}

class _SearchCurrentLocation extends State<SearchCurrentLocation>
    with SingleTickerProviderStateMixin {
  List<RecommendedRoute> routes = <RecommendedRoute>[];
  late int sortModeId = 2;
  final sortModes = [
    SortMode(id: 0, iconData: Icons.directions_run, text: '体力を優先'),
    SortMode(id: 1, iconData: Icons.attach_money, text: '金額が安い'),
    SortMode(id: 2, iconData: Icons.timer_rounded, text: '早く帰る'),
  ];

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    fetchRecommendRoute();
  }

  Future<void> fetchRecommendRoute() async {
    // 現在地の情報を取得
    final position = await determinePosition();
    final longitude = position.longitude;
    final latitude = position.latitude;
    print('[position] $longitude $latitude');

    // TODO: APIからおすすめのルートを取得する。
    routes
      ..removeRange(0, routes.length)
      ..addAll(await mockRecommendedRoutes());
    sort();
    setState(() {});
  }

  void sort() {
    switch (sortModeId) {
      case 0:
        routes = sortRouteByPhysical(routes);
        break;
      case 1:
        routes = sortRouteByPrice(routes);
        break;
      case 2:
        routes = sortRouteByTime(routes);
        break;
      default:
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('現在地から帰る')),
      body: RefreshIndicator(
        onRefresh: fetchRecommendRoute,
        child: ListView.builder(
          itemCount: routes.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push<MaterialPageRoute>(
                MaterialPageRoute(
                  builder: (context) {
                    return RouteDetail(details: routes[index].details);
                  },
                ),
              ),
              child: OverviewRoute(route: routes[index]),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionBubble(
        items: sortModes.map((e) {
          return Bubble(
            icon: e.iconData,
            iconColor: Colors.white,
            title: e.text,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            bubbleColor: Colors.black,
            onPress: () {
              sortModeId = e.id;
              sort();
              animationController.reverse();
            },
          );
        }).toList(),

        // animation controller
        animation: animation,

        // On pressed change animation state
        onPress: () => animationController.isCompleted
            ? animationController.reverse()
            : animationController.forward(),

        // Floating Action button Icon color
        iconColor: Theme.of(context).primaryColor,

        // Flaoting Action button Icon
        iconData: Icons.sort,
        backGroundColor: Colors.white,
      ),
    );
  }
}
