import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimer(context);
  }

  void startTimer(BuildContext context) {
    Future.delayed(Duration(seconds: 3))
        .then((value) => Navigator.of(context).pushReplacementNamed("/"));
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottie/delivery.json');
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE29578),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<LottieComposition>(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) {
            return Lottie(composition: composition);
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF006D77),
              ),
            ));
          }
        },
      ),
    );
  }
}
