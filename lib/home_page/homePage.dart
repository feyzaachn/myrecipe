import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myrecipe/home_page/userProfile.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  HomePage(String? getMail, String? getUid);
  _HomePageState createState() => _HomePageState();
}

List<TabItem> tabItems = List.of([
  new TabItem(Icons.search, "Ara", Colors.blue,
      labelStyle: TextStyle(fontWeight: FontWeight.normal)),
  new TabItem(Icons.home, "Anasayfa", Colors.orange,
      labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  new TabItem(Icons.book_outlined, "Defter", Colors.red),
  new TabItem(Icons.person, "Profil", Colors.cyan),
]);

class _HomePageState extends State<HomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 50;

  CircularBottomNavigationController? _navigationController;
  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
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
        userProfileBody();
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
      animationDuration: Duration(milliseconds: 300),
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
}

Widget Page(Color selectedColor, int position) {
  if (position == 3) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //2 button
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      )),
                    ),
                    child: Text("Profili düzenle"),
                  )
                ],
              ),
            ),
            //Image
            Container(
              width: double.infinity,
              height: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white,
                        border: Border.all(color: Colors.cyan, width: 3),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/profileImage/default_profile_image.jpg"))),
                    height: 170,
                    width: 170,
                    padding: EdgeInsets.all(0),
                  )
                ],
              ),
            ),
            //İsim
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Feyza Cihan",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                )
              ],
            ),
            //Hakkımda
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                    border: Border.all(color: Colors.cyan, width: 1),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Profilime hoşgeldiniz.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            //İletişim
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Column(
                children: [
                  //E-mail
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/icon/email.png"),
                          backgroundColor: Colors.transparent,
                          mini: true,
                        ),
                        Text("feyzaa.chn@gmail.com",style: TextStyle(fontSize: 10),),
                      ],
                    ),
                  ),
                  //Telefon
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/icon/phone.png"),
                          backgroundColor: Colors.transparent,
                          mini: true,
                        ),
                        Text("05418638103",style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  //instagram
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/icon/instagram.png"),
                          backgroundColor: Colors.transparent,
                          mini: true,
                        ),
                        Text("feyzaachn",style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  //twitter
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/icon/twitter.png"),
                          backgroundColor: Colors.transparent,
                          mini: true,
                        ),
                        Text("feyzaachn",style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  //facebook
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/icon/facebook.png"),
                          backgroundColor: Colors.transparent,
                          mini: true,
                        ),
                        Text("feyzaachn",style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  //youtube
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/icon/youtube.png"),
                          backgroundColor: Colors.transparent,
                          mini: true,
                        ),
                        Text("Feyza Cihan",style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 20,),
            Text("Tariflerim"),
            Divider(height: 3,color: Colors.cyan,),
          ],
        ),
      ),
    );
  } else {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: selectedColor,
    );
  }
}
