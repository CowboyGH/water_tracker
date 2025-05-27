import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _waterAmountKey = 'water_amount';
  static const String _waterGoalKey = 'water_goal';
  static const String _notificationsKey = 'notifications';
  static const String _themeKey = 'theme';
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveTheme(String theme) async {
    await _preferences.setString(_themeKey, theme);
  }

  String getTheme() {
    return _preferences.getString(_themeKey) ?? 'System';
  }

  Future<void> saveWaterAmount(int amount) async {
    await _preferences.setInt(_waterAmountKey, amount);
  }

  int getWaterAmount() {
    return _preferences.getInt(_waterAmountKey) ?? 0;
  }

  Future<void> saveWaterGoal(int amount) async {
    await _preferences.setInt(_waterGoalKey, amount);
  }

  int getWaterGoal() {
    return _preferences.getInt(_waterGoalKey) ?? 2000;
  }

  Future<void> saveNotifications(bool value) async {
    await _preferences.setBool(_notificationsKey, value);
  }

  bool getNotifications() {
    return _preferences.getBool(_notificationsKey) ?? false;
  }
}
