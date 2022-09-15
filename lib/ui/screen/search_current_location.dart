import 'dart:convert';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/model/sort_mode.dart';
import 'package:trigger/support_file/api.dart';
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
    SortMode(id: 0, iconData: Icons.directions_run, text: '快適さを優先'),
    SortMode(id: 1, iconData: Icons.attach_money, text: '金額が安い'),
    SortMode(id: 2, iconData: Icons.timer_rounded, text: '出発時間順'),
  ];

  // floatingActionButton
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
    const flavor = String.fromEnvironment('FLAVOR');

    switch (flavor) {
      case 'prod':
        // 現在地の情報を取得
        final position = await determinePosition();

        final response = await http.get(
          Uri.https(
            APIUrls.authority,
            APIUrls.fetchRoutes,
          ),
        );

        final jsonResponses = jsonDecode(response.body) as List<dynamic>;
        routes = jsonResponses
            .map((dynamic e) => e as Map<dynamic, dynamic>)
            .map(RecommendedRoute.fromJson)
            .toList();
        routes = sort(routes, sortModeId);
        break;
      case 'dev':
      default:
        routes = await mockRecommendedRoutes();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '現在地から帰る',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchRecommendRoute,
        child: ListView.builder(
          itemCount: routes.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push<MaterialPageRoute>(
                MaterialPageRoute(
                  builder: (context) => RouteDetail(route: routes[index]),
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
              setState(() {
                sortModeId = e.id;
                routes = sort(routes, sortModeId);
              });
              animationController.reverse();
            },
          );
        }).toList(),
        animation: animation,
        onPress: () => animationController.isCompleted
            ? animationController.reverse()
            : animationController.forward(),
        iconColor: Theme.of(context).primaryColor,
        iconData: Icons.sort,
        backGroundColor: Colors.white,
      ),
    );
  }
}
