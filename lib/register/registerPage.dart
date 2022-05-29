import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myrecipe/login/loginPage.dart';
import 'package:myrecipe/services/addUser/addUserWithMail.dart';
import 'package:myrecipe/widgets/background.dart';
import 'package:myrecipe/widgets/textFormField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Background(),
              const SizedBox(height: 20),
              //Email
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormFieldWidgets(
                  validator: (enteredMail) {
                    if (enteredMail.toString().isEmpty) {
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
                    return enteredName!.isNotEmpty
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
                    if (enteredPassword.toString().isEmpty) {
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
                    if (enteredPassword2.toString().isEmpty) {
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
              const SizedBox(height: 10),
              //Kayıt Butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 45,
                    width: 130,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.deepPurpleAccent),
                          ),
                        ),
                      ),
                      child: const Text("Kayıt Ol"),
                      onPressed: () {
                        Map<String, dynamic> UserAdd = ({
                          'Mail': mail.toString(),
                          'Name': name.toString(),
                          'Password': password.toString(),
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
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Daha önce kayıt olduysanız ",
                      style: TextStyle(
                        fontSize: 15,
                      ),),
                    InkWell(
                      child: const Text(
                        "Giriş Ekranına Dönün",
                        style: TextStyle(
                            color: Color(0xFF6200FF),
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
