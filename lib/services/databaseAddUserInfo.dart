import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addUserDatabase(Map<String?,dynamic> User){
  CollectionReference users =
  FirebaseFirestore.instance.collection('Users');
  users
      .doc(FirebaseAuth.instance.currentUser!.uid
      .toString())
      .set({
    'uid':
    FirebaseAuth.instance.currentUser!.uid.toString(),
    'Name': User['name'].toString(), // John Doe
    'Mail': User['mail'].toString(), // Stokes and Sons
    'Password': User['password'].toString()// 42
  });
}