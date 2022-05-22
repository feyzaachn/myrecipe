import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/main/home_page/homePageBody.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/main/notebook/notebook.dart';
import 'package:myrecipe/main/search/searchPage.dart';
import 'package:myrecipe/main/user_profile/userProfile.dart';


class HomePage extends StatefulWidget {
  int position;
  HomePage({Key? key, required this.position}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(selectedPos: position);
}

List<TabItem> tabItems = List.of([
  TabItem(Icons.search, "Ara", Colors.lightGreen,
      labelStyle: const TextStyle(
          color: Colors.lightGreen, fontWeight: FontWeight.normal)),
  TabItem(Icons.home, "Anasayfa", Colors.deepPurple,
      labelStyle: const TextStyle(
          color: Colors.deepPurple, fontWeight: FontWeight.bold)),
  TabItem(Icons.book_outlined, "Defter", Colors.red,
      labelStyle:
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  TabItem(Icons.person, "Profil", Colors.cyan,
      labelStyle:
          const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
]);

class _HomePageState extends State<HomePage> {
  Map<String?, dynamic>? profileInfo;
  int selectedPos;
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
        if (mounted) {
          setState(() {
            profileInfo = ds.data() as Map<String, dynamic>?;
          });
        }
      });
    });
    bodyContainer();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Padding(
              child: selectedWidget,
              padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomNav()),
          ],
        ),
      ),
    );
  }

  Widget? selectedWidget;

  void bodyContainer() {
    Color selectedColor = tabItems[selectedPos].circleColor;
    setState(() {
      if (profileInfo != null) {
        switch (selectedPos) {
          case 0:
            selectedWidget = SearchPage();
            break;
          case 1:
            selectedWidget = HomePageBody(context, profileInfo!);
            break;
          case 2:
            selectedWidget = Notebook();
            break;
          case 3:
            selectedWidget = userProfileBody(context, profileInfo!);
            break;
          default:
            selectedWidget = Container(
              width: double.infinity,
              height: double.infinity,
              color: selectedColor,
            );
            break;
        }
      }
    });
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (selectedPos) {
        setState(() {
          this.selectedPos = selectedPos!;
          bodyContainer();
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController!.dispose();
  }
}
