import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/services/userProfile/createUserProfile.dart';
import 'package:myrecipe/services/addUser/databaseAddUserInfo.dart';

void addUser(BuildContext context,Map<String,dynamic> Useradd) {
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: Useradd['Mail'].toString(),
      password: Useradd['Password'].toString()).then((user) {
    //başarılıysa
    Useradd['Uid']=FirebaseAuth.instance.currentUser!.uid.toString();
    addUserDatabase(Useradd);
    createUserProfile(Useradd);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }).catchError((error) {
    //başarılı değilse
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text("Kayıt işlemi başarısız!"),
          content: const Text("Bu mail adresine ait bir kulllanıcı bulunmaktadır."),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent)
              ),
              onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Tamam"),
            )
          ],
        );
      },);
  });

}