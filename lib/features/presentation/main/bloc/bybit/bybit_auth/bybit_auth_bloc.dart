import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/bybit_auth.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/bybit_logout.dart';

part 'bybit_auth_event.dart';
part 'bybit_auth_state.dart';

class BybitAuthBloc extends HydratedBloc<BybitAuthEvent, BybitAuthState> {
  final BybitAuth bybitAuth;
  final BybitLogout bybitLogout;

  BybitAuthBloc({required this.bybitAuth, required this.bybitLogout})
      : super(BybitAuthInitial()) {
    on<BybitSignInEvent>((_onBybitSignInEvent));
    on<BybitSignOutEvent>((_onBybitSignOutEvent));
  }

  Future<void> _onBybitSignInEvent(
      BybitSignInEvent event, Emitter<BybitAuthState> state) async {

    emit(BybitAuthLoading());

    final result = await bybitAuth(
        BybitAuthParams(apiKey: event.apiKey, apiSecret: event.apiSecret));

    emit(result.fold((failure) => BybitAuthError(),
        (value) => BybitAuthLoggedIn(api: value)));
  }

  Future<void> _onBybitSignOutEvent(
      BybitSignOutEvent event, Emitter<BybitAuthState> state) async {
    final result = await bybitLogout(NoParams());
  }

  @override
  BybitAuthState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(BybitAuthState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
