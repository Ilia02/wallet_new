import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/repositories/auth_repository.dart';

class LogOut implements UseCase<void, NoParams> {
  final AuthRepository userRepository;

  LogOut(this.userRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await userRepository.logOut();
  }
}
