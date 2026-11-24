part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {
  final Map<String, dynamic> userModel;
  LoginSuccess({required this.userModel});
}
class LoginError extends AuthState {
  final String message;
  LoginError({required this.message});
}

class RegisterLoading extends AuthState {}
class RegisterSuccess extends AuthState {
  final Map<String, dynamic> userModel;
  RegisterSuccess({required this.userModel});
}
class RegisterError extends AuthState {
  final String message;
  RegisterError({required this.message});
}