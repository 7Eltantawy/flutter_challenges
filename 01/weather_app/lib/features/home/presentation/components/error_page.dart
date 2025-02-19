import 'package:flutter/material.dart';
import 'package:weather_app/core/error/failure.dart';

class ErrorPage extends StatelessWidget {
  final Failure failure;
  const ErrorPage({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    final String message;
    final IconData iconData;
    switch (failure) {
      case ResponseFailure _:
        message = "City not found";
        iconData = Icons.search;

      case NetworkFailure _:
        message = "Check your internet connection";
        iconData = Icons.wifi;

      default:
        message = failure.message;
        iconData = Icons.error;
    }

    return Center(
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 50),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
