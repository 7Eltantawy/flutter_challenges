// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';
import 'package:weather_app/features/home/presentation/components/weather_info_card.dart';

class CityDataView extends StatelessWidget {
  final WeatherEntity fetchedWeather;
  final WeatherEntity cachedWeather;
  const CityDataView({
    super.key,
    required this.fetchedWeather,
    required this.cachedWeather,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        WeatherInfoCard(
          title: "Temperature",
          iconData: Icons.sunny,
          newValue: "${fetchedWeather.temperature} °C",
          oldValue: "45 °C",
        ),
        SizedBox(height: 15),
        WeatherInfoCard(
          title: "Humidity",
          iconData: Icons.water,
          newValue: "${fetchedWeather.humidity}%",
          oldValue: "89%",
        ),
        SizedBox(height: 15),
        WeatherInfoCard(
          title: "Wind Speed",
          iconData: Icons.wind_power_sharp,
          newValue: "${fetchedWeather.windSpeed}",
          oldValue: "6.7",
        ),
      ],
    );
  }
}
