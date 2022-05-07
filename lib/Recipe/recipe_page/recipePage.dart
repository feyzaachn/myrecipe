import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/recipe_page/dropDownMenuItem.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/postSharing/sharing.dart';
import 'package:myrecipe/services/userProfile/createUserProfile.dart';
import 'package:myrecipe/splashScreen.dart';
import 'package:myrecipe/videoPlayer.dart';
import 'package:video_player/video_player.dart';

class RecipePage extends StatefulWidget {
  Map<String?, dynamic>? profileInfo;
  RecipePage({Key? key, this.profileInfo}) : super(key: key);

  @override
  _PostRecipeState createState() => _PostRecipeState(profileInfo);
}

class _PostRecipeState extends State<RecipePage> {
  Map<String?, dynamic>? profileInfo;
  _PostRecipeState(this.profileInfo);
  String? name,
      shortRecipe,
      longRecipe,
      url,
      materialsSize,
      materailsName,
      category;
  List? photoRecipe = [], materials = [];
  var uploadedFilePicture, uploadedFileVideo, uploadedFilePictures;
  Reference? refMainPhoto, refMultiPhoto, refVideo;
  FirebaseStorage storage = FirebaseStorage.instance;
  bool control = true;
  Map<String?, dynamic>? PostInfo;
  @override
  void initState() {
    super.initState();
    profileInfo!["numberOfShares"] =
        (int.parse(profileInfo!["numberOfShares"].toString()) + 1).toString();
    References();
  }

