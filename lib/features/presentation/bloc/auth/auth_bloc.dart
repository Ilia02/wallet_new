import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/get_cache_user.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/login_with_email_and_password.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/login_with_google.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/logout.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/register_with_email.dart';
import 'package:wallet_new/features/domain/usecases/auth_usecases/reset_password.dart';
import 'package:wallet_new/features/presentation/bloc/auth/auth_event.dart';
import 'package:wallet_new/features/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInWithEmailAndPassword logInWithEmailAndPassword;
  final LogOut logOut;
  final LogInWithGoogle logInWithGoogle;
  final RegisterWithEmail registerWithEmail;
  final ResetPassword resetPassword;
  final GetCachedUser getCachedUser;

  AuthBloc({
    required this.logInWithEmailAndPassword,
    required this.logOut,
    required this.logInWithGoogle,
    required this.registerWithEmail,
    required this.resetPassword,
    required this.getCachedUser,
  }) : super(Unauthenticated()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<LogInWithGoogleEvent>(_onLogInWithGoogleEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final cachedUserOption = await getCachedUser(NoParams());
    cachedUserOption.fold(
      (failure) => emit(
          Unauthenticated()), // Если нет пользователя в кэше, показываем экран входа
      (user) => emit(
          Authenticated(user)), // Если пользователь найден, аутентифицируем его
    );
  }

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await logInWithEmailAndPassword(
      LogInWithEmailAndPasswordParams(
        email: event.email,
        password: event.password,
      ),
    );
    emit(result.fold(
      (failure) => Unauthenticated(),
      (user) => Authenticated(user),
    ));
  }

  Future<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthState> emit) async {
    await logOut(NoParams());
    emit(Unauthenticated());
  }

  Future<void> _onLogInWithGoogleEvent(
      LogInWithGoogleEvent event, Emitter<AuthState> emit) async {
    final result = await logInWithGoogle(NoParams());
    emit(result.fold(
      (failure) => Unauthenticated(),
      (user) => Authenticated(
          user), // Передаем пользователя, который пришел из use case
    ));
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    final result = await registerWithEmail(
      RegisterParams(
        email: event.email,
        password: event.password,
      ),
    );
    emit(result.fold(
      (failure) => Unauthenticated(),
      (user) => Authenticated(user),
    ));
  }

  Future<void> _onResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    await resetPassword(ResetPasswordParams(email: event.email));
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('Event: $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('Change: $change');
    }
  }
}
