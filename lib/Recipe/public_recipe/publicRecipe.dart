import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/public_recipe/publicRecipeBody.dart';

class PublicRecipe extends StatefulWidget {
  Map<String, dynamic> PostInfo;
  String PostId,UserId;
  PublicRecipe({required this.PostInfo, required this.PostId,required this.UserId});
  _PublicRecipeState createState() =>
      _PublicRecipeState(PostId: PostId, PostInfo: PostInfo,UserId: UserId);
}

class _PublicRecipeState extends State<PublicRecipe> {
  Map<String, dynamic> PostInfo;
  String PostId,UserId;
  _PublicRecipeState({required this.PostInfo, required this.PostId,required this.UserId});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(size: 25, color: Colors.white),
          backgroundColor: Colors.purple,
        ),
        body: PostInfo != null
            ? SingleChildScrollView(
                child: PublicRecipeBody(PostInfo: PostInfo,PostId: PostId,UserId: UserId,),
              )
            : Container(),
      ),
    );
  }
}
