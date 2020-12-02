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

class ViewShiftPage extends StatelessWidget {
  final String type;
  const ViewShiftPage(this.type, this.theme);
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
                body: ViewShiftPageContents(type: this.type),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewShiftPageContents extends StatefulWidget {
  final String type;

  ViewShiftPageContents({Key key, this.type}) : super(key: key);

  @override
  _ViewShiftPageContentsState createState() => _ViewShiftPageContentsState();
}

class _ViewShiftPageContentsState extends State<ViewShiftPageContents> {
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
      result = r.nextInt(3);
      if (result == 0) {
        streamData.add("lt24_shift");
      } else {
        streamData.add("n_shift");
      }
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
    if (item == "lt24_shift")
      return SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: LT24_Shift(),
      );
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: ShiftBuilder(
        removeShiftFromStream: this.removeShiftFromStream,
      ),
    );
  }

  Widget _createRemovedShiftTile(
    String item,
    Animation<double> animation,
  ) {
    if (item == "lt24_shift")
      return SizeTransition(
          axis: Axis.vertical, sizeFactor: animation, child: LT24_Shift());
    return SizeTransition(
        axis: Axis.vertical, sizeFactor: animation, child: ShiftBuilder());
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
                            child: widget.type == "packer"
                                ? SvgPicture.asset(
                                    "assets/undraw/packer.svg",
                                  )
                                : SvgPicture.asset(
                                    "assets/undraw/driver.svg",
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
            Container(
                child: AccountPageOptionButton(
                  reverse: true,
                  icon: Icons.no_encryption,
                  text: "My Shifts",
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

class ShiftBuilder extends StatelessWidget {
  final Function removeShiftFromStream;
  const ShiftBuilder({
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
        text: "Shift",
        icon: Icons.close,
        onPressed: () {
          removeShiftFromStream("n_shift");
        },
      ),
    );
  }
}

class LT24_Shift extends StatelessWidget {
  const LT24_Shift({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: AccountPageOptionButton(
        textPadding: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(6),
        text: "Upcoming Shift",
        icon: FontAwesomeIcons.hourglassHalf,
        onPressed: null,
      ),
    );
  }
}
