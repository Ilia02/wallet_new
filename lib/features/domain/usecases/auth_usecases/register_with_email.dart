import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/auth_repository.dart';

class RegisterWithEmail implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.registerWithEmail(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}
