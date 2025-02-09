import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_new/core/platform/network_info.dart';
import 'package:wallet_new/core/services/theme_cubit.dart';
import 'package:wallet_new/features/data/datasources/bybit_remote_datasource.dart';
import 'package:wallet_new/features/data/datasources/firebase_auth_remote_datasource.dart';
import 'package:wallet_new/features/data/repositories/auth_repository_impl.dart';
import 'package:wallet_new/features/data/repositories/bybit_repository_impl.dart';
import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';
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
import 'package:wallet_new/features/domain/usecases/bybit_usecases/bybit_auth.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/bybit_get_wallet_usecase.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/bybit_logout.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/get_all_coins.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/get_coin.dart';
import 'package:wallet_new/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/bybit_auth/bybit_auth_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/get_coin/get_coin_bybit_cubit.dart';
import 'package:wallet_new/firebase_options.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(LocalWalletAdapter());
  Hive.registerAdapter(BybitApiEntityAdapter());
  var localWalletBox = await Hive.openBox<LocalWallet>('localWalletBox');
  var bybitApiBox = await Hive.openBox<BybitApiEntity>('bybitApiBox');
  var userEntityBox = await Hive.openBox<UserEntity>('userBox');

  //Bloc / Cubit
  sl.registerFactory(
    () => AuthBloc(
      logInWithEmailAndPassword: sl(),
      logOut: sl(),
      logInWithGoogle: sl(),
      registerWithEmail: sl(),
      resetPassword: sl(),
      getCachedUser: sl(),
    ),
  );

  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => GetCoinBybitCubit(coin: sl()));

  sl.registerFactory(
    () => BybitAuthBloc(
      bybitAuth: sl(),
      bybitLogout: sl(),
    ),
  );

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
  sl.registerLazySingleton(() => BybitAuth(sl()));
  sl.registerLazySingleton(() => BybitLogout(sl()));
  sl.registerSingleton(() => BybitGetWalletUsecase(sl()));

  //Repository /Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSourceImpl(
      sl(),
      sl(),
    ),
  );

  //Repository /Bybit
  sl.registerLazySingleton<BybitRepository>(
    () => BybitRepositoryImpl(
      bybitRemoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<BybitRemoteDatasource>(
    () => BybitRemoteDatasourceImpl(),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  //External
  sl.registerLazySingleton<Dio>(() => Dio());
}
