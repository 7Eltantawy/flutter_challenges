import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_local_source.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/domain/use_cases/get_weather_details.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';

class MockWeatherBox extends Mock implements Box<WeatherAPIModel> {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

// class DioMock extends Mock implements Dio {}

@GenerateMocks([
  Dio,
  WeatherRemoteDataSource,
  WeatherLocalDataSource,
  GetWeatherDetailsUseCase,
])
void main() {}
