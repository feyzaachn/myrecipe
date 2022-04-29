import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

class PostPage extends StatefulWidget {
  Map<String?, dynamic>? profileInfo;
  PostPage({Key? key, this.profileInfo}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState(profileInfo);
}

class _PostPageState extends State<PostPage> {
  Map<String?, dynamic>? profileInfo;
  _PostPageState(this.profileInfo);
  String? name,
      mainPhoto,
      shortRecipe,
      longRecipe,
      url,
      postNumber,
      materialsSize,
      materailsName;
  List? photoRecipe = [], videoRecipe=[];
  List? materials=[];
  var uploadedFile;
  @override
  void initState() {
    super.initState();
    postNumber =
        (int.parse(profileInfo!["numberOfShares"].toString()) + 1).toString();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final _key2 = GlobalKey<FormState>();
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
                    initialValue: " ",
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
                            image: MainPhoto(uploadedFile),
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
                //Kısa tarif
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (enteredShortRecipe) {
                      shortRecipe = enteredShortRecipe.toString();
                    },
                    initialValue: " ",
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
                                          validator: (enteredSize) {
                                            if (enteredSize == " " ||
                                                enteredSize == null)
                                              return "Ölçüyü giriniz.(1 bardak,300gram vb.)";
                                            else
                                              return null;
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
                                          validator: (enteredMaterils) {
                                            if (enteredMaterils == " " ||
                                                enteredMaterils == null)
                                              return "Malzemeyi giriniz";
                                            else
                                              return null;
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
                                                materialsSize="";
                                                materailsName="";
                                                setState(() {});
                                                Navigator.pop(context);
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
                //Uzun tarif
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: TextFormField(
                    maxLines: 5,
                    onChanged: (enteredLongRecipe) {
                      longRecipe = enteredLongRecipe.toString();
                    },
                    initialValue: " ",
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
                //Fotoğraf ile anlatim
                const Text("Tarifinizi açıklayan fotoğraflar ekleyin",
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

                            setState(() {photoRecipe!.add(uploadedFile);});
                          },
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            photoRecipe!.removeLast();
                            setState(() {
                            });
                          },
                          icon: Icon(Icons.delete_outline),
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
                                  height: 200,
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
                              ],
                            ),
                      ],
                    ),
                  ],
                ),
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
      uploadedFile = file;
    });
  }

  MultiPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true
    );
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
      uploadedFile = file;
    });
    uploadFile();
  }

  Future uploadFile() async {
    if (uploadedFile == null) return;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("recipe")
        .child(SharedPrefs.getUid.toString())
        .child(postNumber!)
        .child("mainPhoto");

    UploadTask uploadTask = ref.putFile(uploadedFile!);
    setState(() {});

    if (uploadTask == null) return;

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    url = await urlDownload.toString();
    print("completed");
  }
}

ImageProvider MainPhoto(var photo) {
  if (photo != null) {
    return FileImage(photo);
  } else {
    return const AssetImage("assets/icon/picturess.png");
  }
}
