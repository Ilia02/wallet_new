import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/auth_repository.dart';

class LogInWithGoogle implements UseCase<UserEntity, NoParams> {
  final AuthRepository userRepository;

  LogInWithGoogle(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await userRepository.logInWithGoogle();
  }
}
