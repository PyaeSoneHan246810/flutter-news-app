import 'package:flutter/material.dart';
import '../../../theme/app_font_styles.dart';

class ActionTextButton extends StatelessWidget {
  const ActionTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
      ),
      child: Text(
        text,
        style: AppFontStyles.buttonMedium.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
