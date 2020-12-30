import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:circle_action/Screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        []); // suprime toutes la barres de navigation en haut (baterie) et en bas 8 importer service.dart
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circle Action',
      home: HomeScreen(),
    );
  }
}
