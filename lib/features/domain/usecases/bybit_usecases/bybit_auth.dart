import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class BybitAuth implements UseCase<BybitApiEntity, BybitAuthParams> {
  final BybitRepository bybitRepository;

  BybitAuth(this.bybitRepository);

  @override
  Future<Either<Failure, BybitApiEntity>> call(
      BybitAuthParams params) async {
    return await bybitRepository.bybitAuth(params.apiKey, params.apiSecret);
  }
}

class BybitAuthParams {
  String apiKey;
  String apiSecret;

  BybitAuthParams({required this.apiKey, required this.apiSecret});
}
