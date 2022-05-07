import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main/mainPage.dart';

class Splash extends StatefulWidget {
  final int position;
  const Splash({Key? key,required this.position}) : super(key: key);

  @override
  _SplashState createState() => _SplashState(pos: this.position);
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  int pos;
  _SplashState({required this.pos});
  Map<String?,dynamic>? profileInfo;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () async {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(position: pos)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SpinKitChasingDots(
              color: Colors.black87,
              size: 50.0,
              duration: Duration(milliseconds: 1000),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "İşlem Tamamlanıyor..",
            ),
          ],
        ),
      ),
    );
  }
}
