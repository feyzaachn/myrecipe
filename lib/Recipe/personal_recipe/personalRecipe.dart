import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/personal_recipe/personalRecipeBody.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

class PersonalRecipe extends StatefulWidget {
  String? PostId;
  PersonalRecipe({Key? key, required this.PostId}) : super(key: key);
  @override
  _PersonalRecipeState createState() => _PersonalRecipeState(postId: PostId!);
}

class _PersonalRecipeState extends State<PersonalRecipe> {
  String postId;
  _PersonalRecipeState({required this.postId});
  Map<String, dynamic>? PostInfo;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Recipe')
        .doc(SharedPrefs.getUid)
        .collection('Recipes')
        .doc(postId)
        .get()
        .then((DocumentSnapshot ds) {
      if (mounted) {
        setState(() {
          PostInfo = ds.data() as Map<String, dynamic>?;
        });
      }
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(size: 25, color: Colors.white),
          backgroundColor: Colors.cyan,
        ),
        body: PostInfo != null
            ? SingleChildScrollView(
          child: PersonalRecipeBody(context,PostInfo,postId),
        )
            : Container(),
      ),
    );
  }
}