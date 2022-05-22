import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/userProfile/createUserProfile.dart';
import 'package:myrecipe/splashScreen.dart';

class ProfileEditing extends StatefulWidget {
  Map<String?, dynamic>? profileInfo;
  ProfileEditing(this.profileInfo, {Key? key}) : super(key: key);
  @override
  _ProfileEditingPageState createState() =>
      _ProfileEditingPageState(profileInfo!);
}

class _ProfileEditingPageState extends State<ProfileEditing> {
  String? url;
  File? uploadedFile;
  Map<String?, dynamic>? profileInfo;
  _ProfileEditingPageState(this.profileInfo);
  Map<String?, dynamic>? changedInfo;

  @override
  Widget build(BuildContext context) {
    changedInfo = profileInfo;
    final _key = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Düzenlemeyi bitiren buton
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          uploadedFile = null;
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          )),
                        ),
                        child: const Text("İptal Et"))
                  ],
                ),
                //ımage
                SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Profil fotoğrafı
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.white,
                            border: Border.all(color: Colors.cyan, width: 3),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    ProfilePhoto(profileInfo!, uploadedFile))),
                        height: 170,
                        width: 170,
                        padding: const EdgeInsets.all(0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return SafeArea(
                                          child: Wrap(
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.camera_alt),
                                                title: const Text("Kamera"),
                                                onTap: () {
                                                  fromCamera();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.photo_library),
                                                title: const Text(
                                                    "Fotoğraf Galerisi"),
                                                onTap: () {
                                                  fromGallery();
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                //isim
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: TextEditingController(
                      text: profileInfo!['Name'],
                    ),
                    onChanged: (changedName) {
                      changedInfo!['Name'] = changedName;
                    },
                    validator: (changedName) {
                      if (changedName!.length > 30) {
                        return "En fazla 30 karakter giriniz.";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.cyan,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      labelText: "Kullanıcı İsmi",
                      labelStyle: const TextStyle(
                          color: Colors.cyan, fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        // text kutusuna tıklanmadan önce
                        borderRadius: BorderRadius.circular(22),
                        borderSide: const BorderSide(color: Colors.cyan),
                      ),
                      focusedBorder: OutlineInputBorder(
                          //Text kutusuna tıklandıktan sonra
                          borderSide: const BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(22)),
                    ),
                  ),
                ),
                //Hakkımda
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: TextEditingController(
                      text: profileInfo!['InformationText'],
                    ),
                    onChanged: (changedInf) {
                      changedInfo!['InformationText'] = changedInf;
                    },
                    validator: (changedName) {
                      if (changedName!.length > 140) {
                        return "En fazla 140 karakter giriniz.";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.cyan,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      labelText: "Hakkımda",
                      labelStyle: const TextStyle(
                          color: Colors.cyan, fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        // text kutusuna tıklanmadan önce
                        borderRadius: BorderRadius.circular(22),
                        borderSide: const BorderSide(color: Colors.cyan),
                      ),
                      focusedBorder: OutlineInputBorder(
                          //Text kutusuna tıklandıktan sonra
                          borderSide: const BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(22)),
                    ),
                  ),
                ),
                //Mail
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icon/email.png"),
                        heroTag: "fab1",
                        mini: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      Text(
                        profileInfo!['Mail'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                //telefon
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icon/phone.png"),
                        heroTag: "fab2",
                        mini: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: profileInfo!['phoneNumber'],
                          ),
                          onChanged: (changedPhone) {
                            changedInfo!['phoneNumber'] = changedPhone;
                          },
                          validator: (changedName) {
                            if (changedName!.length > 20) {
                              return "En fazla 20 karakter giriniz.";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.cyan,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelText: "Telefon Numarası",
                            labelStyle: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              // text kutusuna tıklanmadan önce
                              borderRadius: BorderRadius.circular(22),
                              borderSide: const BorderSide(color: Colors.cyan),
                            ),
                            focusedBorder: OutlineInputBorder(
                                //Text kutusuna tıklandıktan sonra
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(22)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //instagram
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icon/instagram.png"),
                        heroTag: "fab3",
                        mini: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: profileInfo!['instagramInfo'],
                          ),
                          onChanged: (changedInstagram) {
                            changedInfo!['instagramInfo'] = changedInstagram;
                          },
                          validator: (changedInstagram) {
                            if (changedInstagram!.length > 22) {
                              return "En fazla 22 karakter giriniz.";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.cyan,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelText: "Instagram",
                            labelStyle: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: const BorderSide(color: Colors.cyan),
                            ),
                            focusedBorder: OutlineInputBorder(
                                //Text kutusuna tıklandıktan sonra
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(22)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //twitter
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icon/twitter.png"),
                        heroTag: "fab4",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: profileInfo!['twitterInfo'],
                          ),
                          onChanged: (changedTwitter) {
                            changedInfo!['twitterInfo'] = changedTwitter;
                          },
                          validator: (changedTwitter) {
                            if (changedTwitter!.length > 22) {
                              return "En fazla 22 karakter giriniz.";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.cyan,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelText: "Twitter",
                            labelStyle: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: const BorderSide(color: Colors.cyan),
                            ),
                            focusedBorder: OutlineInputBorder(
                                //Text kutusuna tıklandıktan sonra
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(22)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //facebook
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icon/facebook.png"),
                        heroTag: "fab5",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: profileInfo!['facebookInfo'],
                          ),
                          onChanged: (changedFacebook) {
                            changedInfo!['facebookInfo'] = changedFacebook;
                          },
                          validator: (changedFacebook) {
                            if (changedFacebook!.length > 22) {
                              return "En fazla 22 karakter giriniz.";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.cyan,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelText: "Facebook",
                            labelStyle: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: const BorderSide(color: Colors.cyan),
                            ),
                            focusedBorder: OutlineInputBorder(
                                //Text kutusuna tıklandıktan sonra
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(22)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //youtube
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Image.asset("assets/icon/youtube.png"),
                        heroTag: "fab6",
                        backgroundColor: Colors.transparent,
                        mini: true,
                        elevation: 0,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: profileInfo!['youtubeInfo'],
                          ),
                          onChanged: (changedYoutube) {
                            changedInfo!['youtubeInfo'] = changedYoutube;
                          },
                          validator: (changedYoutube) {
                            if (changedYoutube!.length > 22) {
                              return "En fazla 22 karakter giriniz.";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.cyan,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelText: "Youtube",
                            labelStyle: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: const BorderSide(color: Colors.cyan),
                            ),
                            focusedBorder: OutlineInputBorder(
                                //Text kutusuna tıklandıktan sonra
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(22)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          uploadFile();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Splash(position: 3,)));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          )),
                        ),
                        child: const Text("Değişiklikleri Kaydet"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  fromCamera() async {
    var getFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      uploadedFile = File(getFile!.path);
    });
  }

  fromGallery() async {
    var getFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      uploadedFile = File(getFile!.path);
    });
  }

  Future uploadFile() async {
    updateUserProfile(changedInfo!);
    if (uploadedFile == null) return;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("ProfileImage")
        .child(SharedPrefs.getUid.toString())
        .child("profileImage.png");

    UploadTask uploadTask = ref.putFile(uploadedFile!);
    setState(() {});

    if (uploadTask == null) return;

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    url = await urlDownload.toString();
    changedInfo!['ProfilePhoto'] = url.toString();
    updateUserProfile(changedInfo!);
    print("completed");
  }
}

ImageProvider ProfilePhoto(Map<String?, dynamic> ProfileInfo, File? photo) {
  if (photo != null) {
    return FileImage(photo);
  } else {
    if (ProfileInfo['ProfilePhoto'] != "null") {
      return NetworkImage(ProfileInfo['ProfilePhoto']);
    } else {
      return const AssetImage("assets/profileImage/default_profile_image.jpg");
    }
  }
}
