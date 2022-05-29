import 'package:flutter/material.dart';
import 'package:myrecipe/register/registerPage.dart';
import 'package:myrecipe/services/login/loginUserWithGoogle.dart';
import 'package:myrecipe/services/login/loginUserWithMail.dart';
import 'package:myrecipe/widgets/background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

String? mail, password;
bool obscureText = true;

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //kayıt parametreleri
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Background(),
              const SizedBox(height: 30),
              //Mail
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormField(
                  onChanged: (enteredMail) {
                    mail = enteredMail;
                  },
                  validator: (enteredMail) {
                    if (enteredMail.toString().isEmpty) {
                      return "E-mail adresinizi giriniz";
                    } else if (enteredMail!.contains("@")) {
                      return null;
                    } else {
                      return "Geçersiz bir mail";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.deepPurpleAccent,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        // text kutusuna tıklanmadan önce
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent)),
                    labelText: "E-mail",
                    labelStyle: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 15,
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.deepPurpleAccent,
                      size: 25,
                    ),
                    focusedBorder: OutlineInputBorder(
                        //Text kutusuna tıklandıktan sonra
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              //şifre
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: TextFormField(
                  onChanged: (enteredPassword) {
                    password = enteredPassword;
                  },
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
                  cursorColor: Colors.deepPurpleAccent,
                  //texti gizlemed
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        // text kutusuna tıklanmadan önce
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent)),
                    labelText: "Şifre",
                    labelStyle: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 15,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.deepPurpleAccent,
                      size: 25,
                    ),
                    suffixIcon: InkWell(
                      child: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.deepPurpleAccent,
                        size: 25,
                      ),
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        //Text kutusuna tıklandıktan sonra
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    width: 165,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                            side: const BorderSide(
                                color: Colors.deepPurpleAccent),
                          ),
                        ),
                      ),
                      child: const Text("Giriş Yap"),
                      onPressed: () {
                        Map<String, dynamic> user = ({
                          'Mail': mail.toString(),
                          'Password': password.toString(),
                        });
                        if (_key.currentState!.validate()) {
                          loginUserWithMail(context, user);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      userLoginWithGoogle(context);
                    },
                    child: Image.asset("assets/icon/google.png"),
                  )
                ],
              ),
              const SizedBox(
                height: 190,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      "Hesabınız yok mu?  ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  InkWell(
                    child: const Text(
                      "Kaydolunuz",
                      style: TextStyle(
                          color: Color(0xFF6200FF),
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
