// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalWalletAdapter extends TypeAdapter<LocalWallet> {
  @override
  final int typeId = 2;

  @override
  LocalWallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalWallet(
      nameWallet: fields[0] as String,
      coins: (fields[1] as List?)?.cast<WalletCoinEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalWallet obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameWallet)
      ..writeByte(1)
      ..write(obj.coins);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalWalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
