import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/app_font_styles.dart';

class ActionTextIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String icon;
  const ActionTextIconButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.tertiary,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: AppFontStyles.buttonLarge.copyWith(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            icon,
          ),
        ],
      ),
    );
  }
}
