import 'package:flutter/material.dart';
import 'package:myrecipe/register/registerPage.dart';
import 'package:myrecipe/services/login/loginUserWithGoogle.dart';
import 'package:myrecipe/services/login/loginUserWithMail.dart';

class LoginPage extends StatefulWidget {
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
              Container(
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/backgrounds/background2.png"),
                        fit: BoxFit.fill)),
              ),
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
                    if (enteredMail.toString().length == 0) {
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
                    if (enteredPassword.toString().length == 0) {
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
                height: 5,
              ),
              Container(
                width: 300,
                child: const Text("Şifremi unuttum",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    decoration: TextDecoration.underline
                  ),
                  ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
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
                    child: const Text(
                      "Hesabınız yok mu?  ",
                      style: const TextStyle(
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
