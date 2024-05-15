import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import '../../theme/app_font_styles.dart';

DelightToastBar toastBar(
  String message,
  IconData icon,
) {
  return DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(milliseconds: 2500),
    builder: (context) {
      return ToastCard(
        title: Text(
          message,
          style: AppFontStyles.buttonMedium.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
          ),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        color: Theme.of(context).colorScheme.surface,
      );
    },
  );
}
