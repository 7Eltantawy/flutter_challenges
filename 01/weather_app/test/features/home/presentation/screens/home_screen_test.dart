import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/presentation/screens/full_details_screen.dart';
import 'package:weather_app/features/home/presentation/screens/home_screen.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  group("HomeScreen", () {
    testWidgets("Should have form error when city name is empty",
        (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => mockWeatherBloc,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.text("City name cannot be empty"), findsOneWidget);
    });

    final cityName = "Cairo";
    final weatherAPIModel = WeatherAPIModel(
      cityName: cityName,
      temperature: 287.57,
      humidity: 88,
      windSpeed: 2.06,
    );

    testWidgets(
        "Should navigate to SecondScreen when user enters city name and taps",
        (tester) async {
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([
          WeatherInitialState(),
          WeatherLoadingState(),
          WeatherLoadedState(weatherAPIModel, weatherAPIModel),
        ]),
        initialState: WeatherInitialState(),
      );

      await tester.pumpWidget(
        BlocProvider<WeatherBloc>.value(
          value: mockWeatherBloc,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      final textFormField = find.byType(TextFormField);
      await tester.enterText(textFormField, cityName);
      await tester.tap(find.byType(FilledButton));

      await tester.pumpAndSettle();

      expect(find.byType(FullDetailsScreen), findsOneWidget);
      expect(mockWeatherBloc.state, isA<WeatherLoadedState>());
    });
  });
}
