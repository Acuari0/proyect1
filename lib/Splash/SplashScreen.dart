import 'package:biomagnapro/LoginWidget/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new SplashScreen(
          seconds: 5,
          navigateAfterSeconds: LoginScreen(),
          imageBackground:  Image.asset("assets/splash.png").image,
          //image: Image.asset("assets/logoblanco.png"),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: ()=>print("Flutter Egypt"),
         useLoader: false,
      ),
    );
  }
}