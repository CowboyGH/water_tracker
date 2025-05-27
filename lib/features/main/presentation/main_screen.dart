import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:water_tracker/di/di.dart';
import 'package:water_tracker/features/main/data/models/water_amount.dart';
import 'package:water_tracker/features/main/data/repositories/abstract_main_repository.dart';
import 'package:water_tracker/features/main/presentation/widgets/water_variant.dart';
import 'package:water_tracker/main.dart';
import 'package:water_tracker/services/preferences_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<WaterAmount> waterAmounts = [];
  int totalAmount = 0;
  int waterGoal = 0;

  final _fieldKey = GlobalKey<FormFieldState>();
  final TextEditingController _waterGoalController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWaterAmounts();
    _loadWaterGoal();
  }

  @override
  void dispose() {
    _waterGoalController.dispose();
    super.dispose();
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

  Future<void> _loadWaterGoal() async {
    waterGoal = di<PreferencesService>().getWaterGoal();
    setState(() {});
  }

  void _saveTheme(String theme) {
    _themeController.text = theme;
    di<PreferencesService>().saveTheme(theme);
    themeNotifier.value = theme == 'System'
        ? ThemeMode.system
        : theme == 'Light'
            ? ThemeMode.light
            : ThemeMode.dark;
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
        actionsIconTheme: IconThemeData(
          color: theme.colorScheme.onPrimary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.5),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    content: SizedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.36,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Settings',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Water goal',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                key: _fieldKey,
                                controller: _waterGoalController,
                                keyboardType: TextInputType.number,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.surface,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid water goal';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Water goal must be a number';
                                  }
                                  if (int.parse(value) < 0) {
                                    return 'Water goal must be greater than 0';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  hintText: waterGoal.toString(),
                                  hintStyle:
                                      theme.inputDecorationTheme.hintStyle,
                                  filled: theme.inputDecorationTheme.filled,
                                  fillColor:
                                      theme.inputDecorationTheme.fillColor,
                                  border: theme.inputDecorationTheme.border,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_fieldKey.currentState!.validate()) {
                                      setState(() {
                                        waterGoal = int.parse(
                                            _waterGoalController.text);
                                      });
                                      di<PreferencesService>().saveWaterGoal(
                                          int.parse(_waterGoalController.text));
                                      _waterGoalController.clear();
                                      _fieldKey.currentState!.reset();
                                      context.pop();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    minimumSize: Size(size.width * 0.5, 48),
                                  ),
                                  child: Text(
                                    'Save',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'App Theme',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RepaintBoundary(
                                child: TypeAheadField<String>(
                                  builder: (context, controller, focusNode) {
                                    return TextFormField(
                                      readOnly: true,
                                      controller: _themeController,
                                      focusNode: focusNode,
                                      onChanged: (value) {
                                        _themeController.text = value;
                                      },
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              color:
                                                  theme.colorScheme.onSurface),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        hintText:
                                            di<PreferencesService>().getTheme(),
                                        hintStyle: theme
                                            .inputDecorationTheme.hintStyle,
                                        filled:
                                            theme.inputDecorationTheme.filled,
                                        fillColor: theme
                                            .inputDecorationTheme.fillColor,
                                        border:
                                            theme.inputDecorationTheme.border,
                                      ),
                                    );
                                  },
                                  suggestionsCallback: (pattern) {
                                    return ['Light', 'Dark', 'System']
                                        .where((theme) => theme
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()))
                                        .toList();
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(
                                        suggestion.toString(),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface),
                                      ),
                                    );
                                  },
                                  onSelected: (suggestion) {
                                    if (suggestion !=
                                        di<PreferencesService>().getTheme()) {
                                      _saveTheme(suggestion);
                                    }
                                  },
                                  decorationBuilder: (context, child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.05),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: child,
                                    );
                                  },
                                ),
                              )
                            ])),
                  ),
                );
              },
              icon: Icon(Icons.settings),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
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
                            'Goal: $waterGoal ml',
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
                              value: totalAmount / waterGoal,
                              color: theme.colorScheme.primary,
                              strokeWidth: 8,
                              backgroundColor:
                                  theme.colorScheme.primary.withOpacity(0.2),
                            ),
                          ),
                          Text(
                            '${((totalAmount / waterGoal) * 100).toInt()}%',
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
