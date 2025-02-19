// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String newValue;
  final String oldValue;
  final IconData iconData;
  const WeatherInfoCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.newValue,
    required this.oldValue,
  });

  @override
  Widget build(BuildContext context) {
    const double spacing = 15;
    return Container(
      color: Colors.black.withAlpha(125),
      child: Padding(
        padding: const EdgeInsets.all(spacing),
        child: Column(
          spacing: spacing,
          children: [
            Row(
              spacing: spacing,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              spacing: spacing,
              children: [
                Expanded(
                  child: _ValueCard(
                    value: oldValue,
                    backgroundColor: Colors.green,
                  ),
                ),
                if (newValue != oldValue)
                  Expanded(
                    child: _ValueCard(
                      value: oldValue,
                      backgroundColor: Colors.blue,
                      textColor: Colors.blue,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final String value;
  final Color backgroundColor;
  final Color? textColor;
  const _ValueCard({
    required this.value,
    required this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor.withAlpha(25),
      constraints: BoxConstraints(minHeight: 70),
      child: Center(
        child: Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
