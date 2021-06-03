import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/after_splash_page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: AfterSplashPage(),
      image: Image.asset('assets/news_logo.png',alignment: Alignment.center,),
      //Splash screen background image
      backgroundColor: Colors.white,
      //Splash screen background color
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 200.0,
      useLoader: false,
    );
  }
}
