import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/const.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/network/api_error_msg_model.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';

import '../../../../dummy/weather_api_response.dart';
import '../../../../mocks/mock_classes.mocks.dart';

void main() {
  late MockDio dioMock;
  late WeatherRemoteDataSource weatherRemoteDataSource;

  setUp(() {
    dioMock = MockDio();
    weatherRemoteDataSource = WeatherRemoteDataSource(dioMock);
  });

  group('Get weather details', () {
    final cityName = 'Cairo';
    final queryParams = {
      'q': cityName,
      'appid': kApiKey,
    };

    test('Should return WeatherEntity when the response code is 200', () async {
      // ARRANGE
      final responseData = jsonDecode(dummyApiResponse);
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: responseData,
      );
      when(dioMock.get(kApiBaseUrl, queryParameters: queryParams))
          .thenAnswer((_) async => Future.value(response));

      // ACT
      final result = await weatherRemoteDataSource.getWeatherDetails(cityName);

      // ASSERT
      expect(result, isA<WeatherEntity>());
    });

    test('Should throw ServerException when the response code is not 200',
        () async {
      // ARRANGE
      final ApiErrorMsgModel apiErrorMsgModel = ApiErrorMsgModel(
        statusCode: 500,
        statusMsg: "statusMsg",
        success: false,
      );
      final responseData = apiErrorMsgModel.toMap();
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 500,
        data: responseData,
      );
      when(dioMock.get(kApiBaseUrl, queryParameters: queryParams))
          .thenAnswer((_) async => Future.value(response));

      // ACT
      final result = weatherRemoteDataSource.getWeatherDetails(cityName);

      // ASSERT
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
