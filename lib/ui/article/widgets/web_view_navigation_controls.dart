// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../shared_widgets/action_icon_button.dart';
import '../../../theme/app_font_styles.dart';

class NavigationControls extends StatefulWidget {
  const NavigationControls({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  State<NavigationControls> createState() => _NavigationControlsState();
}

class _NavigationControlsState extends State<NavigationControls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionIconButton(
          iconData: MaterialSymbols.arrow_back_ios_outlined,
          size: 20,
          onPressed: () async {
            if (!mounted) return;
            final messenger = ScaffoldMessenger.of(context);
            if (await widget.controller.canGoBack()) {
              await widget.controller.goBack();
            } else {
              messenger.showSnackBar(
                SnackBar(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  content: Text(
                    'No back history.',
                    style: AppFontStyles.title.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  showCloseIcon: true,
                  closeIconColor: Theme.of(context).colorScheme.primary,
                  duration: const Duration(milliseconds: 500),
                ),
              );
              return;
            }
          },
        ),
        ActionIconButton(
          iconData: MaterialSymbols.arrow_forward_ios_outlined,
          size: 20,
          onPressed: () async {
            if (await widget.controller.canGoForward()) {
              await widget.controller.goForward();
            } else {
              final messenger = ScaffoldMessenger.of(context);
              messenger.showSnackBar(
                SnackBar(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  content: Text(
                    'No forward history.',
                    style: AppFontStyles.title.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  showCloseIcon: true,
                  closeIconColor: Theme.of(context).colorScheme.primary,
                  duration: const Duration(milliseconds: 500),
                ),
              );
              return;
            }
          },
        ),
        ActionIconButton(
          iconData: MaterialSymbols.replay_outlined,
          size: 20,
          onPressed: () {
            widget.controller.reload();
          },
        )
      ],
    );
  }
}
