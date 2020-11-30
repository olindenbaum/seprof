import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:seprof/AccountSettingsBar.dart';
import 'package:seprof/Drawer.dart';
import 'package:seprof/PageHelpers.dart';
import 'package:seprof/QR.dart';
import 'package:seprof/Vars.dart';

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
                    resizeToAvoidBottomInset: false,
                    backgroundColor: driverTheme.accentColor,
                    body: DriverPageContents(),
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

class DriverPageContents extends StatelessWidget {
  const DriverPageContents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child:
                        AccountSettings(themeData: driverTheme, type: "driver"),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AccountPageOptionButton(
                        icon: FontAwesomeIcons.calendarPlus,
                        text: "Book Shifts",
                        onPressed: () => Navigator.of(context).pushNamed(
                          "/bshift",
                          arguments: ShiftPageSettings(
                              "/bshift", "driver", driverTheme),
                        ),
                      ),
                      AccountPageOptionButton(
                        icon: FontAwesomeIcons.peopleCarry,
                        text: "My Shifts",
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            "/vshift",
                            arguments: ShiftPageSettings(
                                "/vshift", "driver", driverTheme),
                          );
                        },
                      ),
                      Divider(
                        height: 10,
                        indent: 60,
                        endIndent: 60,
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      AccountPageOptionButton(
                          icon: FontAwesomeIcons.camera,
                          text: "Scan Parcel",
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) => ParcelScanner("driver"));
                          }),
                      AccountPageOptionButton(
                        icon: FontAwesomeIcons.route,
                        text: "Plan Route",
                        onPressed: () => Navigator.of(context).pushNamed(
                          "/route",
                          arguments: ShiftPageSettings(
                              "/route", "driver", driverTheme),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Hero(
            tag: "illustration",
            child: SvgPicture.asset(
              "assets/undraw/driver.svg",
            ),
          ),
        ),
      ],
    );
  }
}
