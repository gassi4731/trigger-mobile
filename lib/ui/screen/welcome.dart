import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trigger/ui/screen/address.dart';
import 'package:trigger/ui/screen/search_current_location.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();

      // 住所を登録済みかで動作を分ける
      await Navigator.of(context).pushReplacement<dynamic, dynamic>(
        MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: '/detail'),
          builder: (context) {
            return prefs.get('isRegisteredAddress') == true
                ? const SearchCurrentLocation()
                : const Address();
          },
        ),
      );
    });
    return const Scaffold(
      body: Center(
        child: Text('loading...'),
      ),
    );
  }
}
