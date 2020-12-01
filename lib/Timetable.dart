import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:seprof/Vars.dart';
import 'package:simple_timetable/simple_timetable.dart';

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
  DateTime now = DateTime.now();
  List<Event<String>> _events;

  TimetablePage() {
    for (int i = 0; i < 6; i++) addRandomEvent();
  }

  void addRandomEvent() {
    if (_events == null) _events = new List<Event<String>>();
    DateTime dt = DateTime(now.year, now.month,
        now.day + Random().nextInt(4) + 1, Random().nextInt(8) + 9);
    Event e = new Event<String>(
      id: 'Parcel ${Random().nextInt(41824).toRadixString(16).toUpperCase()}',
      date: DateTime.now().add(
        Duration(
          days: Random().nextInt(4) + 1,
        ),
      ),
      start: dt,
      end: dt.add(Duration(hours: 2)),
    );
    _events.add(e);
  }
}

class _TimetablePageState extends State<TimetablePage> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 10)).then((s) => setState(() {}));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: coordinatorTheme,
      child: Builder(
        builder: (context) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() => this.widget.addRandomEvent());
            },
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SimpleTimetable(
                    colorTimeline: Theme.of(context).primaryColor,
                    horizontalIndent: 0,
                    onChange: (DateTime date, TimetableDirection dir,
                        List<DateTime> largs) {},
                    initialDate: DateTime.now(),
                    dayStart: 9,
                    dayEnd: 20,
                    events: widget._events,
                    visibleRange: 5,
                    buildCard: (Event event, bool isPast) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.blue.withOpacity(0.3),
                          ),
                          child: Column(
                            children: [
                              AutoSizeText(
                                event.id,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
