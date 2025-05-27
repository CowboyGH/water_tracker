import 'package:flutter/material.dart';
import 'package:water_tracker/features/main/data/models/water_amount.dart';

class WaterVariant extends StatelessWidget {
  final WaterAmount waterAmount;
  const WaterVariant({super.key, required this.waterAmount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          waterAmount.icon,
          size: 128,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 15),
        Text(
          '${waterAmount.amount} ml',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
