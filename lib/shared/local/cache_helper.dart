import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    String? key,
    String? value,
  }) async {
    return await sharedPreferences!.setString(key!, value!);
  }

  static getData({String? key}){
    return sharedPreferences!.get(key!);
  }

  static Future<bool> deleteData(String? key){
    return sharedPreferences!.remove(key!);
  }
}
