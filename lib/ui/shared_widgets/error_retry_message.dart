import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../theme/app_font_styles.dart';

class ErrorRetryMessage extends StatelessWidget {
  const ErrorRetryMessage({
    super.key,
    required this.onRetry,
  });
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/animations/connection_error_anim.json",
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "Something went wrong! Try again.",
          style: AppFontStyles.body2SemiBold.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        MaterialButton(
          onPressed: onRetry,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            "Try again",
            style: AppFontStyles.body2SemiBold.copyWith(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
      ],
    );
  }
}
