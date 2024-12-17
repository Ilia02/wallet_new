part of 'bybit_auth_bloc.dart';

sealed class BybitAuthEvent extends Equatable {
  const BybitAuthEvent();

  @override
  List<Object> get props => [];
}

class BybitSignInEvent extends BybitAuthEvent {
  final String apiKey;
  final String apiSecret;
  final UserEntity user;

  const BybitSignInEvent(this.apiKey, this.apiSecret, this.user);
}

class BybitSignOutEvent extends BybitAuthEvent {
  final UserEntity user;

  const BybitSignOutEvent({required this.user});
}
