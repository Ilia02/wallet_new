import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class GetAllCoins implements UseCase<List<CoinEntity>, NoParams> {
  final BybitRepository bybitRepository;

  GetAllCoins(this.bybitRepository);

  @override
  Future<Either<Failure, List<CoinEntity>>> call(NoParams params) async {
    return await bybitRepository.getAllCoins();
  }
}
