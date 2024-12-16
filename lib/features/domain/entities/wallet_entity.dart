import 'package:wallet_new/features/domain/entities/wallet_coin_entity.dart';
import 'package:hive/hive.dart';

part 'wallet_entity.g.dart';

abstract class WalletEntity {
  final String nameWallet;
  List<WalletCoinEntity> coins;

  WalletEntity({required this.nameWallet, List<WalletCoinEntity>? coins})
      : coins = coins ?? [];

  double get totalValue => coins.fold(0, (sum, coin) => sum + coin.sum);

  void addCoin(WalletCoinEntity coin) {
    coins.add(coin);
  }
}

@HiveType(typeId: 2)
class LocalWallet extends WalletEntity with HiveObjectMixin {
  @HiveField(0)
  final String nameWallet;

  @HiveField(1)
  final List<WalletCoinEntity> coins;

  LocalWallet({
    required this.nameWallet,
    List<WalletCoinEntity>? coins,
  })  : coins = coins ?? [],
        super(nameWallet: nameWallet, coins: coins);
}

class BybitWallet extends WalletEntity {
  final String nameWallet;
  final List<WalletCoinEntity> coins;

  BybitWallet({
    required this.nameWallet,
    List<WalletCoinEntity>? coins,
  })  : coins = coins ?? [],
        super(nameWallet: nameWallet, coins: coins);
}
