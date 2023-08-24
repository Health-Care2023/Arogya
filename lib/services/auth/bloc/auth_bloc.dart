import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/db/database_helper.dart';
import 'package:hello/services/auth/auth_provider.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';
import 'package:hello/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider, SQLHelper sqlhelper)
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
    on<AuthEventForgotPassword>(
      (event, emit) async {
        emit(const AuthStateForgotPassword(
            exception: null, hassentemail: false, isloading: false));
        final email = event.email;
        if (email == null) {
          return;
        }
        emit(const AuthStateForgotPassword(
            exception: null, hassentemail: false, isloading: true));
        bool didsentemail;
        Exception? exception;
        try {
          await provider.sendResetPassword(email: email);
          didsentemail = true;
          exception = null;
        } on Exception catch (e) {
          didsentemail = false;
          exception = e;
        }
        emit(AuthStateForgotPassword(
            exception: exception,
            hassentemail: didsentemail,
            isloading: false));
      },
    );
    on<AuthEventUpdatingProfile>(
      (event, emit) async {
        emit(const AuthstateUpdateProfile(isloading: false));

        await sqlhelper.updateItem(
          name: event.name,
          email: event.email,
          aadhar_no: event.aadhar_no,
          gender: event.gender,
          phone1: event.phone1,
          phone2: event.phone2,
          profession: event.profession,
          address1: event.address1,
          district: event.district,
          address2: event.address2,
          address3: event.address3,
          pincode: event.pincode,
          wardNo: event.wardNo,
          dateofbirth: event.dateofbirth,
          image: event.image,
          emergency1: event.emergency1,
          emergency2: event.emergency2,
        );
        emit(const AuthstateUpdateProfile(
            isloading: true, loadingtext: "Updating"));
      },
    );
    on<AuthEventUpdateEmergency>((event, emit) async {
      emit(const AuthStateUpdateEmergency(isloading: false));
      await sqlhelper.updateEmergency(
        email: event.email,
        emergency: event.emergency,
      );
    });
    on<AuthEventUpdatedProfile>(
      (event, emit) {
        emit(const AuthStateUpdatedProfile(isloading: false));
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
    on<AuthEventUpdateProfile>(
      (event, emit) {
        emit(const AuthstateUpdateProfile(
          isloading: false,
          loadingtext: null,
        ));
      },
    );
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
