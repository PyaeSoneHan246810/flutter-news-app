part of 'current_theme_bloc.dart';

@immutable
sealed class CurrentThemeEvent {}

class CurrentThemeInitial extends CurrentThemeEvent {}

final class CurrentThemeToggled extends CurrentThemeEvent {
  final bool isDarkThemeEnabled;
  CurrentThemeToggled({
    required this.isDarkThemeEnabled,
  });
}
