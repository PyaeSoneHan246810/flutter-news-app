part of 'current_theme_bloc.dart';

final class CurrentThemeState {
  final bool isDarkThemeEnabled;
  final ThemeData theme;
  const CurrentThemeState({
    required this.isDarkThemeEnabled,
    required this.theme,
  });
}
