part of 'home_error_status_bloc.dart';

@immutable
sealed class HomeErrorStatusEvent {}

final class HomeErrorStatusChanged extends HomeErrorStatusEvent {
  final bool hasError;
  HomeErrorStatusChanged({required this.hasError});
}
