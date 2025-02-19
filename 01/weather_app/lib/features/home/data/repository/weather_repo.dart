import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';
import 'package:weather_app/features/home/domain/repository/base_weather_repo.dart';

class WeatherRepo implements BaseWeatherRepo {
  final BaseWeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepo(this.weatherRemoteDataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherDetails(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getWeatherDetails(cityName);

      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.apiErrorMsg.statusMsg));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          return left(
            ResponseFailure(
              "Bad Response make sure to write a proper city name",
            ),
          );
        default:
          return left(NetworkFailure("There is an error in Network"));
      }
    }
  }
}
