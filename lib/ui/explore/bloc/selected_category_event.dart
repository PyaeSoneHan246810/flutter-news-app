part of 'selected_category_bloc.dart';

@immutable
sealed class SelectedCategoryEvent {}

final class SelectedCategoryChanged extends SelectedCategoryEvent {
  final int selectedCategoryIndex;
  SelectedCategoryChanged({
    required this.selectedCategoryIndex,
  });
}
