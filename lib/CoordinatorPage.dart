import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:seprof/AccountSettingsBar.dart';
import 'package:seprof/Drawer.dart';
import 'package:seprof/PageHelpers.dart';
import 'package:seprof/Vars.dart';

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
                    resizeToAvoidBottomInset: false,
                    backgroundColor: coordinatorTheme.accentColor,
                    body: CoordinatorPageContents(),
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

class CoordinatorPageContents extends StatelessWidget {
  const CoordinatorPageContents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: AccountSettings(
                    themeData: coordinatorTheme, type: "coordinator"),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountPageOptionButton(
                      icon: FontAwesomeIcons.calendar,
                      text: "Timetable",
                      onPressed: () {
                        Navigator.pushNamed(context, "/timetable");
                      }),
                  AccountPageOptionButton(
                      icon: Icons.people,
                      text: "Update Recipients",
                      onPressed: () {}), //TODO
                  AccountPageOptionButton(
                      icon: FontAwesomeIcons.gift,
                      text: "View Parcels",
                      onPressed: () {
                        Navigator.pushNamed(context, "/parcels");
                      }), //TODO
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Hero(
            tag: "illustration",
            child: SvgPicture.asset(
              "assets/undraw/coordinator.svg",
            ),
          ),
        ),
      ],
    );
  }
}
