// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_app/features/home/presentation/components/weather_info_card.dart';

class FullDetailsScreen extends StatelessWidget {
  const FullDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.red.withAlpha(25);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Full Details"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Icon(
                Icons.location_on,
              ),
              Text(
                "London",
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          WeatherInfoCard(
            title: "Temperature",
            iconData: Icons.sunny,
            newValue: "45 °C",
            oldValue: "45 °C",
          ),
          SizedBox(height: 15),
          WeatherInfoCard(
            title: "Humidity",
            iconData: Icons.water,
            newValue: "67%",
            oldValue: "89%",
          ),
          SizedBox(height: 15),
          WeatherInfoCard(
            title: "Wind Speed",
            iconData: Icons.wind_power_sharp,
            newValue: "4.12",
            oldValue: "6.7",
          ),
        ],
      ),
    );
  }
}
