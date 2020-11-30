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

class PackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: packerTheme,
      child: Builder(
        builder: (context) {
          if (Provider.of<PageVisible>(context, listen: true).value["packer"] ==
              true) {
            return KTDrawerMenu(
              width: 150,
              drawer: DrawerPage(),
              content: Container(
                color: packerTheme.accentColor,
                child: SafeArea(
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: packerTheme.accentColor,
                    body: PackerPageContents(),
                  ),
                ),
              ),
            );
          } else {
            return FittedBox(
                fit: BoxFit.fill,
                child: Container(color: packerTheme.accentColor));
          }
        },
      ),
    );
  }
}

class PackerPageContents extends StatelessWidget {
  const PackerPageContents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: AccountSettings(themeData: packerTheme, type: "packer"),
          ),
        ),
        Container(height: 60),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AccountPageOptionButton(
                  icon: FontAwesomeIcons.calendarPlus,
                  text: "Book Shifts",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/bshift",
                        arguments: ShiftPageSettings(
                            "/bshift", "packer", packerTheme));
                  }),
              AccountPageOptionButton(
                  icon: FontAwesomeIcons.peopleCarry,
                  text: "My Shifts",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/vshift",
                        arguments: ShiftPageSettings(
                            "/vshift", "packer", packerTheme));
                  }),
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
                        builder: (context) => ParcelScanner("packer"));
                  }),
            ],
          ),
        ),
        Expanded(
          child: Hero(
            tag: "illustration",
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/undraw/packer.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
