import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class BybitAuth implements UseCase<AccountBybitEntity, BybitAuthParams> {
  final BybitRepository bybitRepository;

  BybitAuth(this.bybitRepository);

  @override
  Future<Either<Failure, AccountBybitEntity>> call(
      BybitAuthParams params) async {
    return await bybitRepository.bybitAuth(params.apiKey, params.apiSecret);
  }
}

class BybitAuthParams {
  String apiKey;
  String apiSecret;

  BybitAuthParams({required this.apiKey, required this.apiSecret});
}
