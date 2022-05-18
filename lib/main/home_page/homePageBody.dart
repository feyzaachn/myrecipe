import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/recipe_page/recipePage.dart';
import 'package:myrecipe/main/home_page/recipeCards.dart';
import 'package:myrecipe/main/mainPage.dart';

Widget HomePageBody(BuildContext context,Map<String?, dynamic> ProfileInfo) {
  return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "𝒯𝒶𝓇𝒾𝒻𝒾𝓂",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(position: 1)));
                        },
                        icon: const Icon(Icons.loop,size: 25,),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipePage(profileInfo: ProfileInfo,)));
                        },
                        child: Image.asset(
                          "assets/icon/postIcon.png",
                          alignment: Alignment.center,
                          height: 25,
                        ),
                        mini: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(height: 5,color: Colors.purple,),
            Column(
              children: [
                RecipeCards(),
              ],
            ),
          ],
        ),
      ));
}
