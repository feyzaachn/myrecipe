import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/home_page/homePage.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

Future<void> loginUserWithMail(BuildContext context,Map<String,dynamic> User)async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: User['Mail'].toString(), password: User['Password'].toString())
        .then((user) {
      //başarılıysa
      SharedPrefs.saveMail(User['Mail'].toString().toString());
      SharedPrefs.savePassword(User['Password'].toString());
      SharedPrefs.saveUid(FirebaseAuth.instance.currentUser!.uid.toString());
      SharedPrefs.login();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage(position: 0,)),
              (route) => false);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text("Giriş yapılamadı!"),
            content: Text("Lütfen bilgilerinizi kontrol edip tekrar deneyiniz."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tamam"),
              )
            ],
          );
        },
      );
    });
}