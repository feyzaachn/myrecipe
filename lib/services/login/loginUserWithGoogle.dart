import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myrecipe/login/loginControl.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/userProfile/createUserProfile.dart';
import 'package:myrecipe/services/addUser/databaseAddUserInfo.dart';

Future<void> userLoginWithGoogle(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  print("deneme1:"+googleSignInAccount.toString());
  if (googleSignInAccount != null) {
    print("deneme2:"+googleSignInAccount.toString());
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;
    Map<String?,dynamic> Users =({
      'Name': user!.displayName.toString(),
      'Uid':user.uid,
      'Mail': user.email.toString(),
      'ProfilePhoto':user.photoURL,
      'phoneNumber':user.phoneNumber,
      'signupType':'google',
      'InformationText':"Profilime Hoşgeldiniz."
    });

    if (result != null) {
        SharedPrefs.saveUid(user.uid.toString());
        SharedPrefs.login();
        addUserDatabase(Users);
        createUserProfile(Users);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginControl()));

    } //MaterialpageRoute,

  }
}