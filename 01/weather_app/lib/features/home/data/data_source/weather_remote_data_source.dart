import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/const.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/network/api_error_msg_model.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';

abstract class BaseWeatherRemoteDataSource {
  Future<WeatherEntity> getWeatherDetails(String cityName);
}

class WeatherRemoteDataSource extends BaseWeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  @override
  Future<WeatherEntity> getWeatherDetails(String cityName) async {
    final queryParams = {
      'q': cityName,
      'appid': kApiKey,
    };

    final response = await dio.get(kApiBaseUrl, queryParameters: queryParams);
    final data = response.data as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return WeatherAPIModel.fromMap(data) as WeatherEntity;
    } else {
      throw ServerException(ApiErrorMsgModel.fromJson(data));
    }
  }
}
