import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seprof/CoordinatorPage.dart';
import 'package:seprof/DriverPage.dart';
import 'package:seprof/PackerPage.dart';
import 'package:seprof/PageHelpers.dart';
import 'package:seprof/Vars.dart';
import 'package:seprof/cust_page_view.dart';

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
      resizeToAvoidBottomInset: true,
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
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(Duration(milliseconds: 300));
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
