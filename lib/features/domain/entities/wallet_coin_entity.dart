import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'wallet_coin_entity.g.dart';

@HiveType(typeId: 1)
class WalletCoinEntity extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  double count;

  @HiveField(2)
  double value;

  WalletCoinEntity({
    required this.name,
    this.count = 0,
    this.value = 0,
  });

  double get sum => count * value;

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[name];
}
