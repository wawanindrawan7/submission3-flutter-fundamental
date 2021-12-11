import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const RESTAURANT_TODAY = 'RESTAURANT_TODAY';

  Future<bool> get isDailyRestoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(RESTAURANT_TODAY) ?? false;
  }

  void setDailyResto(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(RESTAURANT_TODAY, value);
  }
}
