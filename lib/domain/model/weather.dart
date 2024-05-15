// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Weather {
  final String icon;
  final String weather;
  final double temperature;
  Weather({
    required this.icon,
    required this.weather,
    required this.temperature,
  });

  Weather copyWith({
    String? icon,
    String? weather,
    double? temperature,
  }) {
    return Weather(
      icon: icon ?? this.icon,
      weather: weather ?? this.weather,
      temperature: temperature ?? this.temperature,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
      'weather': weather,
      'temperature': temperature,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    final currentWeather = map['list'][0];
    return Weather(
      icon: currentWeather['weather'][0]['icon'] as String,
      weather: currentWeather['weather'][0]['main'] as String,
      temperature: (currentWeather['main']['temp'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Weather(icon: $icon, weather: $weather, temperature: $temperature)';

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.icon == icon &&
        other.weather == weather &&
        other.temperature == temperature;
  }

  @override
  int get hashCode => icon.hashCode ^ weather.hashCode ^ temperature.hashCode;
}
