import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import '../../../theme/app_font_styles.dart';
import '../../shared_widgets/action_icon_button.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchQueryTextEditingController,
    required this.onSubmitted,
  });

  final TextEditingController searchQueryTextEditingController;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchQueryTextEditingController,
      enabled: true,
      autocorrect: true,
      keyboardType: TextInputType.text,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      cursorColor: Theme.of(context).colorScheme.primary,
      style: AppFontStyles.body1Regular.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintText: "Search",
        hintStyle: AppFontStyles.body1Regular,
        prefixIcon: Icon(
          MaterialSymbols.search_outlined,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        suffixIcon: ActionIconButton(
          iconData: MaterialSymbols.close_outlined,
          size: 20,
          onPressed: () {
            searchQueryTextEditingController.clear();
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
