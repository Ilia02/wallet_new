import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/exception.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/features/data/datasources/bybit_remote_datasource.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class BybitRepositoryImpl implements BybitRepository {
  final BybitRemoteDatasource bybitRemoteDatasource;

  BybitRepositoryImpl({required this.bybitRemoteDatasource});

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
  Future<Either<Failure, AccountBybitEntity>> bybitAuth(
      String apiKey, String apiSecret, UserEntity user) async {
    return _handleRequest(
        () => bybitRemoteDatasource.bybitAuth(apiKey, apiSecret, user));
  }

  @override
  Future<Either<Failure, void>> bybitLogout(UserEntity user) {
    // TODO: implement bybitLogout
    throw UnimplementedError();
  }
}
