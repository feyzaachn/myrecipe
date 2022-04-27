import 'package:flutter/material.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/main/mainPage.dart';

class LoginControl extends StatefulWidget {
  @override
  _LoginControlState createState() => _LoginControlState();
}

class _LoginControlState extends State<LoginControl> {

  Future pageRotate() async {
    Future.delayed(Duration(seconds: 3), () {
      if (SharedPrefs.getLogin) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(position: 1,)));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
    return Container(
      color: Colors.blueGrey.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 150,
              width: 200,
              child: Image.asset(
                "assets/icon/google.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}