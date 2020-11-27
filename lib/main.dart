// import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seprof/Drawer.dart';

import 'cust_page_view.dart';

void main() {
  runApp(MyApp());
}

String name = "SEPROF 34";
ThemeData packerTheme = ThemeData(
  primaryColor: Color(0xFFE29578),
  accentColor: Color(0xFFD1E9F0),
);

ThemeData driverTheme = ThemeData(
  primaryColor: Color(0xFFE29578),
  accentColor: Color(0xFF90CBC5),
);

ThemeData coordinatorTheme = ThemeData(
  primaryColor: Color(0xFF006D77),
  accentColor: Color(0xFFFFDDD2),
);

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimer(context);
  }

  void startTimer(BuildContext context) {
    Future.delayed(Duration(seconds: 3))
        .then((value) => Navigator.of(context).pushReplacementNamed("/"));
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottie/delivery.json');
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE29578),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<LottieComposition>(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) {
            return Lottie(composition: composition);
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF006D77),
              ),
            ));
          }
        },
      ),
    );
  }
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
      initialRoute: "/splash",
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

class MainPage extends StatelessWidget {
  Function navigatorCallback;

  MainPage({Key key, @required this.navigatorCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: [
          Text(name),
          Image.network(
            "https://ccorpusa.com/wp-content/uploads/2017/07/logo.png",
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                RaisedButton(
                    child: Text("Login"),
                    onPressed: () => navigatorCallback(2)),
                RaisedButton(
                    child: Text("Sign up"),
                    onPressed: () => navigatorCallback(0))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class PageVisible extends ValueNotifier<Map<String, bool>> {
  PageVisible(Map<String, bool> value) : super(value);

  void setType(String type, bool to) {
    value[type] = to;
    notifyListeners();
  }

  void setAll(bool to) {
    value.map((key, value) => MapEntry(key, to));
  }
}

class LoginPage extends StatefulWidget {
  Function navigatorCallback;
  LoginPage({Key key, @required this.navigatorCallback}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PageController _pageController = new PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<PageController>(
          create: (BuildContext context) => new PageController(initialPage: 0),
        ),
        ListenableProvider<PageVisible>(
          create: (c) => new PageVisible(
              {"driver": false, "packer": false, "coordinator": false}),
        )
      ],
      child: Builder(
        builder: (_) => LoginPageSwitcher(
          navigatorCallback: this.widget.navigatorCallback,
        ),
      ),
    );
  }
}

class LoginPageSwitcher extends StatefulWidget {
  Function navigatorCallback;
  LoginPageSwitcher({Key key, @required this.navigatorCallback})
      : super(key: key);

  @override
  _LoginPageSwitcherState createState() => _LoginPageSwitcherState();
}

class _LoginPageSwitcherState extends State<LoginPageSwitcher> {
  List<Widget> pages;
  List<Color> colors;
  int formselected = 0;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  void didChangeDependencies() {
    pages = [
      LoginPageMain(
        widget: widget,
        username: username,
        formselected: formselected,
        password: password,
      ),
      CoordinatorPage(),
      PackerPage(),
      DriverPage(),
    ];

    colors = [
      //loginpage
      Theme.of(context).primaryColor,
      //coordinator page
      coordinatorTheme.accentColor,
      //packer page
      packerTheme.accentColor,
      //driver page
      driverTheme.accentColor,
    ];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConcentricPageView(
      pageController: Provider.of<PageController>(context, listen: true),
      colors: colors,
      opacityFactor: 1.0,
      scaleFactor: 0.0,
      radius: 30,
      curve: Curves.ease,
      duration: Duration(seconds: 2),
      verticalPosition: 0.7,
      direction: Axis.vertical,
      itemCount: pages.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (index, value) {
        Widget page = pages[index % pages.length];
        // For example scale or transform some widget by [value] param
        //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
        // return Center(
        //   child: Container(
        //     child: Text('Page $index'),
        //   ),
        // );
        return page;
      },
    );
  }
}

class LoginPageMain extends StatefulWidget {
  LoginPageMain({
    Key key,
    @required this.widget,
    @required this.username,
    @required this.formselected,
    @required this.password,
  }) : super(key: key);

  final LoginPageSwitcher widget;
  final TextEditingController username;
  final TextEditingController password;
  int formselected;

  @override
  _LoginPageMainState createState() => _LoginPageMainState();
}

class _LoginPageMainState extends State<LoginPageMain>
    with SingleTickerProviderStateMixin {
  Animation<double> offsetAnimation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              blurRadius: 3,
              offset: Offset(6, 2),
            ),
          ],
        ),
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          child: Icon(Icons.arrow_back),
          onPressed: () => widget.widget.navigatorCallback(1, duration: 300),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: packerTheme.accentColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Login page",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: TextField(
              controller: widget.username,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(
                      color: widget.formselected == 1
                          ? Theme.of(context).accentColor
                          : Colors.transparent),
                ),
              ),
              onTap: () {
                setState(() {
                  this.widget.formselected = 1;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: TextField(
              obscureText: true,
              controller: widget.password,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(
                      color: widget.formselected == 2
                          ? Theme.of(context).accentColor
                          : Colors.transparent),
                ),
              ),
              onTap: () {
                setState(() {
                  this.widget.formselected = 2;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
            child: AnimatedBuilder(
              animation: offsetAnimation,
              builder: (context, __) => Container(
                padding: EdgeInsets.only(
                    left: offsetAnimation.value + 24.0,
                    right: 24.0 - offsetAnimation.value),
                child: RaisedButton(
                  child: Text("Login", style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    if (widget.username.text.contains("coord")) {
                      Provider.of<PageVisible>(context, listen: false)
                          .setType("coordinator", true);

                      Provider.of<PageController>(context, listen: false)
                          .animateToPage(
                        1,
                        curve: Curves.ease,
                        duration: Duration(seconds: 2),
                      );
                      // Navigator.of(context).pushNamed("/coordinator");
                    } else if (widget.username.text.contains("pack")) {
                      // Navigator.of(context).pushNamed("/packer");
                      Provider.of<PageVisible>(context, listen: false)
                          .setType("packer", true);
                      Provider.of<PageController>(context, listen: false)
                          .animateToPage(
                        2,
                        curve: Curves.ease,
                        duration: Duration(seconds: 2),
                      );
                    } else if (widget.username.text.contains("drive")) {
                      // Navigator.of(context).pushNamed("/driver");
                      Provider.of<PageVisible>(context, listen: false)
                          .setType("driver", true);

                      Provider.of<PageController>(context, listen: false)
                          .animateToPage(
                        3,
                        curve: Curves.ease,
                        duration: Duration(seconds: 2),
                      );
                    } else {
                      controller.forward(from: 0.0);
                    }
                    widget.username.clear();
                    widget.password.clear();
                  },
                  color: Theme.of(context).accentColor,
                  splashColor: Theme.of(context).primaryColor,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  Function navigatorCallback;
  SignupPage({Key key, @required this.navigatorCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              blurRadius: 3,
              offset: Offset(6, 2),
            ),
          ],
        ),
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          child: Icon(Icons.arrow_forward),
          onPressed: () => navigatorCallback(1, duration: 300),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: driverTheme.accentColor,
      body: Center(
        child: Container(
          child: Text("SignupPage", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}

class DriverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: driverTheme,
      child: Builder(
        builder: (context) {
          if (Provider.of<PageVisible>(context, listen: true).value["driver"] ==
              true) {
            return KTDrawerMenu(
              width: 150,
              drawer: DrawerPage(),
              content: Container(
                color: driverTheme.accentColor,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: driverTheme.accentColor,
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AccountSettings(
                                themeData: driverTheme, type: "driver"),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              "driver Page",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return FittedBox(
                fit: BoxFit.fill,
                child: Container(color: driverTheme.accentColor));
          }
        },
      ),
    );
  }
}

class CoordinatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: coordinatorTheme,
      child: Builder(
        builder: (context) {
          if (Provider.of<PageVisible>(context, listen: true)
                  .value["coordinator"] ==
              true) {
            return KTDrawerMenu(
              width: 150,
              drawer: DrawerPage(),
              content: Container(
                color: coordinatorTheme.accentColor,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: coordinatorTheme.accentColor,
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AccountSettings(
                                themeData: coordinatorTheme,
                                type: "coordinator"),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              "coordinator Page",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return FittedBox(
                fit: BoxFit.fill,
                child: Container(color: coordinatorTheme.accentColor));
          }
        },
      ),
    );
  }
}

class PackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: packerTheme,
      child: Builder(
        builder: (context) {
          if (Provider.of<PageVisible>(context, listen: true).value["packer"] ==
              true) {
            return KTDrawerMenu(
              width: 150,
              drawer: DrawerPage(),
              content: Container(
                color: packerTheme.accentColor,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: packerTheme.accentColor,
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AccountSettings(
                                themeData: packerTheme, type: "packer"),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              "Packer Page",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return FittedBox(
                fit: BoxFit.fill,
                child: Container(color: packerTheme.accentColor));
          }
        },
      ),
    );
  }
}

class AccountSettings extends StatelessWidget {
  final ThemeData themeData;
  String type;
  AccountSettings({this.themeData, this.type});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: this.themeData,
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(90.0),
              ),
              border:
                  Border.all(color: themeData.primaryColor.withOpacity(0.6))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Account Settings",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              )
            ],
          ),
        ),
        onTap: () {
          KTDrawerMenu.of(context).toggle();
        },
      ),
    );
  }
}
