import 'package:flutter/material.dart';
import '../../../theme/app_font_styles.dart';

class CategoryChipItem extends StatelessWidget {
  const CategoryChipItem({
    super.key,
    required this.onTap,
    required this.category,
    required this.backgroundColor,
  });

  final VoidCallback onTap;
  final String category;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          category,
        ),
        labelStyle: AppFontStyles.body2SemiBold.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 2,
        ),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.surface,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
