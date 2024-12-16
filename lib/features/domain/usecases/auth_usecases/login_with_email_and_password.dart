import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/auth_repository.dart';

class LogInWithEmailAndPassword
    implements UseCase<UserEntity, LogInWithEmailAndPasswordParams> {
  final AuthRepository userRepository;

  LogInWithEmailAndPassword(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(
      LogInWithEmailAndPasswordParams params) async {
    return await userRepository.logInWithEmailAndPassword(
        params.email, params.password);
  }
}

class LogInWithEmailAndPasswordParams {
  final String email;
  final String password;

  LogInWithEmailAndPasswordParams(
      {required this.email, required this.password});
}
