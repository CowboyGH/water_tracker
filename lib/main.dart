import 'package:flutter/material.dart';
import 'package:water_tracker/di/di.dart';
import 'package:water_tracker/router/route.dart';
import 'package:water_tracker/services/preferences_service.dart';
import 'package:water_tracker/theme/theme.dart';

ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(di<PreferencesService>().getTheme() == 'System'
        ? ThemeMode.system
        : di<PreferencesService>().getTheme() == 'Light'
            ? ThemeMode.light
            : ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDI();
  final prefs = di<PreferencesService>();
  await prefs.init();

  runApp(WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, value, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
        );
      },
    );
  }
}
