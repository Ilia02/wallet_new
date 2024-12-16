import 'package:dartz/dartz.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>>
      logInWithGoogle(); // Логин пользователя через Firebase

  Future<Either<Failure, UserEntity>> logInWithEmailAndPassword(
      String email, String password); // Логин пользователя через Google

  Future<Either<Failure, void>> logOut(); // Выход

  Future<Either<Failure, UserEntity>> registerWithEmail(
      String email, String password); // Регистрация

  Future<Either<Failure, void>> resetPassword(String email); // Сброс пароля

  Future<Either<Failure, UserEntity>> getCachedUser();
}
