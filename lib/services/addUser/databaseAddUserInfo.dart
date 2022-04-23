import 'package:cloud_firestore/cloud_firestore.dart';

void addUserDatabase(Map<String?,dynamic> User){
  FirebaseFirestore.instance
      .collection('Users')
      .doc(User['Uid'].toString())
      .get().then((DocumentSnapshot ds){
    if(ds.exists){
      print("mevcut");
    }
    else{
      CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
      users
          .doc(User['Uid'].toString())
          .set({
        'Uid':User['Uid'].toString(),
        'Name': User['Name'].toString(), // John Doe
        'Mail': User['Mail'].toString(), // Stokes and Sons
        'Password': User['Password'].toString()// 42
      });
    }
  });
}