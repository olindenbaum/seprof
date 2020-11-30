import 'package:flutter/material.dart';

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

class AccountPageOptionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  final EdgeInsets padding;
  final EdgeInsets textPadding;
  final bool reverse;

  const AccountPageOptionButton(
      {Key key,
      this.icon,
      this.text,
      this.reverse = false,
      this.onPressed,
      this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
      this.textPadding = const EdgeInsets.only(left: 8.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RaisedGradientButton(
        onPressed: onPressed,
        width: MediaQuery.of(context).size.width * 0.9,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.9),
              Theme.of(context).primaryColor.withOpacity(0.4)
            ]),
        child: Row(
          mainAxisAlignment:
              reverse ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            reverse
                ? Container()
                : Padding(
                    padding: textPadding,
                    child: Text(text,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white.withOpacity(0.95))),
                  ),
            icon == Icons.no_encryption
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(icon, color: Colors.white.withOpacity(0.95)),
                  ),
            reverse
                ? Padding(
                    padding: textPadding,
                    child: Text(text,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white.withOpacity(0.95))),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: width,
      height: 70.0,
      decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
          borderRadius: BorderRadius.circular(25)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
