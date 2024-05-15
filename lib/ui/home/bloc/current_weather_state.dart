part of 'current_weather_bloc.dart';

@immutable
sealed class CurrentWeatherState {}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherFailure extends CurrentWeatherState {
  final String errorMessage;
  CurrentWeatherFailure(this.errorMessage);
}

final class CurrentWeatherSuccess extends CurrentWeatherState {
  final Weather currentWeather;
  CurrentWeatherSuccess(this.currentWeather);
}
