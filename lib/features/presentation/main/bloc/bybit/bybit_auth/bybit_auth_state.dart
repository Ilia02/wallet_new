part of 'bybit_auth_bloc.dart';

sealed class BybitAuthState extends Equatable {
  const BybitAuthState();

  @override
  List<Object> get props => [];
}

final class BybitAuthInitial extends BybitAuthState {
  @override
  List<Object> get props => [];
}

final class BybitAuthLoading extends BybitAuthState {
  @override
  List<Object> get props => [];
}

final class BybitAuthLoggedIn extends BybitAuthState {
  @override
  List<Object> get props => [];
}

final class BybitAuthLoggedOut extends BybitAuthState {
  @override
  List<Object> get props => [];
}
