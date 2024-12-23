import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class BybitGetWalletUsecase
    implements UseCase<AccountBybitEntity, GetCoinParams> {
  final BybitRepository bybitRepository;

  BybitGetWalletUsecase(this.bybitRepository);

  @override
  Future<Either<Failure, AccountBybitEntity>> call(GetCoinParams params) async {
    return await bybitRepository.bybitGetWallet();
  }
}

class GetCoinParams {
  final String name;

  GetCoinParams({required this.name});
}
