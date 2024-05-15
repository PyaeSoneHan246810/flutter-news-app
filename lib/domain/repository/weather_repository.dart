import 'dart:convert';
import '../../data/network/weather_data_provider.dart';
import '../model/weather.dart';

class WeatherDataRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherDataRepository(this.weatherDataProvider);
  Future<Weather> getCurrentWeather() async {
    try {
      final dataString = await weatherDataProvider.getWeatherData("Yangon");
      final dataMap = jsonDecode(dataString);
      if (dataMap['cod'] != '200') {
        throw "Unexpected error occurred!";
      }
      final currentWeather = Weather.fromMap(dataMap);
      return currentWeather;
    } catch (e) {
      throw e.toString();
    }
  }
}
