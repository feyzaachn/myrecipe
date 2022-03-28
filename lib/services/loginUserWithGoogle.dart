import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myrecipe/home_page/homePage.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/databaseAddUserInfo.dart';

Future<void> userLoginWithGoogle(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;
    Map<String?,dynamic> Users =({'name': user!.displayName.toString(),'mail': user.email.toString()});

    if (result != null) {
      SharedPrefs.saveMail(user.email.toString());
      SharedPrefs.login();
      addUserDatabase(Users);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(user.email.toString(), user.uid.toString())));
    } //MaterialpageRoute,

  }
}