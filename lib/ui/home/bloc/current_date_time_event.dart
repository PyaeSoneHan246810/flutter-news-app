part of 'current_date_time_bloc.dart';

@immutable
sealed class CurrentDateTimeEvent {}

final class CurrentDateTimeFetched extends CurrentDateTimeEvent {}
