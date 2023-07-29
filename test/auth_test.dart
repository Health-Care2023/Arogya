import 'package:hello/services/auth/auth_exceptions.dart';
import 'package:hello/services/auth/auth_provider.dart';
import 'package:hello/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test(
      'Should not be initialized',
      () {
        expect(provider._isInitialized, false);
      },
    );
  });
}

class NotInitializedException {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;

  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return logIn(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    // TODO: implement initialize
    await Future.delayed(
      const Duration(seconds: 1),
    );
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == "foo@gmail.com") throw UserNotFoundException();
    if (password == "foo") throw WrongPasswordException();
    final user = AuthUser(isEmailVerified: false, email: email);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundException();
    const newUser = AuthUser(isEmailVerified: true, email: "");
    _user = newUser;
    throw UnimplementedError();
  }
}
