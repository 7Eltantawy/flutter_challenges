import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';

class MockWeatherBox extends Mock implements Box<WeatherAPIModel> {}

// class DioMock extends Mock implements Dio {}

@GenerateMocks([
  Dio,
  WeatherRemoteDataSource,
])
void main() {}
