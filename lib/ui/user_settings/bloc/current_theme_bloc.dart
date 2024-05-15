import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/app_themes.dart';

part 'current_theme_event.dart';
part 'current_theme_state.dart';

class CurrentThemeBloc extends Bloc<CurrentThemeEvent, CurrentThemeState> {
  CurrentThemeBloc()
      : super(
          CurrentThemeState(
            isDarkThemeEnabled: false,
            theme: AppThemes.lightTheme,
          ),
        ) {
    on<CurrentThemeInitial>(_loadInitialTheme);
    on<CurrentThemeToggled>(_toggleTheme);
  }

  void _loadInitialTheme(
    CurrentThemeInitial event,
    Emitter<CurrentThemeState> emit,
  ) async {
    final bool isDarkThemeEnabled = await _isDarkThemeEnabled();
    if (isDarkThemeEnabled) {
      emit(
        CurrentThemeState(
          isDarkThemeEnabled: isDarkThemeEnabled,
          theme: AppThemes.darkTheme,
        ),
      );
    } else {
      emit(
        CurrentThemeState(
          isDarkThemeEnabled: isDarkThemeEnabled,
          theme: AppThemes.lightTheme,
        ),
      );
    }
  }

  void _toggleTheme(
    CurrentThemeToggled event,
    Emitter<CurrentThemeState> emit,
  ) {
    final isDarkThemeEnabled = event.isDarkThemeEnabled;
    emit(
      CurrentThemeState(
        isDarkThemeEnabled: isDarkThemeEnabled,
        theme: isDarkThemeEnabled ? AppThemes.darkTheme : AppThemes.lightTheme,
      ),
    );
    _saveThemeDataToPrefs(isDarkThemeEnabled);
  }

  Future<void> _saveThemeDataToPrefs(bool isDarkThemeEnabled) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("THEME_KEY", isDarkThemeEnabled);
  }

  Future<bool> _isDarkThemeEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("THEME_KEY") ?? false;
  }
}
