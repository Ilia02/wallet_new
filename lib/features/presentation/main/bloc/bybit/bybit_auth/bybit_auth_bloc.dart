import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wallet_new/core/usecases/usecase.dart';
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

    emit(BybitAuthInitial());
  }

  @override
  BybitAuthState? fromJson(Map<String, dynamic> json) {
    try {
      final stateType = json['type'] as String;

      switch (stateType) {
        case 'BybitAuthLoggedIn':
          return BybitAuthLoggedIn(api: BybitApiEntity.fromJson(json['api']));
        case 'BybitAuthError':
          return BybitAuthError();
        case 'BybitAuthLoading':
          return BybitAuthLoading();
        case 'BybitAuthLoggedOut':
          return BybitAuthLoggedOut();
        default:
          return BybitAuthInitial();
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(BybitAuthState state) {
    if (state is BybitAuthLoggedIn) {
      return {
        'type': 'BybitAuthLoggedIn',
        'api': state.api.toJson(),
      };
    } else if (state is BybitAuthError) {
      return {
        'type': 'BybitAuthError',
      };
    } else if (state is BybitAuthLoading) {
      return {
        'type': 'BybitAuthLoading',
      };
    } else if (state is BybitAuthLoggedOut) {
      return {
        'type': 'BybitAuthLoggedOut',
      };
    } else {
      return {
        'type': 'BybitAuthInitial',
      };
    }
  }
}
