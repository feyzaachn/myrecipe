import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  //Shared preferences nesnesi oluşmuşsa aynı nesneyi tekrar çağırıyoruz yoksa sıfırdan oluşturuyoruz
  static SharedPreferences? _prefs;
  static initialize() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  //Shared prefs üzerine mail adresini kayıt ediyoruz
  static Future<bool> saveMail(String mail) async {
    return _prefs!.setString('mail', mail);
  }

  //Shared prefs üzerine şifreyi kayıt ediyoruz
  static Future<bool> savePassword(String password) async {
    return _prefs!.setString("password", password);
  }

  static Future<bool> saveUid(String uid) async {
    return _prefs!.setString('uid', uid);
  }

  //Shared üzerinde kayıtlı olan bütün verileri siler
  static Future<bool> sharedClear() async {
    return _prefs!.clear();
  }

  //Login bilgisini tutar
  static Future<bool> login() async {
    return _prefs!.setBool('login', true);
  }

  //Kayıtlı veri varsa alıyoruz yoksa boş değer atıyoruz
  static String? get getMail => _prefs!.getString("mail");
  static String? get getPassword => _prefs!.getString("password");
  static String? get getUid => _prefs!.getString("uid");
  static bool get getLogin => _prefs!.getBool('login') ?? false;
}