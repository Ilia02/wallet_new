import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_new/core/platform/network_info.dart';
import 'package:wallet_new/core/services/theme_cubit.dart';
import 'package:wallet_new/features/data/datasources/bybit_remote_datasource.dart';
import 'package:wallet_new/features/data/datasources/firebase_auth_remote_datasource.dart';
import 'package:wallet_new/features/data/repositories/auth_repository_impl.dart';
import 'package:wallet_new/features/data/repositories/bybit_repository_impl.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/entities/wallet_entity.dart';
import 'package:wallet_new/features/domain/repositories/auth_repository.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/get_cache_user.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/login_with_email_and_password.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/login_with_google.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/logout.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/register_with_email.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/reset_password.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/get_all_coins.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/get_coin.dart';
import 'package:wallet_new/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/get_coin/get_coin_bybit_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Hive
  var userBox = await Hive.openBox<UserEntity>('usersBox');
  var walletsBox = await Hive.openBox<LocalWallet>('walletsBox');

  //Bloc / Cubit
  sl.registerFactory(() => AuthBloc(
        logInWithEmailAndPassword: sl(),
        logOut: sl(),
        logInWithGoogle: sl(),
        registerWithEmail: sl(),
        resetPassword: sl(),
        getCachedUser: sl(),
      ));

  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => GetCoinBybitCubit(coin: sl()));

  //UseCases /Auth
  sl.registerLazySingleton(() => GetCachedUser(sl()));
  sl.registerLazySingleton(() => LogInWithEmailAndPassword(sl()));
  sl.registerLazySingleton(() => LogInWithGoogle(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));
  sl.registerLazySingleton(() => RegisterWithEmail(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));

  //UseCases /Bybit
  sl.registerLazySingleton(() => GetAllCoins(sl()));
  sl.registerLazySingleton(() => GetCoin(sl()));

  //Repository /Auth
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl(sl(), sl()));

  //Repository /Bybit
  sl.registerLazySingleton<BybitRepository>(
      () => BybitRepositoryImpl(bybitRemoteDatasource: sl()));

  sl.registerLazySingleton<BybitRemoteDatasource>(
      () => BybitRemoteDatasourceImpl());

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  //External
  sl.registerLazySingleton<Dio>(() => Dio());
}
