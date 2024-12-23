import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';

abstract class BybitRepository {
  Future<Either<Failure, List<CoinEntity>>> getAllCoins();

  Future<Either<Failure, CoinEntity>> getCoin(String name);

  Future<Either<Failure, BybitApiEntity>> bybitAuth(
      String apiKey, String apiSecret);

  Future<Either<Failure, void>> bybitLogout();

  Future<Either<Failure, AccountBybitEntity>> bybitGetWallet();
}
