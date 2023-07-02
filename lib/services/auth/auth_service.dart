import 'package:hello/services/auth/auth_provider.dart';
import 'package:hello/services/auth/auth_user.dart';
import 'package:hello/services/auth/firebase_auth_provide.dart';

class Authservice implements AuthProvider {
  final AuthProvider provider;

  Authservice(this.provider);
  factory Authservice.firebase() => Authservice(FirebaseAuthProvider());
  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();
}
