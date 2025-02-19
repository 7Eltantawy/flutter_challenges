import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final double temperature;
  final double windSpeed;
  final int humidity;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  List<Object> get props => [
        cityName,
        temperature,
        windSpeed,
        humidity,
      ];
}
