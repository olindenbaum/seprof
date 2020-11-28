import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:seprof/CoordinatorPage.dart';
import 'package:seprof/DriverPage.dart';
import 'package:seprof/LoginPage.dart';
import 'package:seprof/PackerPage.dart';
import 'package:seprof/SignupPage.dart';
import 'package:seprof/SplashScreen.dart';
import 'package:seprof/StartPage.dart';
import 'package:seprof/Vars.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF006D77),
        accentColor: Color(0xFFE29578),
      ),
      title: '$name Demo',
      routes: {
        "/": (context) => HomePage(),
        "/splash": (context) => SplashPage(),
        // "/signup": (context) => SignupPage(),
        // "/login": (context) => LoginPage(),
        "/coordinator": (context) => CoordinatorPage(),
        "/packer": (context) => PackerPage(),
        "/driver": (context) => DriverPage()
      },
      initialRoute: "/",
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case "/signup":
      //       return FadeRouteBuilder(page: SignupPage());
      //     case "/login":
      //       return FadeRouteBuilder(page: LoginPage());
      //   }
      // },
    );
  }
}

class HomePage extends StatelessWidget {
  LiquidController pageController = new LiquidController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LiquidSwipe(
        disableUserGesture: true,
        enableSlideIcon: false,
        liquidController: this.pageController,
        initialPage: 1,
        pages: [
          SignupPage(navigatorCallback: this._navigatorCallback),
          MainPage(
            navigatorCallback: this._navigatorCallback,
          ),
          LoginPage(navigatorCallback: this._navigatorCallback),
        ],
      ),
    );
  }

  void _navigatorCallback(int to, {int duration = 600}) {
    this.pageController.animateToPage(page: to, duration: duration);
  }
}
