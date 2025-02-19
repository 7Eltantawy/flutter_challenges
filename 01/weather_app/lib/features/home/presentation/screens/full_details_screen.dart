// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/extensions/double_extension.dart';
import 'package:weather_app/features/home/presentation/components/city_data_view.dart';
import 'package:weather_app/features/home/presentation/components/error_page.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';

class FullDetailsScreen extends StatelessWidget {
  const FullDetailsScreen({super.key});

  Color backgroundColor(int tempreture) {
    if (tempreture < 10) {
      return Colors.blue;
    } else if (tempreture < 35) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: switch (state) {
            WeatherLoadedState s =>
              backgroundColor(s.weatherEntity.temperature.kelvinToCelsius()),
            _ => null,
          },
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text("Full Details"),
              centerTitle: true,
              bottom: switch (state) {
                WeatherLoadedState s => PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Icon(
                          Icons.location_on,
                        ),
                        Text(
                          s.weatherEntity.cityName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                _ => null,
              }),
          body: switch (state) {
            WeatherLoadedState s => CityDataView(
                fetchedWeather: s.weatherEntity,
                cachedWeather: s.weatherEntity,
              ),
            WeatherErrorState s => ErrorPage(failure: s.failure),
            WeatherInitialState _ => SizedBox(),
            WeatherLoadingState _ => Center(child: CircularProgressIndicator()),
          },
        );
      },
    );
  }
}
