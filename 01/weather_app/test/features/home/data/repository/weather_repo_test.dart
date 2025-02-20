import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/network/api_error_msg_model.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/data/repository/weather_repo.dart';

import '../../../../mocks/mock_classes.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late WeatherRepo weatherRepo;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepo = WeatherRepo(mockRemoteDataSource);
  });

  group("Get weather details", () {
    final String cityName = "Cairo";
    final weatherAPIModel = WeatherAPIModel(
      cityName: cityName,
      temperature: 287.57,
      humidity: 88,
      windSpeed: 2.06,
    );

    test("Should return WeatherEntity when connection success", () async {
      /// ARRANGE
      when(mockRemoteDataSource.getWeatherDetails(cityName))
          .thenAnswer((_) async => weatherAPIModel);

      /// ACT
      final result = await weatherRepo.getWeatherDetails(cityName);

      /// ASSERT
      expect(result, equals(Right(weatherAPIModel)));
      verify(mockRemoteDataSource.getWeatherDetails(cityName)).called(1);
    });

    final ApiErrorMsgModel apiErrorMsgModel = ApiErrorMsgModel(
      statusCode: 500,
      statusMsg: "statusMsg",
      success: false,
    );
    test("Should return ServerFailure when connection failed", () async {
      /// ARRANGE
      when(mockRemoteDataSource.getWeatherDetails(cityName))
          .thenThrow(ServerException(apiErrorMsgModel));

      /// ACT
      final result = await weatherRepo.getWeatherDetails(cityName);

      /// ASSERT
      expect(result, equals(Left(ServerFailure(apiErrorMsgModel.statusMsg))));
      verify(mockRemoteDataSource.getWeatherDetails(cityName)).called(1);
    });

    test("Should return ResponseFailure when city name not found", () async {
      /// ARRANGE
      when(mockRemoteDataSource.getWeatherDetails(cityName))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ""),
        type: DioExceptionType.badResponse,
      ));

      /// ACT
      final result = await weatherRepo.getWeatherDetails(cityName);

      /// ASSERT
      expect(
        result,
        equals(
          Left(ResponseFailure(
              "Bad Response make sure to write a proper city name")),
        ),
      );
      verify(mockRemoteDataSource.getWeatherDetails(cityName)).called(1);
    });

    test("Should return NetworkFailure when no internet connection", () async {
      /// ARRANGE
      when(mockRemoteDataSource.getWeatherDetails(cityName))
          .thenThrow(DioException(requestOptions: RequestOptions(path: "")));

      /// ACT
      final result = await weatherRepo.getWeatherDetails(cityName);

      /// ASSERT
      expect(
        result,
        equals(
          Left(NetworkFailure("There is an error in Network")),
        ),
      );
      verify(mockRemoteDataSource.getWeatherDetails(cityName)).called(1);
    });
  });
}
