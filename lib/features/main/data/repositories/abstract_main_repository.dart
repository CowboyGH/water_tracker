import 'package:water_tracker/features/main/data/models/water_amount.dart';

abstract class AbstractMainRepository {
  Future<List<WaterAmount>> loadWaterAmounts();
}
