import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

class LogInWithGoogleEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterEvent(this.email, this.password);
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent(this.email);
}
