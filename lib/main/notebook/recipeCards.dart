import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/public_recipe/publicRecipe.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

class RecipeCards extends StatefulWidget {
  const RecipeCards({Key? key}) : super(key: key);

  @override
  _RecipeCardsState createState() => _RecipeCardsState();
}

class _RecipeCardsState extends State<RecipeCards> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('InTheNotebook').doc(SharedPrefs.getUid).collection('Recipes').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? Wrap(
            children: snapshot.data!.docs.map(
                  (InTheNotebook) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Recipe')
                      .doc(InTheNotebook.get('RecipeUserId').toString())
                      .collection('Recipes')
                      .doc(InTheNotebook.get('RecipePostId').toString()).snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    return snapshot.data !=null
                        ? Wrap(
                        children: [
                       Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(25),
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PublicRecipe(
                                              PostInfo:
                                              snapshot.data!.data()
                                              as Map<String,
                                                  dynamic>,
                                              PostId: InTheNotebook['RecipePostId'],
                                              UserId: InTheNotebook['RecipeUserId'],
                                            )));
                              },
                              child: Container(
                                height: 150,
                                width: 350,
                                child: Column(children: [
                                  //name
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            3.0),
                                        child: Text(snapshot.data!['Name'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            10),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.transparent,
                                          child: Image.network(
                                              snapshot.data!['MainPhoto']),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 220,
                                            height: 70,
                                            child: Align(
                                              alignment: Alignment
                                                  .centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                        context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot.data![
                                                          'ShortRecipe'])
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ]),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.red),
                                  borderRadius:
                                  BorderRadius.circular(22),
                                  color: const Color(0x13F44336),
                                ),
                              ),
                            )),
                      ],
                    )
                        ].toList())
                        : Container(
                      color: Colors.white,
                    );
                  },
                );
              },
            ).toList())
            : Container(
          color: Colors.white,
        );
      },
    );
  }
}