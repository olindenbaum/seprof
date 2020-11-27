import 'package:flutter/material.dart';
import 'package:seprof/Vars.dart';

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
