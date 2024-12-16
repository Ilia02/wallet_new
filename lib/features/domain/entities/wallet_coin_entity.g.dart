// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_coin_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletCoinEntityAdapter extends TypeAdapter<WalletCoinEntity> {
  @override
  final int typeId = 1;

  @override
  WalletCoinEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletCoinEntity(
      name: fields[0] as String,
      count: fields[1] as double,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WalletCoinEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletCoinEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
