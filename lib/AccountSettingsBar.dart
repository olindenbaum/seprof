import 'package:flutter/material.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';

class AccountSettings extends StatelessWidget {
  final ThemeData themeData;
  String type;
  AccountSettings({this.themeData, this.type});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: this.themeData,
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(90.0),
              ),
              border:
                  Border.all(color: themeData.primaryColor.withOpacity(0.6))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Account Settings",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              )
            ],
          ),
        ),
        onTap: () {
          KTDrawerMenu.of(context).toggle();
        },
      ),
    );
  }
}
