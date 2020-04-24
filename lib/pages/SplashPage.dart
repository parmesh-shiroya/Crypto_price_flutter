import 'dart:async';
import 'package:coin_dcx/pages/homePage/HomePage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
          child: Image.asset(
            "images/coindcx_white.png",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Welcome to CoinDCX Markets",
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
        )
      ],
    ));
  }
}
