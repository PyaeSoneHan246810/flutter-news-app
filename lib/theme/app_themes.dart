import 'package:flutter/material.dart';
import 'app_colors.dart';

// app themes
class AppThemes {
  // light theme
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: LightThemeColors.primaryColor,
    colorScheme: const ColorScheme.light(
      background: LightThemeColors.backgroundColor,
      onBackground: LightThemeColors.onBackgroundColor,
      primary: LightThemeColors.primaryColor,
      secondary: LightThemeColors.secondaryColor,
      tertiary: LightThemeColors.brandColor,
      onTertiary: LightThemeColors.onBrandColor,
      tertiaryContainer: LightThemeColors.tertiaryContainerColor,
      surface: LightThemeColors.surfaceColor,
      errorContainer: LightThemeColors.errorContainerColor,
    ),
    scaffoldBackgroundColor: LightThemeColors.backgroundColor,
  );

  // dark theme
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: DarkThemeColors.primaryColor,
    colorScheme: const ColorScheme.dark(
      background: DarkThemeColors.backgroundColor,
      onBackground: DarkThemeColors.onBackgroundColor,
      primary: DarkThemeColors.primaryColor,
      secondary: DarkThemeColors.secondaryColor,
      tertiary: DarkThemeColors.brandColor,
      onTertiary: DarkThemeColors.onBrandColor,
      tertiaryContainer: DarkThemeColors.tertiaryContainerColor,
      surface: DarkThemeColors.surfaceColor,
      errorContainer: DarkThemeColors.errorContainerColor,
    ),
    scaffoldBackgroundColor: DarkThemeColors.backgroundColor,
  );
}
