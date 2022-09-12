import 'package:flutter/material.dart';
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/model/sort_mode.dart';
import 'package:trigger/ui/component/overview_route.dart';
import 'package:trigger/ui/theme/padding_size.dart';
import '../../model/recommended_route.dart';

class SearchCurrentLocation extends StatefulWidget {
  const SearchCurrentLocation({Key? key}) : super(key: key);

  @override
  State<SearchCurrentLocation> createState() => _SearchCurrentLocation();
}

class _SearchCurrentLocation extends State<SearchCurrentLocation>
    with SingleTickerProviderStateMixin {
  final routes = <RecommendedRoute>[];
  late SortMode sortMode;
  final sortModes = [
    SortMode(id: 0, iconData: Icons.directions_run, text: '体力優先'),
    SortMode(id: 1, iconData: Icons.attach_money, text: '金額優先'),
    SortMode(id: 2, iconData: Icons.timer_rounded, text: '時間優先'),
  ];

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    fetchRecommendRoute();
    super.initState();
  }

  Future<void> fetchRecommendRoute() async {
    // TODO: APIからおすすめのルートを取得する。
    routes.addAll(await mockRecommendedRoutes());
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
            return Column(
              children: [
                const SizedBox(height: PaddingSize.ps15),
                OverviewRoute(route: routes[index]),
              ],
            );
          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: FloatingActionBubble(
      //   items: sortModes.map((e) {
      //     return Bubble(
      //       icon: e.iconData,
      //       iconColor: Colors.white,
      //       title: e.text,
      //       titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
      //       bubbleColor: Colors.black,
      //       onPress: () {
      //         animationController.reverse();
      //       },
      //     );
      //   }).toList(),

      //   // animation controller
      //   animation: animation,

      //   // On pressed change animation state
      //   onPress: () => animationController.isCompleted
      //       ? animationController.reverse()
      //       : animationController.forward(),

      //   // Floating Action button Icon color
      //   iconColor: Theme.of(context).primaryColor,

      //   // Flaoting Action button Icon
      //   iconData: Icons.sort,
      //   backGroundColor: Colors.white,
      // ),
    );
  }
}
