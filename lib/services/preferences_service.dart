import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _waterAmountKey = 'water_amount';
  static const String _waterGoalKey = 'water_goal';
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
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
}
