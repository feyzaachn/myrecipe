import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/recipe_update/recipeUpdate.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/splashScreen.dart';
import 'package:myrecipe/videoPlayer.dart';
import 'package:video_player/video_player.dart';

Widget PersonalRecipeBody(context,Map<String, dynamic>? PostInfo,String id) {
  //final _key = GlobalKey<FormState>();
  List materials=PostInfo!['Materials'];
  List photos=PostInfo['PhotoRecipe'];
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
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
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
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
              children: <TextSpan>[
                TextSpan(text: PostInfo['ShortRecipe'])
              ]),
        ),
      ),
      //MalzemelerText
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("Malzemeler",style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 20),),
            Icon(Icons.style,color: Colors.cyan,)
          ],
        ),
      ),
      //Malzeme listesi
      Wrap(
        children: [
          for(int i=0;i<materials.length;i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 15),
              child: Row(
                children: [
                  const Icon(Icons.assistant,color: Colors.cyan,),
                  Text(materials[i],style: const TextStyle(fontSize: 15),)
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
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black
              ),
              children: <TextSpan>[
                TextSpan(text: PostInfo['LongRecipe'])
              ]),
        ),
      ),
      //Kategori
      Padding(padding: const EdgeInsets.all(10),
        child:RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black
              ),
              children: <TextSpan>[
                const TextSpan(text: "Kategori: ",style: TextStyle(color: Colors.cyan)),
                TextSpan(text: PostInfo['Category'])
              ]),
        ),
      ),
      //Fotoğraflar
      if(PostInfo["PhotoRecipe"]!=null)
        Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
          child:Column(
            children: [
              Row(
                children: const [
                  Text("Fotoğraflar",style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 20),),
                  Icon(Icons.photo_library,color: Colors.cyan,)
                ],
              ),
              Wrap(
                children: [
                  for(int i=0;i<photos.length;i++)
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width:300,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: Colors.black12,
                            image: DecorationImage(image: NetworkImage(photos[i]),fit: BoxFit.contain)
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      //Video
      if(PostInfo["VideoRecipe"]!=null)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Video",style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 20),),
                  Icon(Icons.video_collection,color: Colors.cyan,)
                ],
              ),
              Padding(padding: const EdgeInsets.all(5),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(5)),
                    color: Colors.black12,
                  ),
                  child: VideoItems(
                      videoPlayerController:
                      VideoPlayerController.network(PostInfo["VideoRecipe"])),
                ),
              ),
            ],
          ),
        ),
      const Divider(
        height: 2,
        color: Colors.cyan,
      ),
      //Butonlar
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
                onPressed:(){DeletedRecipe(context,id);},
                backgroundColor: Colors.cyan,
                child: const Icon(Icons.delete)
            ),
            FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Paylaşımınızı güncellemek istediğinize emin misiniz?"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.redAccent)),
                              child: const Text("İptal")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeUpdate(PostInfo, id)));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.redAccent)),
                              child: const Text("Güncelle")),
                        ],
                      ),
                    ],
                  );});
              },
              backgroundColor: Colors.cyan,
              child: const Icon(Icons.loop_outlined),)
          ],
        ),
      )
    ],
  );

}

Future<void> DeletedRecipe(context,String id) async {
  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      title: const Text("Paylaşımınızı silmek istediğinize emin misiniz?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(
                        Colors.redAccent)),
                child: const Text("İptal")),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('Recipe')
                      .doc(SharedPrefs.getUid)
                      .collection('Recipes')
                      .doc(id).delete();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Splash(position: 3)));
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(
                        Colors.redAccent)),
                child: const Text("Sil!")),
          ],
        ),
      ],
    );});
}