import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:seprof/AccountSettingsBar.dart';
import 'package:seprof/Drawer.dart';
import 'package:seprof/Vars.dart';

class RoutePlannerPage extends StatelessWidget {
  final String type;
  const RoutePlannerPage(this.type, this.theme);
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: Builder(
        builder: (context) => KTDrawerMenu(
          width: 150,
          drawer: DrawerPage(),
          content: Container(
            color: Theme.of(context).accentColor,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Theme.of(context).accentColor,
                body: RoutePlannerPageContents(type: this.type),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoutePlannerPageContents extends StatefulWidget {
  final String type;

  RoutePlannerPageContents({Key key, this.type}) : super(key: key);

  @override
  _RoutePlannerPageContentsState createState() =>
      _RoutePlannerPageContentsState();
}

class _RoutePlannerPageContentsState extends State<RoutePlannerPageContents> {
  Random r;
  @override
  void initState() {
    super.initState();
    this.r = Random();
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Position> getPosition() async {
    bool perm = await Geolocator.isLocationServiceEnabled();
    if (perm == false) {
      await Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double randomOffset() {
    double res;
    res = r.nextInt(2) == 1 ? -r.nextDouble() * 0.01 : r.nextDouble() * 0.01;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Hero(
                      tag: "illustration",
                      child: Transform.translate(
                        offset: Offset(0, -20),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: widget.type == "packer"
                              ? SvgPicture.asset(
                                  "assets/undraw/packer.svg",
                                )
                              : SvgPicture.asset(
                                  "assets/undraw/driver.svg",
                                ),
                        ),
                      ),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: AccountSettings(
                      themeData: Theme.of(context), type: widget.type),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ClipPath(
              clipper: OvalTopBorderClipper(),
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  child: FutureBuilder<Position>(
                      future: getPosition(),
                      builder: (context, snap) {
                        if (!snap.hasData) {
                          return Center(
                              child: SpinKitChasingDots(
                                  color: Theme.of(context).primaryColor));
                        }
                        Position position = snap.data;
                        return FlutterMap(
                          options: new MapOptions(
                            center:
                                LatLng(position.latitude, position.longitude),
                            zoom: 14.5,
                          ),
                          layers: [
                            new TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']),
                            new MarkerLayerOptions(
                              markers: [
                                new Marker(
                                  width: 30.0,
                                  height: 30.0,
                                  point: LatLng(
                                      position.latitude, position.longitude),
                                  builder: (ctx) => new Container(
                                    child: new Icon(
                                        FontAwesomeIcons.locationArrow),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                                new Marker(
                                  width: 5.0,
                                  height: 5.0,
                                  point: LatLng(
                                      position.latitude + randomOffset(),
                                      position.longitude + randomOffset()),
                                  builder: (ctx) => new Container(
                                    child: new Icon(FontAwesomeIcons.mapMarker),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
        AccountPageOptionButton(
          icon: Icons.no_encryption,
          onPressed: null,
          text: "Generate Route",
          textPadding: const EdgeInsets.only(right: 20),
        )
      ],
    );
  }
}
