import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> isUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');
      return uid != null;
    } catch (e) {
      return false;
    }
  }
}
