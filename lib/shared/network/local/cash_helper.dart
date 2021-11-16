import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putBoolean({
    required key,
    required bool value,
  }) async {
    return await sharedPreferences?.setBool(key, value);
  }

  static bool? getBloolean({
    required key,
  }) {
    return sharedPreferences?.getBool(key);
  }
}
