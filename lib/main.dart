import 'package:flutter/material.dart';
import 'package:coin_dcx/pages/SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin DCX',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D111D),
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF131B31),
        primarySwatch: Colors.red,

        highlightColor: Colors.transparent,
        splashColor: Colors.transparent
      ),
      home: SplashPage(),
    );
  }
}
