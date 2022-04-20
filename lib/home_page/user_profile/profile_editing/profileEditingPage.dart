import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

class ProfileEditing extends StatefulWidget {
  Map<String?, dynamic> profileInfo;
  ProfileEditing(this.profileInfo);
  @override
  _ProfileEditingPageState createState() =>
      _ProfileEditingPageState(profileInfo);
}

class _ProfileEditingPageState extends State<ProfileEditing> {
  String? url;
  File? uploadedFile;
  Map<String?, dynamic> profileInfo;
  _ProfileEditingPageState(this.profileInfo);
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Düzenlemeyi bitiren buton
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        uploadedFile = null;
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        )),
                      ),
                      child: const Text("Düzenlemeyi iptal et"))
                ],
              ),
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
                              fit: BoxFit.cover,
                              image: ProfilePhoto(profileInfo, uploadedFile))),
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
                                              leading: const Icon(Icons.camera_alt),
                                              title: const Text("Kamera"),
                                              onTap: () {
                                                fromCamera();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.photo_library),
                                              title: const Text("Fotoğraf Galerisi"),
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
                    )
                  ],
                ),
              ),
            ],
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
    //uploadImage();
  }

  fromGallery() async {
    var getFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      uploadedFile = File(getFile!.path);
    });
  }

  Future uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("ProfileImage")
        .child(SharedPrefs.getUid.toString())
        .child("profileImage.png");

    UploadTask uploadTask = ref.putFile(uploadedFile!);

    uploadTask.whenComplete(() {
      setState(() {
        url = ref.getDownloadURL().toString();
      });
    });
  }
}

ImageProvider ProfilePhoto(Map<String?, dynamic> ProfileInfo, File? url) {
  if (url != null) {
    return FileImage(url);
  } else {
    if (ProfileInfo['signupType'] == 'google') {
      return NetworkImage(ProfileInfo['ProfilePhoto'].toString());
    } else {
      if (ProfileInfo['ProfilePhoto'] != "null") {
        return NetworkImage(ProfileInfo['ProfilePhoto']);
      } else {
        return const AssetImage("assets/profileImage/default_profile_image.jpg");
      }
    }
  }
}

void ShowPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext? bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text("Kamera"),
                  onTap: () {},
                )
              ],
            ),
          ),
        );
      });
}
