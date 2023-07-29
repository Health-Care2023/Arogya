import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hello/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isloading;
  final String? loadingText;
  const AuthState(
      {required this.isloading, this.loadingText = "Please Wait..."});
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isloading})
      : super(isloading: isloading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception, required isloading})
      : super(isloading: isloading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required isloading})
      : super(isloading: isloading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hassentemail;

  const AuthStateForgotPassword(
      {required this.exception, required this.hassentemail, required isloading})
      : super(isloading: isloading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;

  const AuthStateLoggedOut(
      {required this.exception, required isloading, String? loadingtext})
      : super(isloading: isloading, loadingText: loadingtext);

  @override
  // TODO: implement props
  List<Object?> get props => [exception, isloading];
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isloading})
      : super(isloading: isloading);
}
