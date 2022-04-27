import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? recipe;
    String a = "";
    final _key = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(size: 25, color: Colors.white),
          backgroundColor: Colors.red,
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Başlık
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    onChanged: (enteredName) {
                      recipe!["Name"] = enteredName;
                    },
                    decoration: const InputDecoration(
                      labelText: "Başlık",
                      labelStyle: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
