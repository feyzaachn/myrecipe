import 'package:flutter/material.dart';
import 'package:myrecipe/main/search/searchPageBody.dart';


Widget SearchPage() {
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Tarif Sihirbazı",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.search_sharp,
                  size: 25,
                  color: Colors.lightGreen,
                )
              ],
            ),
          ),
          SearchPageBody()
        ],
      ),
    ),

  );

}


