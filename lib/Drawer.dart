import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:seprof/PageHelpers.dart';

enum DrawerItemEnum {
  SETTINGS,
  ACCOUNT,
  LOGOUT,
}

// ignore: must_be_immutable
class DrawerPage extends StatefulWidget {
  DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  DrawerItemEnum selected;
  StreamController<DrawerItemEnum> streamController;

  @override
  void initState() {
    super.initState();
    streamController = StreamController<DrawerItemEnum>.broadcast(sync: true);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DrawerItemEnum>(
      stream: streamController.stream,
      initialData: DrawerItemEnum.ACCOUNT,
      builder: (context, snapshot) {
        selected = snapshot.data;
        return Container(
          color: Colors.blueGrey[900],
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getMenu(context, DrawerItemEnum.ACCOUNT),
                    _getMenu(context, DrawerItemEnum.SETTINGS),
                    _getMenu(context, DrawerItemEnum.LOGOUT),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _getMenu(BuildContext context, DrawerItemEnum menu) {
    switch (menu) {
      case DrawerItemEnum.ACCOUNT:
        return _buildItem(
            context, menu, "Account", Icons.account_box_sharp, () {});
      case DrawerItemEnum.LOGOUT:
        return _buildItem(context, menu, "Log out", Icons.logout, () {
          Provider.of<PageController>(context, listen: false).animateToPage(
            0,
            curve: Curves.ease,
            duration: Duration(seconds: 2),
          );
          Provider.of<PageVisible>(context, listen: false).setAll(false);
          // Navigator.of(context).pop();
        });
      case DrawerItemEnum.SETTINGS:
        return _buildItem(context, menu, "Settings", Icons.settings, () {});
      default:
        return Container();
    }
  }

  Widget _buildItem(
    BuildContext context,
    DrawerItemEnum menu,
    String title,
    IconData icon,
    Function onPressed,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          streamController.sink.add(menu);
          KTDrawerMenu.of(context).closeDrawer();
          onPressed();
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 26),
          child: Row(
            children: [
              Icon(icon,
                  color: selected == menu ? Colors.white : Colors.white70,
                  size: 24),
              SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: selected == menu ? 15 : 14,
                  fontWeight:
                      selected == menu ? FontWeight.w500 : FontWeight.w300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
