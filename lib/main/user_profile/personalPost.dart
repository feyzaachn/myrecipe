import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/main/user_profile/personalPostBody.dart';

class PersonalPost extends StatefulWidget {
  String? PostId;
  PersonalPost({Key? key, required this.PostId}) : super(key: key);
  @override
  _PersonalPostState createState() => _PersonalPostState(postId: PostId!);
}

class _PersonalPostState extends State<PersonalPost> {
  String postId;
  _PersonalPostState({required this.postId});
  Map<String, dynamic>? PostInfo;
  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance
          .collection('Recipe')
          .doc(SharedPrefs.getUid)
          .collection('Recipes')
          .doc(postId)
          .get()
          .then((DocumentSnapshot ds) {
          if(mounted) {
            setState(() {
            PostInfo = ds.data() as Map<String, dynamic>;
          });
          }
      });
    });
    if (PostInfo != null) {
      return PersonalPostBody(PostInfo);
    } else {
      return const SizedBox();
    }
  }
  @override
  void dispose(){
    super.dispose();
  }
}
