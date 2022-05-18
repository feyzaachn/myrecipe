import 'package:flutter/material.dart';
import 'package:myrecipe/main/notebook/recipeCards.dart';

Widget Notebook(){
  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        children: [
          RecipeCards()
        ],
      ),
    ),
  );
}
