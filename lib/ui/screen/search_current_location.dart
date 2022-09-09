import 'package:flutter/material.dart';
import 'package:trigger/mock/recommended_overview_route.dart';
import 'package:trigger/ui/component/overview_route.dart';
import 'package:trigger/ui/theme/padding_size.dart';
import '../../model/recommended_overview_route.dart';

class SearchCurrentLocation extends StatefulWidget {
  const SearchCurrentLocation({Key? key}) : super(key: key);

  @override
  State<SearchCurrentLocation> createState() => _SearchCurrentLocation();
}

class _SearchCurrentLocation extends State<SearchCurrentLocation> {
  final routes = <RecommendedOverviewRoute>[];
  final sortMode = 0;

  @override
  void initState() {
    super.initState();
    fetchRecommendRoute();
  }

  Future<void> fetchRecommendRoute() async {
    setState(() {
      // TODO: APIからおすすめのルートを取得する。
      routes.addAll(mockRecommendedOverviewRoute());
    });
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
    );
  }
}
