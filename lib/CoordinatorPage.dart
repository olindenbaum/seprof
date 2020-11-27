import 'package:flutter/material.dart';
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
