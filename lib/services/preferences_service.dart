import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _waterAmountKey = 'water_amount';

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
}
