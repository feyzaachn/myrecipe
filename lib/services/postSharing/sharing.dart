import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

Future<void> Sharing (Map<String?, dynamic> PostInfo)async {
  CollectionReference post = FirebaseFirestore.instance.collection("Recipe");
  post.doc(SharedPrefs.getUid).collection('Recipes').doc()
  .set({
    'Name': PostInfo['Name'],
    'MainPhoto': PostInfo['MainPhoto'],
    'ShortRecipe': PostInfo['ShortRecipe'],
    'LongRecipe': PostInfo['LongRecipe'],
    'PostNumber': PostInfo['PostNumber'],
    'Materials': PostInfo['Materials'],
    'PhotoRecipe': PostInfo['PhotoRecipe'],
    'VideoRecipe': PostInfo['VideoRecipe'],
    'Category':PostInfo['Category'],
  });
}

Future<void> Update (Map<String?, dynamic> PostInfo,String Id)async {
  CollectionReference post = FirebaseFirestore.instance.collection("Recipe");
  post.doc(SharedPrefs.getUid).collection('Recipes').doc(Id)
      .set({
    'Name': PostInfo['Name'],
    'MainPhoto': PostInfo['MainPhoto'],
    'ShortRecipe': PostInfo['ShortRecipe'],
    'LongRecipe': PostInfo['LongRecipe'],
    'PostNumber': PostInfo['PostNumber'],
    'Materials': PostInfo['Materials'],
    'PhotoRecipe': PostInfo['PhotoRecipe'],
    'VideoRecipe': PostInfo['VideoRecipe'],
    'Category':PostInfo['Category'],
  });
}