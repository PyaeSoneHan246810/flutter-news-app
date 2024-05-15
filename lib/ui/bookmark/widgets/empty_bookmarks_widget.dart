import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/app_font_styles.dart';
import '../../user_settings/bloc/current_theme_bloc.dart';

class EmptyBookmarkWidget extends StatelessWidget {
  const EmptyBookmarkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CurrentThemeBloc, CurrentThemeState>(
          builder: (context, currentThemeState) {
            return SvgPicture.asset(
              currentThemeState.isDarkThemeEnabled
                  ? "assets/icons/bookmark_dark.svg"
                  : "assets/icons/bookmark.svg",
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.cover,
            );
          },
        ),
        Text(
          "No bookmarks yet",
          style: AppFontStyles.headline4.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Go ahead and add it.",
          style: AppFontStyles.body1Regular.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
