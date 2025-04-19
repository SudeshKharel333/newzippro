import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<void> setLoginStatus(bool status) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', status);
  }

  static Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }
}
