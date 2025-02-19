import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';

part 'weather_api_model.g.dart';

@HiveType(typeId: 0)
class WeatherAPIModel extends WeatherEntity {
  const WeatherAPIModel({
    required super.cityName,
    required super.temperature,
    required super.windSpeed,
    required super.humidity,
  });

  factory WeatherAPIModel.fromMap(Map<String, dynamic> map) {
    return WeatherAPIModel(
      cityName: map['name'] as String,
      temperature: (map['main']['temp'] as num).toDouble(),
      humidity: map['main']['humidity'] as int,
      windSpeed: (map['wind']['speed'] as num).toDouble(),
    );
  }

  factory WeatherAPIModel.fromJson(String source) =>
      WeatherAPIModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': cityName,
      'main': {'temp': temperature, 'humidity': humidity},
      'wind': {'speed': windSpeed},
    };
  }

  String toJson() => json.encode(toMap());
}
