import 'package:flutter/material.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/signOutGoogle.dart';

class HomePage extends StatelessWidget{
  HomePage(String? getMail, String? getUid);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Anasayfa")),
          body: ElevatedButton(child: null,
            onPressed: (){
              signOutGoogle(context: context);
              SharedPrefs.sharedClear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (_) => false);
            },
          ),
    );
  }
}