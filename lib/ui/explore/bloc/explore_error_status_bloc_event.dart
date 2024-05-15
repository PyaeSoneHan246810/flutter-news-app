part of 'explore_error_status_bloc.dart';

@immutable
sealed class ExploreErrorStatusEvent {}

final class ExploreErrorStatusChanged extends ExploreErrorStatusEvent {
  final bool hasError;
  ExploreErrorStatusChanged({required this.hasError});
}
