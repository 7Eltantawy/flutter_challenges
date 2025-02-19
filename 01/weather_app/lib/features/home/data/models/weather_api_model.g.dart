// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_api_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAPIModelAdapter extends TypeAdapter<WeatherAPIModel> {
  @override
  final int typeId = 0;

  @override
  WeatherAPIModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherAPIModel(
      cityName: fields[0] as String,
      temperature: fields[1] as double,
      windSpeed: fields[2] as double,
      humidity: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherAPIModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.windSpeed)
      ..writeByte(3)
      ..write(obj.humidity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAPIModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
