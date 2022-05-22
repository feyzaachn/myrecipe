import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/videoPlayer.dart';
import 'package:video_player/video_player.dart';

class PublicRecipeBody extends StatefulWidget {
  Map<String, dynamic> PostInfo;
  String PostId, UserId;
  PublicRecipeBody(
      {required this.PostInfo, required this.PostId, required this.UserId});

  _PublicRecipeBodyState createState() => _PublicRecipeBodyState(
      PostInfo: PostInfo, PostId: PostId, UserId: UserId);
}

class _PublicRecipeBodyState extends State<PublicRecipeBody> {
  Map<String, dynamic> PostInfo;
  String PostId, UserId;
  _PublicRecipeBodyState(
      {required this.PostInfo, required this.PostId, required this.UserId});
  Color buttonColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    List materials = PostInfo['Materials'];
    List? photos = PostInfo['PhotoRecipe'];
    FirebaseFirestore.instance
        .collection('InTheNotebook')
        .doc(SharedPrefs.getUid)
        .collection('Recipes')
        .doc(PostId)
        .get()
        .then((DocumentSnapshot sd) {
      if (sd.exists) {
        if (mounted)
          setState(() {
            buttonColor = Colors.purple;
          });
      }
    });
    return Column(
      children: [
        //Başlık
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            child: Text(
              PostInfo['Name'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        //Ana fotoğraf
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.black12,
                image: DecorationImage(
                    image: NetworkImage(PostInfo['MainPhoto']),
                    fit: BoxFit.contain),
              ),
            )
          ],
        ),
        //Kısa tarif
        Padding(
          padding: const EdgeInsets.all(15),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(fontSize: 20, color: Colors.black),
                children: <TextSpan>[TextSpan(text: PostInfo['ShortRecipe'])]),
          ),
        ),
        //MalzemelerText
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Malzemeler",
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Icon(
                Icons.style,
                color: Colors.purple,
              )
            ],
          ),
        ),
        //Malzeme listesi
        Wrap(
          children: [
            for (int i = 0; i < materials.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.assistant,
                      color: Colors.purple,
                    ),
                    Text(
                      materials[i],
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
              )
          ],
        ),
        //Uzun Tarifi
        Padding(
          padding: const EdgeInsets.all(15),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: <TextSpan>[TextSpan(text: PostInfo['LongRecipe'])]),
          ),
        ),
        //Kategori
        Padding(
          padding: const EdgeInsets.all(10),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(
                      text: "Kategori: ",
                      style: TextStyle(color: Colors.purple)),
                  TextSpan(text: PostInfo['Category'])
                ]),
          ),
        ),
        //Fotoğraflar
        if (PostInfo["PhotoRecipe"] != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "Fotoğraflar",
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Icon(
                      Icons.photo_library,
                      color: Colors.purple,
                    )
                  ],
                ),

                Wrap(
                  children: [
                    for (int i = 0; i < photos!.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.black12,
                              image: DecorationImage(
                                  image: NetworkImage(photos[i]),
                                  fit: BoxFit.contain)),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        //Video
        if (PostInfo["VideoRecipe"] != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "Video",
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Icon(
                      Icons.video_collection,
                      color: Colors.purple,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black12,
                    ),
                    child: VideoItems(
                        videoPlayerController: VideoPlayerController.network(
                            PostInfo["VideoRecipe"])),
                  ),
                ),
              ],
            ),
          ),
        const Divider(
          height: 5,
        ),
        //Buton
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  if (buttonColor == Colors.transparent) {
                    NoteDown(UserId, PostId);
                    setState(() {
                      buttonColor = Colors.purple;
                    });
                  } else {
                    NoteDownDelete(UserId, PostId);
                    setState(() {
                      buttonColor = Colors.transparent;
                    });
                  }
                },
                child: Image.asset(
                  "assets/icon/recipeIcon.png",
                  height: 50,
                  width: 50,
                ),
                backgroundColor: buttonColor,
                elevation: 0,
              ),
              Text(
                buttonColor == Colors.transparent
                    ? "Defterime Kaydet"
                    : "Defterimde Kayıtlı",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}

Future<void> NoteDown(String userId, String postId) async {
  CollectionReference post =
      FirebaseFirestore.instance.collection('InTheNotebook');
  post
      .doc(SharedPrefs.getUid)
      .collection('Recipes')
      .doc(postId)
      .set({'RecipeUserId': userId, 'RecipePostId': postId});
}

Future<void> NoteDownDelete(String userId, String postId) async {
  CollectionReference post =
      FirebaseFirestore.instance.collection('InTheNotebook');
  await post.doc(SharedPrefs.getUid).collection('Recipes').doc(postId).delete();
}
