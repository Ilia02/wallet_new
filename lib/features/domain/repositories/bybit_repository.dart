import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';

abstract class BybitRepository {
  Future<Either<Failure, List<CoinEntity>>> getAllCoins();

  Future<Either<Failure, CoinEntity>> getCoin(String name);

  Future<Either<Failure, AccountBybitEntity>> bybitAuth(
      String apiKey, String apiSecret, UserEntity user);

  Future<Either<Failure, void>> bybitLogout(UserEntity user);
}
