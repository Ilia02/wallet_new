import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';

class BybitLogout implements UseCase<void, BybitLogoutParams> {
  final BybitRepository bybitRepository;

  BybitLogout(this.bybitRepository);

  @override
  Future<Either<Failure, void>> call(BybitLogoutParams params) async {
    return await bybitRepository.bybitLogout(params.user);
  }
}

class BybitLogoutParams {
  UserEntity user;

  BybitLogoutParams({required this.user});
}
