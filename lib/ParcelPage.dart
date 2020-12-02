import 'dart:async';
import 'dart:math';
import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:seprof/AccountSettingsBar.dart';
import 'package:seprof/Drawer.dart';
import 'package:seprof/Vars.dart';

class ParcelPage extends StatelessWidget {
  final String type;
  const ParcelPage(this.type, this.theme);
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
                body: ParcelPageContents(type: this.type),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ParcelPageContents extends StatefulWidget {
  final String type;

  ParcelPageContents({Key key, this.type}) : super(key: key);

  @override
  _ParcelPageContentsState createState() => _ParcelPageContentsState();
}

class _ParcelPageContentsState extends State<ParcelPageContents> {
  List<String> streamData = [];
  Stream<List<String>> list;
  final StreamController<List<String>> _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    list = _streamController.stream;
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addShiftsToStream();
  }

  void addShiftsToStream() async {
    int i = 12;
    int result = 0;
    Random r = Random();
    while (this.list != null && i > 0) {
      streamData.add("n_shift");
      i--;
      streamData.sort((x, y) => y.length.compareTo(x.length));
      await Future.delayed(Duration(milliseconds: 100))
          .then((value) => this._streamController.add(streamData));
    }
  }

  void removeShiftFromStream(String item) {
    streamData.remove(item);
    this._streamController.add(streamData);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Widget _createShiftTile(String item, Animation<double> animation, int index) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: ParcelBuilder(
        removeShiftFromStream: this.removeShiftFromStream,
      ),
    );
  }

  Widget _createRemovedShiftTile(
    String item,
    Animation<double> animation,
  ) {
    return SizeTransition(
        axis: Axis.vertical, sizeFactor: animation, child: ParcelBuilder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        child: Column(
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
                          child: Container(
                              width: 110,
                              height: 110,
                              child: SvgPicture.asset(
                                "assets/undraw/coordinator.svg",
                              )),
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
            Container(
                child: AccountPageOptionButton(
                  reverse: true,
                  icon: Icons.no_encryption,
                  text: "Parcels",
                  onPressed: null,
                  textPadding: const EdgeInsets.only(left: 120),
                ),
                height: 80),
            Container(
              padding: const EdgeInsets.only(left: 30),
              height: MediaQuery.of(context).size.height * 0.89 - 16 - 60 - 80,
              child: Center(
                child: SingleChildScrollView(
                  child: AnimatedStreamList<String>(
                    scrollPhysics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    streamList: list,
                    itemBuilder: (String item, int index, BuildContext context,
                            Animation<double> animation) =>
                        _createShiftTile(item, animation, index),
                    itemRemovedBuilder: (String item,
                            int index,
                            BuildContext context,
                            Animation<double> animation) =>
                        _createRemovedShiftTile(item, animation),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParcelBuilder extends StatelessWidget {
  final Function removeShiftFromStream;
  const ParcelBuilder({
    Key key,
    this.removeShiftFromStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: AccountPageOptionButton(
        textPadding: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(6),
        text:
            "Parcel ${Random().nextInt(41824).toRadixString(16).toUpperCase()}",
        icon: FontAwesomeIcons.gift,
      ),
    );
  }
}
