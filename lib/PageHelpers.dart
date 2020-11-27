import 'package:flutter/material.dart';

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class PageVisible extends ValueNotifier<Map<String, bool>> {
  PageVisible(Map<String, bool> value) : super(value);

  void setType(String type, bool to) {
    value[type] = to;
    notifyListeners();
  }

  void setAll(bool to) {
    value.map((key, value) => MapEntry(key, to));
  }
}
