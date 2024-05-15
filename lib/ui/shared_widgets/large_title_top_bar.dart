import 'package:flutter/material.dart';
import '../../theme/app_font_styles.dart';

class LargeTitleTopBar extends StatelessWidget {
  const LargeTitleTopBar({
    super.key,
    required this.title,
    required this.actions,
  });
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        left: 28,
        top: 8 + MediaQuery.of(context).padding.top,
        right: 28,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppFontStyles.headline3.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: actions,
          ),
        ],
      ),
    );
  }
}
