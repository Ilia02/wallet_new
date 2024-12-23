// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bybit_api_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BybitApiEntityAdapter extends TypeAdapter<BybitApiEntity> {
  @override
  final int typeId = 1;

  @override
  BybitApiEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BybitApiEntity(
      apiKey: fields[0] as String,
      apiSecret: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BybitApiEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.apiKey)
      ..writeByte(1)
      ..write(obj.apiSecret);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BybitApiEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
