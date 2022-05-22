import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/public_recipe/publicRecipe.dart';

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({Key? key}) : super(key: key);

  @override
  _SearchPageBodyState createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  String? enteredRecipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            onChanged: (entered) {
              setState(() {
                enteredRecipe = entered;
              });
            },
            cursorColor: Colors.blueGrey,
            //texti gizlemed
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  // text kutusuna tıklanmadan önce
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 0.5)),
              labelText: "Tarif Ara",
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.blueGrey,
                size: 25,
              ),
              focusedBorder: OutlineInputBorder(
                  //Text kutusuna tıklandıktan sonra
                  borderSide: const BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? Wrap(
                    children: snapshot.data!.docs.map(
                    (Users) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Recipe')
                            .doc(Users.id)
                            .collection('Recipes')
                            .orderBy('Name')
                            .startAt([enteredRecipe]).endAt([
                          enteredRecipe.toString() + '\uf8ff'
                        ]).snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return snapshot.hasData
                              ? Wrap(
                                  children: snapshot.data!.docs.map(
                                  (Recipe) {
                                    return Row(
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
                                                              PostInfo: Recipe
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>,
                                                              PostId: Recipe.id,
                                                              UserId: Users.id,
                                                            )));
                                              },
                                              child: Container(
                                                height: 150,
                                                width: 350,
                                                child: Column(children: [
                                                  //name
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Text(
                                                            Recipe['Name'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15)),
                                                      ),
                                                    ],
                                                  ),
                                                  //Kapak fotoğrafı
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Container(
                                                          height: 100,
                                                          width: 100,
                                                          color: Colors
                                                              .transparent,
                                                          child: Image.network(
                                                              Recipe[
                                                                  'MainPhoto']),
                                                        ),
                                                      ),
                                                      //kısaca tarif
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
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
                                                                          text:
                                                                              Recipe['ShortRecipe'])
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
                                                      color: Colors.lightGreen),
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  color:
                                                      const Color(0x1F91F691),
                                                ),
                                              ),
                                            )),
                                      ],
                                    );
                                  },
                                ).toList())
                              : Container();
                        },
                      );
                    },
                  ).toList())
                : Container();
          },
        )
      ],
    );
  }
}
