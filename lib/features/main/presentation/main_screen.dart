import 'package:flutter/material.dart';
import 'package:water_tracker/di/di.dart';
import 'package:water_tracker/features/main/data/models/water_amount.dart';
import 'package:water_tracker/features/main/data/repositories/abstract_main_repository.dart';
import 'package:water_tracker/features/main/presentation/widgets/water_variant.dart';
import 'package:water_tracker/services/preferences_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<WaterAmount> waterAmounts = [];
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _loadWaterAmounts();
  }

  Future<void> _loadWaterAmounts() async {
    waterAmounts = await di<AbstractMainRepository>().loadWaterAmounts();
    totalAmount = di<PreferencesService>().getWaterAmount();
    setState(() {});
  }

  void _onWaterAmountTap(int index) {
    setState(() {
      totalAmount += waterAmounts[index].amount;
      di<PreferencesService>().saveWaterAmount(totalAmount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          'Water Tracker',
          style: theme.textTheme.labelLarge
              ?.copyWith(color: theme.colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.125,
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            '$totalAmount ml',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Goal: 2000 ml',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(
                              value: totalAmount / 2000,
                              color: theme.colorScheme.primary,
                              strokeWidth: 8,
                              backgroundColor:
                                  theme.colorScheme.primary.withOpacity(0.2),
                            ),
                          ),
                          Text(
                            '${((totalAmount / 2000) * 100).toInt()}%',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: PageView.builder(
                      itemCount: waterAmounts.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () => _onWaterAmountTap(index),
                          child: Container(
                              color: Colors.transparent,
                              child: WaterVariant(
                                  waterAmount: waterAmounts[index]))),
                    ),
                  ),
                ),
                Text(
                  '$totalAmount ml',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
