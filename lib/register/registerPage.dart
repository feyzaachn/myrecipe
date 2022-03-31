import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/services/addUserWithMail.dart';
import 'package:myrecipe/widgets/background.dart';
import 'package:myrecipe/widgets/textFormField.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  //kayıt parametreleri
  String? mail, password, password2, name;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  final _key = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Background(),
              SizedBox(height: 20),
              //Email
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormFieldWidgets(
                  validator: (enteredMail) {
                    if (enteredMail.toString().length == 0) {
                      return "E-mail adresinizi giriniz";
                    } else if (enteredMail!.contains("@")) {
                      return null;
                    } else {
                      return "Geçersiz bir mail";
                    }
                  },
                  onChanged: (enteredMail) {
                    mail = enteredMail;
                  },
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'E-mail',
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                    color: Colors.deepPurpleAccent,
                    size: 25,
                  ),
                  obscureText: false,
                ),
              ),
              //ad soyad
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormFieldWidgets(
                  validator: (enteredName) {
                    return enteredName!.length != 0
                        ? null
                        : "Adınızı soyadınızı giriniz";
                  },
                  onChanged: (enteredName) {
                    name = enteredName;
                  },
                  keyboardType: TextInputType.name,
                  labelText: 'Ad Soyad',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.deepPurpleAccent,
                    size: 25,
                  ),
                  obscureText: false,
                ),
              ),
              //şifre
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormFieldWidgets(
                  validator: (enteredPassword) {
                    if (enteredPassword.toString().length == 0) {
                      return "Bir şifre giriniz";
                    }
                    if (enteredPassword.toString().length > 6) {
                      return null;
                    } else {
                      return "Şifreniz en az 7 karakterden oluşmalıdır";
                    }
                  },
                  onChanged: (enteredPassword) {
                    password = enteredPassword;
                  },
                  keyboardType: TextInputType.text,
                  labelText: 'Şifre',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurpleAccent,
                    size: 25,
                  ),
                  obscureText: true,
                ),
              ),
              //Şifre tekrar
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormFieldWidgets(
                  onChanged: (enteredPassword2) {
                    password2 = enteredPassword2;
                  },
                  validator: (enteredPassword2) {
                    if (enteredPassword2.toString().length == 0) {
                      return "Şifrenizi tekrar giriniz";
                    }
                    if (enteredPassword2.toString() == password) {
                      return null;
                    } else {
                      return "Şifreniz aynı değil";
                    }
                  },
                  keyboardType: TextInputType.text,
                  labelText: 'Şifre Tekrar',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurpleAccent,
                    size: 25,
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              //Kayıt Butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 130,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.deepPurpleAccent),
                          ),
                        ),
                      ),
                      child: const Text("Kayıt Ol"),
                      onPressed: () {
                        Map<String, dynamic> UserAdd = ({
                          'mail': mail.toString(),
                          'name': name.toString(),
                          'password': password.toString(),
                          'signupType':'email'
                        });
                        if (_key.currentState!.validate()) {
                          addUser(context, UserAdd);
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage())),
                  child:
                      Text("Daha önce kayıt olduysanız giriş ekranına gidin"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
