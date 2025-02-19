import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class WeatherEntity extends Equatable {
  @HiveField(0)
  final String cityName;
  @HiveField(1)
  final double temperature;
  @HiveField(2)
  final double windSpeed;
  @HiveField(3)
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
