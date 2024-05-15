import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import '../bloc/navigation_visibility_bloc.dart';
import '../bloc/selected_page_bloc.dart';
import '../../bookmark/screen/bookmark_screen.dart';
import '../../explore/screen/explore_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../user_settings/screen/user_settings_screen.dart';
import '../../../theme/app_font_styles.dart';

class NavHostScreen extends StatelessWidget {
  const NavHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPageBloc = BlocProvider.of<SelectedPageBloc>(context);
    final List<Widget> mainPages = [
      const HomeScreen(),
      const ExploreScreen(),
      const BookmarkScreen(),
      const UserSettingsScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<SelectedPageBloc, int>(
            builder: (context, selectedPageIndex) {
              return Stack(
                children: [
                  Positioned(
                    child: IndexedStack(
                      index: selectedPageIndex,
                      children: mainPages,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: BlocBuilder<NavigationVisibilityBloc, bool>(
                      builder: (context, isVisible) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: isVisible ? 80 : 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 4.0,
                                sigmaY: 4.0,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(28),
                                    topRight: Radius.circular(28),
                                  ),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer
                                      .withOpacity(0.75),
                                ),
                                child: GNav(
                                  selectedIndex: selectedPageIndex,
                                  onTabChange: (index) {
                                    selectedPageBloc.add(
                                      SelectedPageChanged(
                                          selectedPageIndex: index),
                                    );
                                  },
                                  color: Theme.of(context).colorScheme.primary,
                                  activeColor:
                                      Theme.of(context).colorScheme.background,
                                  tabBackgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  iconSize: 24,
                                  textStyle:
                                      AppFontStyles.footnoteSemibold.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  gap: 4,
                                  tabs: bottomNavBarTabs,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

const List<GButton> bottomNavBarTabs = [
  GButton(
    icon: MaterialSymbols.home_outlined,
    text: "Home",
  ),
  GButton(
    icon: MaterialSymbols.public_outlined,
    text: "Explore",
  ),
  GButton(
    icon: MaterialSymbols.bookmark_outlined,
    text: "Bookmark",
  ),
  GButton(
    icon: MaterialSymbols.settings_outlined,
    text: "Settings",
  )
];
