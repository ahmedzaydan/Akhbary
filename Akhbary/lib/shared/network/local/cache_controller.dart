
import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  /// shared preferences helps me to cache some things
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // set key with a value
  static Future<bool> setBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  // get value of a key
  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences.getBool(key);
  }
}
