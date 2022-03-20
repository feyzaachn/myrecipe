import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/services/databaseAddUserInfo.dart';

void addUser(BuildContext context,Map<String,dynamic> Useradd) {
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: Useradd['mail'].toString(),
      password: Useradd['password'].toString()).then((user) {
    //başarılıysa
    addUserDatabase(Useradd);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }).catchError((error) {
    //başarılı değilse
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text("Kayıt işlemi başarısız!"),
          content: Text("Bu mail adresine ait bir kulllanıcı bulunmaktadır."),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent)
              ),
              onPressed: (){
                Navigator.pop(context);
              }, child: Text("Tamam"),
            )
          ],
        );
      },);
  });

}