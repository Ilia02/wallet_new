import 'package:equatable/equatable.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {}
