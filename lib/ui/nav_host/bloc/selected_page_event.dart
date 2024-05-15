part of 'selected_page_bloc.dart';

@immutable
sealed class SelectedPageEvent {}

final class SelectedPageChanged extends SelectedPageEvent {
  final int selectedPageIndex;
  SelectedPageChanged({required this.selectedPageIndex});
}
