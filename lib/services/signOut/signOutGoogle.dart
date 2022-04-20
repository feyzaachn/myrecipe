import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signOutGoogle({required BuildContext context}) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text("Çıkış yapılamadı!"),
          content: Text("Lütfen tekrar deneyiniz."),
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
  }
}
