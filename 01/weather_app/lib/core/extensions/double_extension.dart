extension DoubleExtension on double {
  int toCelsius() => ((this - 32) / 1.8).round();
}
