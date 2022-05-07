import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/Recipe/recipe_page/dropDownMenuItem.dart';
import 'package:myrecipe/login/sharedPrefs.dart';
import 'package:myrecipe/services/postSharing/sharing.dart';
import 'package:myrecipe/videoPlayer.dart';
import 'package:video_player/video_player.dart';
import '../../splashScreen.dart';

class RecipeUpdate extends StatefulWidget{
  String PostId;
  Map<String,dynamic> PostInfo;
  RecipeUpdate(this.PostInfo, this.PostId);
  _RecipeUpdateState createState() => _RecipeUpdateState(PostInfo,PostId);
}

class _RecipeUpdateState extends State<RecipeUpdate>{
  String postId;
  Map<String?,dynamic> postInfo;
  _RecipeUpdateState(this.postInfo,this.postId);
  var uploadedFilePicture, uploadedFileVideo, uploadedFilePictures;
  String? materialsSize,materialsName;
  bool control= true;
  Reference? refMainPhoto, refMultiPhoto, refVideo;
  FirebaseStorage storage = FirebaseStorage.instance;
  Map<String?, dynamic>? PostInfoUpdate;
  void initState(){
    super.initState();
    PostInfoUpdate=postInfo;
  }
  Widget build (BuildContext context){
    final _key = GlobalKey<FormState>();
    setState(() {});
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
                      PostInfoUpdate!['Name'] = enteredName.toString();
                    },
                    controller: TextEditingController(text: PostInfoUpdate!['Name'] ?? " "),
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
                            image: MainPhoto(uploadedFilePicture,PostInfoUpdate!['MainPhoto']),
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
                      value: PostInfoUpdate!['Category'].toString(),
                      onChanged: (String? newValue) {
                        setState(() {
                          PostInfoUpdate!['Category'] = newValue!;
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
                      PostInfoUpdate!['ShortRecipe'] = enteredShortRecipe.toString();
                    },
                    controller: TextEditingController(text: PostInfoUpdate!['ShortRecipe'] ?? " "),
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
                                                materialsName = enteredMaterils;
                                              },
                                              controller: TextEditingController(
                                                  text: materialsName ?? " "),
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
                                                    PostInfoUpdate!['Materials']!.add(materialsSize
                                                        .toString() +
                                                        " " +
                                                        materialsName.toString());
                                                    materialsSize = null;
                                                    materialsName = null;
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
                        for (int i = 0; i < PostInfoUpdate!['Materials']!.length; i++)
                          Text(PostInfoUpdate!['Materials']![i].toString())
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
                      PostInfoUpdate!['LongRecipe'] = enteredLongRecipe.toString();
                    },
                    controller: TextEditingController(text: PostInfoUpdate!['LongRecipe'] ?? " "),
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
                            PostInfoUpdate!['PhotoRecipe']!.removeLast();
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
                        if (PostInfoUpdate!['PhotoRecipe'] != null)
                          for (int i = 0; i < PostInfoUpdate!['PhotoRecipe']!.length; i++)
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
                                        image: RecipePhotos(PostInfoUpdate!['PhotoRecipe']![i]),
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
                                child:uploadedFileVideo != null ?  VideoItems(
                                    videoPlayerController:
                                    VideoPlayerController.file(
                                        PostInfoUpdate!['VideoRecipe']!)):VideoItems(
                                    videoPlayerController:
                                    VideoPlayerController.network(
                                        PostInfoUpdate!['VideoRecipe']!)),
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
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            PostInfoUpdate!['MainPhoto'] = await uploadedFilePicture ?? postInfo['MainPhoto'];
                            PostInfoUpdate!['VideoRecipe'] = await uploadedFileVideo ?? postInfo['VideoRecipe'];
                            print("pis:"+PostInfoUpdate!['MainPhoto'].toString());
                            print("pie:"+postInfo['MainPhoto'].toString());
                            control = true;
                            setState(() {

                            });
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
                            Text("  Güncelle  ")
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
      for(int i=0;i<files!.length;i++) {
        PostInfoUpdate!['PhotoRecipe']!.add(files[i]);
      }
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
    setState(()async {
      uploadedFileVideo = file;
      PostInfoUpdate!['VideoRecipe']= await uploadedFileVideo;
    });
  }

  void References() {
    refMainPhoto = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(postInfo['PostNumber'].toString())
        .child("MainPhoto");
    refMultiPhoto = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(postInfo['PostNumber'].toString())
        .child("PhotoRecipe");
    refVideo = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(postInfo['PostNumber'].toString())
        .child("VideoRecipe");
  }

  Future<void> ShareControl() async {
    //bilgilerin eksikliğinin kontrolü
    PostInfoUpdate!.forEach((key, value) async {
      if (key == 'Materials') {
        List list = PostInfoUpdate![key];
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
                position: 3,
              )));
    }
  }

  Future<void> Share() async {
    //video ve fotoğrafların yüklenmesi
    print("pi:"+PostInfoUpdate!['MainPhoto'].toString());
    //Kapak fotoğrafı
    if (PostInfoUpdate!['MainPhoto'] != null && PostInfoUpdate!['MainPhoto'] != postInfo['MainPhoto']) {
      await DownloadMainPhoto();
    }
    // video
    if (PostInfoUpdate!['VideoRecipe'] != null && PostInfoUpdate!['VideoRecipe'] != postInfo['VideoRecipe']) {
      await DownloadVideoRecipe();
    }
    //çoklu fotoğraf
    if (PostInfoUpdate!['PhotoRecipe'] != null && PostInfoUpdate!['PhotoRecipe'] != postInfo['PhotoRecipe']) {
      await DownloadPhotoRecipe();
    }
    //post paylaşımı
    Update(PostInfoUpdate!,postId);
  }

  Future<void> DownloadMainPhoto() async {
    UploadTask uploadTask = refMainPhoto!.putFile(PostInfoUpdate!['MainPhoto']);
    if (uploadTask == null) return;
    var snapshot = await uploadTask.whenComplete(() {});
    var urlDownload = await snapshot.ref.getDownloadURL();
    PostInfoUpdate!['MainPhoto'] = urlDownload.toString();
    print("pis:"+PostInfoUpdate!['MainPhoto'].toString());
  }

  Future<void> DownloadVideoRecipe() async {
    UploadTask uploadTask = refVideo!.putFile(PostInfoUpdate!['VideoRecipe']);
    if (uploadTask == null) return;
    var snapshot = await uploadTask.whenComplete(() {});
    var urlDownload = await snapshot.ref.getDownloadURL();
    PostInfoUpdate!['VideoRecipe'] = urlDownload.toString();
  }

  Future<void> DownloadPhotoRecipe() async {
    List? photos = PostInfoUpdate!['PhotoRecipe'];
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
        ? PostInfoUpdate!['PhotoRecipe'] = null
        : PostInfoUpdate!['PhotoRecipe'] = photosUrl;
  }
}
ImageProvider MainPhoto(var photo,var recipePhoto) {
  if (photo != null) {
    return FileImage(photo);
  } else {
    return NetworkImage(recipePhoto);
  }
}

ImageProvider RecipePhotos (var recipePhoto) {
  if(recipePhoto.runtimeType == String){
    return NetworkImage(recipePhoto);
  }
  else{
    return FileImage(recipePhoto);
  }
}