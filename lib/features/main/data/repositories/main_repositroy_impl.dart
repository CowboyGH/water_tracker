import 'package:flutter/material.dart';
import 'package:water_tracker/features/main/data/repositories/abstract_main_repository.dart';
import 'package:water_tracker/features/main/data/models/water_amount.dart';

class MainRepositroyImpl implements AbstractMainRepository {
  @override
  Future<List<WaterAmount>> loadWaterAmounts() async {
    return [
      WaterAmount(amount: 100, icon: Icons.water_drop),
      WaterAmount(amount: 250, icon: Icons.coffee),
      WaterAmount(amount: 500, icon: Icons.local_drink),
    ];
  }
}
