import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:wallet_new/core/error/failure.dart';
import 'package:wallet_new/features/data/datasources/firebase_auth_remote_datasource.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;
  final Box<UserEntity> _userBox; // Хранилище для кэширования пользователя

  AuthRepositoryImpl(this.remoteDataSource) : _userBox = Hive.box('userBox');

  @override
  Future<Either<Failure, UserEntity>> logInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await remoteDataSource.logInWithEmailAndPassword(email, password);
      await _cacheUser(user); // Кэшируем пользователя
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> logInWithGoogle() async {
    try {
      final user = await remoteDataSource.logInWithGoogle();
      await _cacheUser(user); // Кэшируем пользователя
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await remoteDataSource.logOut();
      await _clearCache(); // Очищаем кэш при выходе
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.registerWithEmail(email, password);
      await _cacheUser(user); // Кэшируем пользователя
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await remoteDataSource.resetPassword(email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // Проверяем, есть ли пользователь в кэше
  @override
  Future<Either<Failure, UserEntity>> getCachedUser() async {
    try {
      final user = _userBox.get('cachedUser');
      if (user != null) {
        return Right(user);
      }
      return Left(CacheFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  // Кэшируем пользователя
  Future<void> _cacheUser(UserEntity user) async {
    await _userBox.put('cachedUser', user);
  }

  // Очищаем кэш
  Future<void> _clearCache() async {
    await _userBox.delete('cachedUser');
  }
}
