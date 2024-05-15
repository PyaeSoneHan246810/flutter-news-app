import 'package:http/http.dart' as http;
import '../../utils/secrets.dart';

class WeatherDataProvider {
  Future<String> getWeatherData(String cityName) async {
    try {
      final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherApiKey',
      ));
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
