import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import '../bloc/current_theme_bloc.dart';
import '../../../theme/app_font_styles.dart';
import '../../shared_widgets/large_title_top_bar.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentThemeBloc = BlocProvider.of<CurrentThemeBloc>(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const LargeTitleTopBar(
              title: "Settings",
              actions: [],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          "Dark Mode",
                          style: AppFontStyles.buttonMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            MaterialSymbols.dark_mode,
                            size: 20,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        trailing:
                            BlocBuilder<CurrentThemeBloc, CurrentThemeState>(
                          builder: (context, currentThemeState) {
                            return Switch(
                              value: currentThemeState.isDarkThemeEnabled,
                              onChanged: (value) {
                                currentThemeBloc.add(
                                  CurrentThemeToggled(
                                    isDarkThemeEnabled:
                                        !currentThemeState.isDarkThemeEnabled,
                                  ),
                                );
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.background,
                              activeTrackColor:
                                  Theme.of(context).colorScheme.primary,
                              inactiveTrackColor:
                                  Theme.of(context).colorScheme.surface,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
