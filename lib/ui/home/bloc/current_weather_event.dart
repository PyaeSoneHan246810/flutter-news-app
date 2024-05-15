part of 'current_weather_bloc.dart';

@immutable
sealed class CurrentWeatherEvent {}

final class CurrentWeatherFetched extends CurrentWeatherEvent {}
