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
          Image.network(
            "https://ccorpusa.com/wp-content/uploads/2017/07/logo.png",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Container(
                        height: 85,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 37,
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: packerTheme.accentColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40))),
                      ),
                      onTap: () => navigatorCallback(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Container(
                          height: 85,
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 37,
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: driverTheme.accentColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                        ),
                        onTap: () => navigatorCallback(0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
