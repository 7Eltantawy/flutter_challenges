import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';

abstract class BaseWeatherRepo {
  Future<Either<Failure, WeatherEntity>> getWeatherDetails(String cityName);
}
