

import 'package:flutter/material.dart';

class ProfileEditing extends StatefulWidget{
  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditing>{
  Widget build (BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("data")
            ],
          ),
        )
      ),
    );
  }
}