import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/main/mainPage.dart';

class LoginControl extends StatefulWidget {
  const LoginControl({Key? key}) : super(key: key);

  @override
  _LoginControlState createState() => _LoginControlState();
}

class _LoginControlState extends State<LoginControl> {

  Future pageRotate() async {
    Future.delayed(const Duration(seconds: 3), () {
      if (SharedPrefs.getLogin) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(position: 1,)));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  void initState() {
    pageRotate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:100,child: Image.asset("assets/icon/appIcon.png")),
            const SizedBox(
              height: 20,
            ),
            const SpinKitChasingDots(
              color: Colors.deepPurple,
              size: 30,
              duration: Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }
}