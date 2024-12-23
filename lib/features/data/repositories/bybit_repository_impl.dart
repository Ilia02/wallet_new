import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_new/core/error/exception.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/features/data/datasources/bybit_remote_datasource.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class BybitRepositoryImpl implements BybitRepository {
  final BybitRemoteDatasource bybitRemoteDatasource;
  final Box<BybitApiEntity> _bybitApiBox;

  BybitRepositoryImpl({required this.bybitRemoteDatasource})
      : _bybitApiBox = Hive.box('bybitApiBox');

  Future<Either<Failure, T>> _handleRequest<T>(
      Future<T> Function() request) async {
    try {
      final result = await request();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CoinEntity>>> getAllCoins() async {
    return _handleRequest(() => bybitRemoteDatasource.getAllCoins());
  }

  @override
  Future<Either<Failure, CoinEntity>> getCoin(String name) async {
    return _handleRequest(() => bybitRemoteDatasource.getCoin(name));
  }

  @override
  Future<Either<Failure, BybitApiEntity>> bybitAuth(
      String apiKey, String apiSecret) async {
    try {
      final result = await bybitRemoteDatasource.bybitAuth(apiKey, apiSecret);
      _cacheByitApi(result);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> bybitLogout() async {
    _clearCache();
    return const Right(null);
  }

  @override
  Future<Either<Failure, AccountBybitEntity>> bybitGetWallet() async {
    try {
      final api = _bybitApiBox.get('bybitApi');
      if (api != null) {
        final result = await bybitRemoteDatasource.bybitGetWallet(
            api.apiKey, api.apiSecret);
        return Right(result);
      } else {
        return Left(CacheFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BybitApiEntity>> getByitApi() async {
    try {
      final api = _bybitApiBox.get('bybitApi');
      if (api != null) {
        return Right(api);
      }
      return Left(CacheFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<void> _cacheByitApi(BybitApiEntity api) async {
    await _bybitApiBox.put('bybitApi', api);
  }

  Future<void> _clearCache() async {
    await _bybitApiBox.delete('bybitApi');
  }
}
