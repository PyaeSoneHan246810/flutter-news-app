import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/weather_repository.dart';
import '../../../domain/model/weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherDataRepository weatherDataRepository;
  CurrentWeatherBloc(this.weatherDataRepository)
      : super(CurrentWeatherInitial()) {
    on<CurrentWeatherFetched>(_getCurrentWeather);
  }

  void _getCurrentWeather(
    CurrentWeatherFetched event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    emit(CurrentWeatherLoading());
    try {
      final currentWeather = await weatherDataRepository.getCurrentWeather();
      emit(CurrentWeatherSuccess(currentWeather));
    } catch (e) {
      emit(CurrentWeatherFailure(e.toString()));
    }
  }
}
