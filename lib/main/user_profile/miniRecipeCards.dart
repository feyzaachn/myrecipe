import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/personal_recipe/personalRecipe.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MiniRecipeCards extends StatefulWidget {
  _MiniRecipeCardsState createState() => _MiniRecipeCardsState();
}

class _MiniRecipeCardsState extends State<MiniRecipeCards> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder(
        stream: getPost(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView(
              children: snapshot.data!.docs.map(
                    (Recipe) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(25),
                          child: GestureDetector(
                            onTap: () async{
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PersonalRecipe(PostId: Recipe.id,)));
                            },
                            child: Container(
                              height: 150,
                              width: 300,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(Recipe['Name'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.transparent,
                                          child: Image.network(
                                              Recipe['MainPhoto']),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            height: 70,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    DefaultTextStyle
                                                        .of(
                                                        context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: Recipe[
                                                          'ShortRecipe'])
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          FloatingActionButton(
                                            heroTag: null,
                                            onPressed: () {},
                                            child: Image.asset(
                                              "assets/icon/recipeIcon.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            mini: true,
                                            backgroundColor:
                                            Colors.transparent,
                                            elevation: 0,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                border:
                                Border.all(width: 1, color: Colors.cyan),
                                borderRadius: BorderRadius.circular(22),
                                color: const Color(0x53DDF8FF),
                              ),
                            ),
                          )),
                    ],
                  );
                },
              ).toList())
              : Container(
            color: Colors.white,
          );
        },
      ),
    );
  }

}

Stream<QuerySnapshot> getPost() async* {
  var _postSnapshot = FirebaseFirestore.instance
      .collection('Recipe')
      .doc(SharedPrefs.getUid)
      .collection('Recipes')
      .snapshots();
  yield* _postSnapshot;
}
