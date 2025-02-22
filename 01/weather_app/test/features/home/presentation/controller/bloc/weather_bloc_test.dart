import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';

import '../../../../../mocks/mock_classes.mocks.dart';

void main() {
  late MockGetWeatherDetailsUseCase mockGetWeatherDetailsUseCase;
  late MockWeatherLocalDataSource mockWeatherLocalDataSource;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetWeatherDetailsUseCase = MockGetWeatherDetailsUseCase();
    mockWeatherLocalDataSource = MockWeatherLocalDataSource();
    weatherBloc = WeatherBloc(
      mockGetWeatherDetailsUseCase,
      mockWeatherLocalDataSource,
    );
  });

  group("WeatherBloc", () {
    test("Should have WeatherInitialState as initial state", () {
      expect(weatherBloc.state, WeatherInitialState());
    });

    final cityName = "Cairo";
    final weatherAPIModel = WeatherAPIModel(
      cityName: cityName,
      temperature: 287.57,
      humidity: 88,
      windSpeed: 2.06,
    );
    final weatherAPIModel2 = WeatherAPIModel(
      cityName: cityName,
      temperature: 300,
      humidity: 90,
      windSpeed: 3.06,
    );
    blocTest(
      "Should emit WeatherLoadingState then WeatherLoadedState when GetWeatherDetailsEvent is added",
      build: () {
        when(mockGetWeatherDetailsUseCase.call(cityName)).thenAnswer(
          (_) async => Right(weatherAPIModel),
        );
        when(mockWeatherLocalDataSource.getWeatherDetails(cityName)).thenReturn(
          weatherAPIModel2,
        );
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherDetailsEvent(cityName)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        WeatherLoadingState(),
        WeatherLoadedState(weatherAPIModel, weatherAPIModel2),
      ],
    );

    final Failure serverFailure = ServerFailure("Server Failure");
    blocTest(
      "Should emit WeatherLoadingState then WeatherErrorState when connection fails",
      build: () {
        when(mockGetWeatherDetailsUseCase.call(cityName)).thenAnswer(
          (_) async => Left(serverFailure),
        );
        when(mockWeatherLocalDataSource.getWeatherDetails(cityName)).thenReturn(
          weatherAPIModel2,
        );
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherDetailsEvent(cityName)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        WeatherLoadingState(),
        WeatherErrorState(serverFailure),
      ],
    );
  });
}
