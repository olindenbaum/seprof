import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

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
        // "/coordinator": (context) => CoordinatorPage(),
        // "/packer": (context) => PackerPage(),
        // "/driver": (context) => DriverPage()
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
          onPressed: () => widget.navigatorCallback(1, duration: 300),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: TextField(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
            child: RaisedButton(
              child: Text("Login", style: TextStyle(fontSize: 15)),
              onPressed: () {},
              color: Theme.of(context).accentColor,
              splashColor: Theme.of(context).primaryColor,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide(color: Theme.of(context).accentColor),
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
