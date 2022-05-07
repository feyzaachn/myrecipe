import 'package:flutter/material.dart';

Widget PersonalPostBody(PostInfo){
  final _key = GlobalKey<FormState>();
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 25, color: Colors.white),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Başlık
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  color: Colors.pink,
                  child: Text(PostInfo!['Name']),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}