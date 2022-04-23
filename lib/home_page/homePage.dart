import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/home_page/user_profile/userProfile.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

class HomePage extends StatefulWidget {
  int position;
  HomePage({Key? key, required this.position}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(selectedPos: position);
}

List<TabItem> tabItems = List.of([
  TabItem(Icons.search, "Ara", Colors.blue,
      labelStyle: const TextStyle(fontWeight: FontWeight.normal)),
  TabItem(Icons.home, "Anasayfa", Colors.orange,
      labelStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  TabItem(Icons.book_outlined, "Defter", Colors.red),
  TabItem(Icons.person, "Profil", Colors.cyan),
]);

class _HomePageState extends State<HomePage> {

  Map<String?,dynamic>? profileInfo;
  int selectedPos ;
  _HomePageState({required this.selectedPos});

  double bottomNavBarHeight = 50;
  CircularBottomNavigationController? _navigationController;
  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(SharedPrefs.getUid)
          .get()
          .then((DocumentSnapshot ds) {
        setState(() {
          profileInfo = ds.data() as Map<String, dynamic>?;
        });
      });
    });
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              child: bodyContainer(),
              padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomNav()),
          ],
        ),
      ),
    );
  }
  Widget bodyContainer() {
    Color selectedColor = tabItems[selectedPos].circleColor;
    String? selectedPage;
    switch (selectedPos) {
      case 0:
        selectedPage = "Ara";
        break;
      case 1:
        selectedPage = "Anasayfa";
        break;
      case 2:
        selectedPage = "Defter";
        break;
      case 3:
        selectedPage = "Profil";
        break;
    }
    return GestureDetector(
      child: Page(selectedColor, selectedPos),
    );
  }
  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos!;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController!.dispose();
  }


  Widget Page(Color selectedColor, int position) {
    if (position == 3&& profileInfo != null) {
      return userProfileBody(context,profileInfo!);
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: selectedColor,
      );
    }
  }

  }

