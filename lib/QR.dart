import 'dart:math';

import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';
import 'package:animated_qr_code_scanner/animated_qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';

class ParcelScanner extends StatelessWidget {
  ParcelScanner(this.type);
  final AnimatedQRViewController controller = AnimatedQRViewController();
  final String type;

  Future<dynamic> showDriverDialog(BuildContext context, String scan) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Tag Scanned!\nAdd to route?", textAlign: TextAlign.center),
        actions: [
          FlatButton(
            child: Text('OK',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Rescan',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.of(context).pop();
              controller.resume();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> showPackerDialog(BuildContext context, String scan) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "Tag Scanned!\nView Tag?",
          textAlign: TextAlign.center,
        ),
        actions: [
          FlatButton(
            child: Text('Yes',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScannedParcelPage(data: scan),
                ),
              );
            },
          ),
          FlatButton(
            child: Text('Rescan',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.of(context).pop();
              controller.resume();
            },
          ),
        ],
      ),
    );
  }

  Future<bool> requestCamera() {
    return Permission.camera.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: [
          FutureBuilder(
              future: requestCamera(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: SpinKitDualRing(
                          color: Theme.of(context).primaryColor));
                }
                return Expanded(
                  child: AnimatedQRView(
                    squareColor: Colors.green.withOpacity(0.25),
                    animationDuration: const Duration(milliseconds: 400),
                    onScanBeforeAnimation: (String str) {},
                    onScan: (String str) async {
                      if (type == "driver") {
                        await this.showDriverDialog(context, str);
                      } else if (type == "packer") {
                        await this.showPackerDialog(context, str);
                      } else {
                        ;
                      }
                    },
                    controller: controller,
                  ),
                );
              }),
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Flash'),
                  onPressed: () {
                    controller.toggleFlash();
                  },
                ),
                const SizedBox(width: 10),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Flip'),
                  onPressed: () {
                    controller.flipCamera();
                  },
                ),
                const SizedBox(width: 10),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Resume'),
                  onPressed: () {
                    controller.resume();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannedParcelPage extends StatelessWidget {
  final String data;
  const ScannedParcelPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tag ID : ${Random().nextInt(41824).toRadixString(16).toUpperCase()}\nPeople in household: ${Random().nextInt(5)}\nNotes: None",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
