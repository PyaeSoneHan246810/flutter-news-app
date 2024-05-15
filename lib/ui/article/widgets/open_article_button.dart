import 'package:flutter/material.dart';
import '../../../theme/app_font_styles.dart';

class OpenArticleButton extends StatelessWidget {
  const OpenArticleButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        title,
        style: AppFontStyles.body2SemiBold.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
