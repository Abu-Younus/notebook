import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManagement{
  static SharedPreferences? preferences;
  static const String userId = 'user-id';
  static const String isLoggedIn = 'is-logged-in';

  static Future<void> init() async{
    if(preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
  }

  static void setIsLoggedIn(bool value) {
    preferences!.setBool(isLoggedIn, value);
  }

  static bool? getIsLoggedIn() {
    return preferences!.getBool(isLoggedIn);
  }

  static void setUserId(int value) {
    preferences!.setInt(userId, value);
  }

  static int? getUserId() {
    return preferences!.getInt(userId);
  }

  static void clearPreference() {
    preferences!.clear();
  }
}