import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main/mainPage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  Map<String?,dynamic>? profileInfo;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () async {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(position: 3)));
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
              "Değişiklikler Kaydediliyor",
            ),
          ],
        ),
      ),
    );
  }
}
