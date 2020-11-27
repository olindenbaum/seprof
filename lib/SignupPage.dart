import 'package:flutter/material.dart';
import 'package:seprof/Vars.dart';

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
