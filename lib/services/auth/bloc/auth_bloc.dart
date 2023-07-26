import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/services/auth/auth_provider.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';
import 'package:hello/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isloading: true)) {
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final pass = event.password;
        try {
          await provider.createUser(email: email, password: pass);
          await provider.sendEmailVerification();
        } on Exception catch (e) {
          emit(AuthStateRegistering(exception: e, isloading: false));
        }
      },
    );
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isloading: false));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isloading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isloading: false));
      }
    });
    on<AuthEventShouldRegister>(
      (event, emit) {
        emit(const AuthStateRegistering(exception: null, isloading: false));
      },
    );
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(
          exception: null, isloading: true, loadingtext: "Logging in.."));
      final email = event.email;
      final pass = event.password;

      try {
        final user = await provider.logIn(email: email, password: pass);
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isloading: false));
          emit(const AuthStateNeedsVerification(isloading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isloading: false));
          emit(AuthStateLoggedIn(user: user, isloading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isloading: false,
        ));
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(
          exception: null,
          isloading: false,
        ));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isloading: false,
        ));
      }
    });
  }
}
