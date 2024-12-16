part of 'bybit_auth_bloc.dart';

sealed class BybitAuthEvent extends Equatable {
  const BybitAuthEvent();

  @override
  List<Object> get props => [];
}

class BybitSignInEvent extends BybitAuthEvent {
  final String apiKey;
  final String apiSecret;

  const BybitSignInEvent(this.apiKey, this.apiSecret);
}

class BybitSignOutEvent extends BybitAuthEvent {}
