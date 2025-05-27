import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSecondary: AppColors.onSecondary,
    onSurface: AppColors.onSurface,
  ),
  textTheme: TextTheme(
    titleLarge: AppShrifts.titleLarge,
    titleMedium: AppShrifts.titleMedium,
    titleSmall: AppShrifts.titleSmall,
    bodyLarge: AppShrifts.bodyLarge,
    bodyMedium: AppShrifts.bodyMedium,
    bodySmall: AppShrifts.bodySmall,
    labelLarge: AppShrifts.labelLarge,
    labelMedium: AppShrifts.labelMedium,
    labelSmall: AppShrifts.labelSmall,
  ),
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.background,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    hintStyle: AppShrifts.bodyMedium.copyWith(
      color: AppColors.onSurface.withOpacity(0.6),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.darkSurface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSecondary: AppColors.onSecondary,
    onError: AppColors.onError,
    onSurface: AppColors.onDarkSurface,
  ),
  textTheme: TextTheme(
    titleLarge: AppShrifts.titleLarge,
    titleMedium: AppShrifts.titleMedium,
    titleSmall: AppShrifts.titleSmall,
    bodyLarge: AppShrifts.bodyLarge,
    bodyMedium: AppShrifts.bodyMedium,
    bodySmall: AppShrifts.bodySmall,
    labelLarge: AppShrifts.labelLarge,
    labelMedium: AppShrifts.labelMedium,
    labelSmall: AppShrifts.labelSmall,
  ),
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.background.withOpacity(0.1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    hintStyle: AppShrifts.bodyMedium.copyWith(
      color: AppColors.onDarkSurface.withOpacity(0.6),
    ),
  ),
);

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF64B5F6);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF2A2A2A);
  static const Color error = Color(0xFFE53935);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onDarkSurface = Color(0xFFFFFFFF);
}

class AppShrifts {
  static TextStyle titleLarge = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleMedium = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleSmall = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyLarge = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyMedium = GoogleFonts.montserrat(
    fontSize: 14,
  );
  static TextStyle bodySmall = GoogleFonts.montserrat(
    fontSize: 12,
  );
  static TextStyle labelLarge = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle labelMedium = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle labelSmall = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}
