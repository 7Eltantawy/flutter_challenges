import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/presentation/components/city_data_view.dart';
import 'package:weather_app/features/home/presentation/components/error_page.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/presentation/screens/full_details_screen.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  Widget appWidget() => BlocProvider<WeatherBloc>(
        create: (context) => mockWeatherBloc,
        child: MaterialApp(
          home: FullDetailsScreen(),
        ),
      );

  final cityName = "Cairo";
  final weatherAPIModel = WeatherAPIModel(
    cityName: cityName,
    temperature: 287.57,
    humidity: 88,
    windSpeed: 2.06,
  );

  group("FullDetailsScreen", () {
    testWidgets('Should display CityDataView when weather is loaded',
        (tester) async {
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([
          WeatherLoadedState(weatherAPIModel, weatherAPIModel),
        ]),
        initialState: WeatherLoadingState(),
      );

      await tester.pumpWidget(appWidget());
      await tester.pumpAndSettle();
      expect(find.byType(CityDataView), findsOneWidget);
    });

    testWidgets('Should display CircularProgressIndicator when loading',
        (tester) async {
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([WeatherLoadingState()]),
        initialState: WeatherLoadingState(),
      );

      await tester.pumpWidget(appWidget());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display ErrorPage when error occurs', (tester) async {
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([
          WeatherErrorState(ServerFailure("Something went wrong")),
        ]),
        initialState: WeatherLoadingState(),
      );

      await tester.pumpWidget(appWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ErrorPage), findsOneWidget);
    });
  });
}
