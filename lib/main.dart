import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wallet_new/core/services/local_service.dart';
import 'package:wallet_new/core/services/routing/app_router.dart';
import 'package:wallet_new/core/services/theme_cubit.dart';
import 'package:wallet_new/core/services/local_service.dart' as di;
import 'package:wallet_new/features/data/datasources/bybit_remote_datasource.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';
import 'package:wallet_new/features/domain/entities/wallet_coin_entity.dart';
import 'package:wallet_new/features/domain/entities/wallet_entity.dart';
import 'package:wallet_new/features/domain/repositories/bybit_repository.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/get_cache_user.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/login_with_email_and_password.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/login_with_google.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/logout.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/register_with_email.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/reset_password.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/get_coin.dart';
import 'package:wallet_new/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/get_coin/get_coin_bybit_cubit.dart';
import 'package:wallet_new/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(WalletCoinEntityAdapter());
  Hive.registerAdapter(LocalWalletAdapter());

  await di.init();
  assert(sl.isRegistered<BybitRemoteDatasource>());
  assert(sl.isRegistered<BybitRepository>());

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            logInWithEmailAndPassword: sl<LogInWithEmailAndPassword>(),
            logOut: sl<LogOut>(),
            logInWithGoogle: sl<LogInWithGoogle>(),
            registerWithEmail: sl<RegisterWithEmail>(),
            resetPassword: sl<ResetPassword>(),
            getCachedUser:
                sl<GetCachedUser>(), // Добавляем кэширование пользователя
          ), //..add(AppStarted()), // Добавляем событие старта приложения
        ),
        BlocProvider<GetCoinBybitCubit>(
          create: (context) => GetCoinBybitCubit(coin: sl<GetCoin>()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            theme: theme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
