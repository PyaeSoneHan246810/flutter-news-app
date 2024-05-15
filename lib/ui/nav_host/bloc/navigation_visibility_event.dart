part of 'navigation_visibility_bloc.dart';

@immutable
sealed class NavigationVisibilityEvent {}

final class NavigationVisibilityChanged extends NavigationVisibilityEvent {
  final bool isVisible;
  NavigationVisibilityChanged({
    required this.isVisible,
  });
}
