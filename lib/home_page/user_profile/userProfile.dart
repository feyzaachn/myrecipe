import 'package:flutter/material.dart';
import 'package:myrecipe/home_page/user_profile/profile_editing/profileEditingPage.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/signOut/signOutGoogle.dart';
import '../../login/loginPage.dart';

Widget userProfileBody(
    BuildContext context, Map<String?, dynamic> ProfileInfo) {
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
                  onPressed: () {
                    signOutGoogle(context: context);
                    SharedPrefs.sharedClear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (_) => false);
                  },
                  heroTag: "fab1",
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditing(ProfileInfo)));

                  },
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
                          fit: BoxFit.cover, image: ProfilePhoto(ProfileInfo))),
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
                ProfileInfo['Name'],
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
                  ProfileInfo['InformationText'],
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          //İletişim
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                        heroTag: "fab2",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      Text(
                        ProfileInfo['Mail'],
                        style: TextStyle(fontSize: 10),
                      ),
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
                        heroTag: "fab3",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      Text(ProfileInfo['phoneNumber'],
                          style: TextStyle(fontSize: 10)),
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
                        heroTag: "fab4",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      Text(ProfileInfo['instagramInfo'],
                          style: TextStyle(fontSize: 10)),
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
                        heroTag: "fab5",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      Text(ProfileInfo['twitterInfo'],
                          style: TextStyle(fontSize: 10)),
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
                        heroTag: "fab6",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      Text(ProfileInfo['facebookInfo'],
                          style: TextStyle(fontSize: 10)),
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
                        heroTag: "fab7",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      Text(ProfileInfo['youtubeInfo'],
                          style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          Text("Tariflerim"),
          Divider(
            height: 3,
            color: Colors.cyan,
          ),
        ],
      ),
    ),
  );
}

ImageProvider ProfilePhoto(Map<String?, dynamic> ProfileInfo) {
  if (ProfileInfo['signupType'] == 'google') {
    return NetworkImage(ProfileInfo['ProfilePhoto'].toString());
  } else {
    if (ProfileInfo['ProfilePhoto'] != "null") {
      return AssetImage(ProfileInfo['ProfilePhoto']);
    } else {
      return AssetImage("assets/profileImage/default_profile_image.jpg");
    }
  }
}
