// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';
import 'package:weather_app/features/home/domain/repository/base_weather_repo.dart';

class GetWeatherDetailsUseCase {
  final BaseWeatherRepo weatherRepo;
  GetWeatherDetailsUseCase(this.weatherRepo);

  Future<Either<Failure, WeatherEntity>> call(String cityName) async {
    return await weatherRepo.getWeatherDetails(cityName);
  }
}
