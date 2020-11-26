import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

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

ThemeData coodinatorTheme = ThemeData(
  primaryColor: Color(0xFF006D77),
  accentColor: Color(0xFFFDDD2),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF006D77),
        accentColor: Color(0xFFE29578),
      ),
      title: '$name Demo',
      routes: {
        "/": (context) => HomePage(),
        // "/signup": (context) => SignupPage(),
        // "/login": (context) => LoginPage(),
        // "/coordinator": (context) => CoordinatorPage(),
        // "/packer": (context) => PackerPage(),
        // "/driver": (context) => DriverPage()
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

class LoginPage extends StatefulWidget {
  Function navigatorCallback;
  LoginPage({Key key, @required this.navigatorCallback}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int formselected = 0;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => widget.navigatorCallback(1, 300),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: packerTheme.accentColor,
      body: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Login page",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
          controller: username,
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide(
                  color: formselected == 1
                      ? Theme.of(context).accentColor
                      : Colors.transparent),
            ),
          ),
          onTap: () {
            setState(() {
              this.formselected = 1;
            });
          },
        ),
        TextField(
          obscureText: true,
          controller: password,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide(
                  color: formselected == 2
                      ? Theme.of(context).accentColor
                      : Colors.transparent),
            ),
          ),
          onTap: () {
            setState(() {
              this.formselected = 2;
            });
          },
        ),
        RaisedButton(
          child: Text("Login"),
          onPressed: () {},
        )
      ]),
    );
  }
}

class SignupPage extends StatelessWidget {
  Function navigatorCallback;
  SignupPage({Key key, @required this.navigatorCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => navigatorCallback(1, 300),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: driverTheme.accentColor,
      body: Container(
        child: Text("SignupPage page"),
      ),
    );
  }
}
