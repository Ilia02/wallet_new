import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class GetCoin implements UseCase<CoinEntity, GetCoinParams> {
  final BybitRepository bybitRepository;

  GetCoin(this.bybitRepository);

  @override
  Future<Either<Failure, CoinEntity>> call(GetCoinParams params) async {
    return await bybitRepository.getCoin(params.name);
  }
}

class GetCoinParams {
  final String name;

  GetCoinParams({required this.name});
}
