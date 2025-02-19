// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/data/repository/weather_repo.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';

class GetWeatherDetailsUseCase {
  final WeatherRepo weatherRepo;
  GetWeatherDetailsUseCase(this.weatherRepo);

  Future<Either<Failure, WeatherEntity>> call(String cityName) async {
    return await weatherRepo.getWeatherDetails(cityName);
  }
}
