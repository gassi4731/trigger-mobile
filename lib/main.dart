import 'package:flutter/material.dart';
import 'package:trigger/ui/screen/search_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
      home: const SearchCurrentLocation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
