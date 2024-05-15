import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/app_font_styles.dart';

class SearchStateMessage extends StatelessWidget {
  const SearchStateMessage({
    super.key,
    required this.stateLabel,
    required this.animation,
    required this.message,
  });
  final String stateLabel;
  final String animation;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          animation,
          width: 240,
          height: 240,
          fit: BoxFit.cover,
        ),
        Text(
          message,
          style: AppFontStyles.headline5.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