  @override
  Widget build(BuildContext context) {
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
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: TextFormField(
                    onChanged: (enteredName) {
                      name = enteredName.toString();
                    },
                    controller: TextEditingController(text: name ?? " "),
                    validator: (enteredName) {
                      if (enteredName == " " || enteredName == null) {
                        return "Tarifinize ilgi çekici bir isim bulmalısınız.";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      labelText: "Tarif Adı",
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                const Text(
                  "Kapak Fotoğrafı",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                //Ana Fotoğraf
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: Border.all(color: Colors.red, width: 3),
                        image: DecorationImage(
                            image: MainPhoto(uploadedFilePicture),
                            fit: BoxFit.contain),
                      ),
                      child: InkWell(
                        onTap: () {
                          SinglePhoto();
                        },
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.redAccent,
                  height: 20,
                ),
                //kategori
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Kategori",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    DropdownButton(
                      iconEnabledColor: Colors.redAccent,
                      items: dropdownItems,
                      value: category,
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                //Kısa tarif
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (enteredShortRecipe) {
                      shortRecipe = enteredShortRecipe.toString();
                    },
                    controller: TextEditingController(text: shortRecipe ?? " "),
                    validator: (enteredShortRecipe) {
                      if (enteredShortRecipe == " " ||
                          enteredShortRecipe == null) {
                        return "Tarifinizden kısaca bahsediniz.";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      labelText: "Kısaca Tarif",
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                const Divider(
                  color: Colors.redAccent,
                  height: 20,
                ),
                const Text("Malzemeler",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                //Malzeme Listesi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Malzeme Ekle"),
                                actions: [
                                  Form(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 5),
                                            child: TextFormField(
                                              onChanged: (enteredSize) {
                                                materialsSize = enteredSize;
                                              },
                                              controller: TextEditingController(
                                                  text: materialsSize ?? " "),
                                              validator: (enteredSize) {
                                                if (enteredSize == " " ||
                                                    enteredSize == null) {
                                                  return "Ölçüyü giriniz.(1 bardak,300gram vb.)";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              cursorColor: Colors.redAccent,
                                              decoration: const InputDecoration(
                                                  labelText: "Ölçü",
                                                  labelStyle: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(33)),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              33)))),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 5),
                                            child: TextFormField(
                                              onChanged: (enteredMaterils) {
                                                materailsName = enteredMaterils;
                                              },
                                              controller: TextEditingController(
                                                  text: materailsName ?? " "),
                                              validator: (enteredMaterils) {
                                                if (enteredMaterils == " " ||
                                                    enteredMaterils == null) {
                                                  return "Malzemeyi giriniz";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              cursorColor: Colors.redAccent,
                                              decoration: const InputDecoration(
                                                  labelText: "Malzeme",
                                                  labelStyle: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(33)),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              33)))),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    materials!.add(materialsSize
                                                        .toString() +
                                                        " " +
                                                        materailsName.toString());
                                                    materialsSize = null;
                                                    materailsName = null;
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.redAccent)),
                                                  child: const Text("  EKLE  ")),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              );
                            });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                      child: Row(
                        children: const [Icon(Icons.add), Text("Malzeme Ekle")],
                      ),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        for (int i = 0; i < materials!.length; i++)
                          Text(materials![i].toString())
                      ],
                    )
                  ],
                ),
                const Divider(
                  color: Colors.redAccent,
                  height: 20,
                ),
                //Uzun tarif
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: TextFormField(
                    maxLines: 5,
                    onChanged: (enteredLongRecipe) {
                      longRecipe = enteredLongRecipe.toString();
                    },
                    controller: TextEditingController(text: longRecipe ?? " "),
                    validator: (enteredLongRecipe) {
                      if (enteredLongRecipe == " " ||
                          enteredLongRecipe == null) {
                        return "Tarifinizden kısaca bahsediniz.";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      labelText: "Detaylı Tarif",
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                const Divider(
                  color: Colors.redAccent,
                  height: 20,
                ),
                //Fotoğraf ile anlatim
                const Text("Tarifinizi anlatan fotoğraflar",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await MultiPhoto();
                            setState(() {});
                          },
                          icon: const Icon(Icons.add),
                          color: Colors.green,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            photoRecipe!.removeLast();
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red,
                          iconSize: 30,
                        )
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        if (photoRecipe != null)
                          for (int i = 0; i < photoRecipe!.length; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: Colors.white,
                                    border:
                                    Border.all(color: Colors.red, width: 3),
                                    image: DecorationImage(
                                        image: FileImage(photoRecipe![i]),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 20,
                                ),
                              ],
                            ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.redAccent,
                  height: 20,
                ),
                const Text(
                  "Tarifinize anlatan video",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                //Video
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Video();
                            setState(() {});
                          },
                          icon: const Icon(Icons.add),
                          color: Colors.green,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            uploadedFileVideo = null;
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red,
                          iconSize: 30,
                        )
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        if (uploadedFileVideo != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.red, width: 3),
                                ),
                                child: VideoItems(
                                    videoPlayerController:
                                    VideoPlayerController.file(
                                        uploadedFileVideo!)),
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
                //Kaydet
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            PostInfo = {
                              'Name': name!,
                              'MainPhoto': uploadedFilePicture,
                              'ShortRecipe': shortRecipe,
                              'LongRecipe': longRecipe,
                              'PostNumber': profileInfo!["numberOfShares"],
                              'Materials': materials,
                              'PhotoRecipe': photoRecipe,
                              'VideoRecipe': uploadedFileVideo,
                              'Category': category,
                              'numberOfShares': profileInfo!["numberOfShares"]
                            };
                            control = true;
                            ShareControl();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.book),
                            Text("  Paylaş  ")
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SinglePhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    File? file;
    if (result != null) {
      file = File(result.files.single.path.toString());
    }
    setState(() {
      uploadedFilePicture = file;
    });
  }

  MultiPhoto() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    List<File>? files;
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
    }
    setState(() {
      photoRecipe = files;
    });
  }

  Video() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    File? file;
    if (result != null) {
      file = File(result.files.single.path.toString());
    }
    setState(() {
      uploadedFileVideo = file;
    });
  }

  void References() {
    refMainPhoto = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(profileInfo!["numberOfShares"])
        .child("MainPhoto");
    refMultiPhoto = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(profileInfo!["numberOfShares"])
        .child("PhotoRecipe");
    refVideo = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(profileInfo!["numberOfShares"])
        .child("VideoRecipe");
  }

  Future<void> ShareControl() async {
    print(PostInfo);
    //bilgilerin eksikliğinin kontrolü
    PostInfo!.forEach((key, value) async {
      if (key == 'Materials') {
        List list = PostInfo![key];
        if (list.isEmpty) {
          setState(() {
            control = false;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.center,
                  content: const Text(
                      "Paylaşım için tarif adı, kapak fotoğrafı, kategori, kısa tarif, malzemeler ve uzun tarif bilgisi bulunması zorunludur. Lütfen tekrar deneyiniz."),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.deepPurpleAccent)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Tamam"),
                    )
                  ],
                );
              });
        }
      }
      if (value == null && key != 'PhotoRecipe' && key != 'VideoRecipe') {
        setState(() {
          control = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                content: const Text(
                    "Paylaşım için tarif adı, kapak fotoğrafı, kategori, kısa tarif, malzemeler ve uzun tarif bilgisi bulunması zorunludur. Lütfen tekrar deneyiniz."),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurpleAccent)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Tamam"),
                  )
                ],
              );
            });
      }
    });

    if (control == true) {
      Share();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Splash(
                position: 1,
              )));
    }
  }

  Future<void> Share() async {
    //video ve fotoğrafların yüklenmesi
    //Kapak fotoğrafı
    if (PostInfo!['MainPhoto'] != null) {
      await DownloadMainPhoto();
    }
    // video
    if (PostInfo!['VideoRecipe'] != null) {
      await DownloadVideoRecipe();
    }
    //çoklu fotoğraf
    if (PostInfo!['PhotoRecipe'] != null) {
      await DownloadPhotoRecipe();
    }
    //post paylaşımı
    Sharing(PostInfo!);
    //post sayısı güncellenmesi
    updateUserProfile(profileInfo!);
  }

  Future<void> DownloadMainPhoto() async {
    UploadTask uploadTask = refMainPhoto!.putFile(PostInfo!['MainPhoto']);
    if (uploadTask == null) return;
    var snapshot = await uploadTask.whenComplete(() {});
    var urlDownload = await snapshot.ref.getDownloadURL();
    PostInfo!['MainPhoto'] = urlDownload.toString();
  }

  Future<void> DownloadVideoRecipe() async {
    UploadTask uploadTask = refVideo!.putFile(PostInfo!['VideoRecipe']);
    if (uploadTask == null) return;
    var snapshot = await uploadTask.whenComplete(() {});
    var urlDownload = await snapshot.ref.getDownloadURL();
    PostInfo!['VideoRecipe'] = urlDownload.toString();
  }

  Future<void> DownloadPhotoRecipe() async {
    List? photos = PostInfo!['PhotoRecipe'];
    List photosUrl = [];
    for (int i = 0; i < photos!.length; i++) {
      UploadTask uploadTask =
      refMultiPhoto!.child(i.toString()).putFile(photos[i]);
      if (uploadTask == null) return;
      var snapshot = await uploadTask.whenComplete(() {});
      var urlDownload = await snapshot.ref.getDownloadURL();
      photosUrl.add(urlDownload.toString());
    }
    photosUrl == []
        ? PostInfo!['PhotoRecipe'] = null
        : PostInfo!['PhotoRecipe'] = photosUrl;
  }
}

ImageProvider MainPhoto(var photo) {
  if (photo != null) {
    return FileImage(photo);
  } else {
    return const AssetImage("assets/icon/picturess.png");
  }
}