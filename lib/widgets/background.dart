import 'package:flutter/cupertino.dart';

Widget Background() {
  return Container(
    height: 300,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/backgrounds/loginBackground.png"),
            fit: BoxFit.fill)),
  );
}
