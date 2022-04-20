import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void createUserProfile(Map<String?,dynamic> User){
  CollectionReference users =
  FirebaseFirestore.instance.collection('UserProfile');
  users
      .doc(FirebaseAuth.instance.currentUser!.uid
      .toString())
      .set({
    'Name': User['name'].toString(), // John Doe
    'Mail': User['mail'].toString(), // Stokes and Sons
    'Password': User['password'].toString(),
    'ProfilePhoto': User['ProfilePhoto'].toString(),
    'InformationText':"Profilime hoşgeldiniz.",
    'facebookInfo':"",
    'instagramInfo':"",
    'twitterInfo':"",
    'youtubeInfo':"",
    'phoneNumber':"",
    'signupType':User['signupType']
    // 42
  });
}