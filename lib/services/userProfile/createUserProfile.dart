import 'package:cloud_firestore/cloud_firestore.dart';

void createUserProfile(Map<String?, dynamic> User) {
  FirebaseFirestore.instance
      .collection('UserProfile')
      .doc(User['Uid'].toString())
      .get()
      .then((DocumentSnapshot ds) {
    if (ds.exists) {
      print("mevcut");
    } else {
      CollectionReference users =
          FirebaseFirestore.instance.collection('UserProfile');
      users.doc(User['Uid'].toString()).set({
        'Uid':User['Uid'].toString(),
        'Name': User['Name'] != null ? User['Name'].toString() : "",
        'Mail': User['Mail'] != null ? User['Mail'].toString() : "",
        'Password': User['Password'] != null ? User['Password'].toString() : "",
        'ProfilePhoto':
            User['ProfilePhoto'] != null ? User['ProfilePhoto'].toString() : null.toString(),
        'InformationText': User['InformationText'] != null
            ? User['InformationText'].toString()
            : "Profilime Hoşgeldiniz.",
        'facebookInfo':
            User['facebookInfo'] != null ? User['facebookInfo'].toString() : "",
        'instagramInfo': User['instagramInfo'] != null
            ? User['instagramInfo'].toString()
            : "",
        'twitterInfo':
            User['twitterInfo'] != null ? User['twitterInfo'].toString() : "",
        'youtubeInfo':
            User['youtubeInfo'] != null ? User['youtubeInfo'].toString() : "",
        'phoneNumber':
            User['phoneNumber'] != null ? User['phoneNumber'].toString() : "",
        'signupType':
            User['signupType'] != null ? User['signupType'].toString() : "",
      });
    }
  });
}

void updateUserProfile(Map<String?, dynamic> User) {
  CollectionReference users =
      FirebaseFirestore.instance.collection('UserProfile');
  users.doc(User['Uid'].toString()).set({
    'Uid':User['Uid'].toString(),
    'Name': User['Name'] != null ? User['Name'].toString() : "",
    'Mail': User['Mail'] != null ? User['Mail'].toString() : "",
    'Password': User['Password'] != null ? User['Password'].toString() : "",
    'ProfilePhoto':
    User['ProfilePhoto'] != null ? User['ProfilePhoto'].toString() : null.toString(),
    'InformationText': User['InformationText'] != null
        ? User['InformationText'].toString()
        : "Profilime Hoşgeldiniz.",
    'facebookInfo':
        User['facebookInfo'] != null ? User['facebookInfo'].toString() : "",
    'instagramInfo':
        User['instagramInfo'] != null ? User['instagramInfo'].toString() : "",
    'twitterInfo':
        User['twitterInfo'] != null ? User['twitterInfo'].toString() : "",
    'youtubeInfo':
        User['youtubeInfo'] != null ? User['youtubeInfo'].toString() : "",
    'phoneNumber':
        User['phoneNumber'] != null ? User['phoneNumber'].toString() : "",
    'signupType':
        User['signupType'] != null ? User['signupType'].toString() : "",
  });
}
