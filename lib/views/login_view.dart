import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello/constants/routes.dart';
import 'package:hello/services/auth/auth_exceptions.dart';

import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';

import '../Utilities/show_error_dialog.dart';
import '../services/auth/bloc/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _pass;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // TODO: implement listener

        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundException) {
            await showErrorDialog(context, 'User Not Found');
          } else if (state.exception is WrongPasswordException) {
            await showErrorDialog(context, 'Wrong Credentials');
          } else if (state.exception is GenericException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
          body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'asset/healthcare.png',
                  width: double.infinity,
                  height: 200,
                ),
                const Text("HealthCare",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 48, 143, 221))),
                SizedBox(height: MediaQuery.devicePixelRatioOf(context) + 45),
                const Text(
                  "LogIn",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  extendedPadding: EdgeInsets.only(left: 150, right: 150),
                  label: const Text(
                    'Sign In with ABHA',
                    style: TextStyle(color: Colors.white),
                  ), // <-- Text
                  backgroundColor: Colors.black,
                  onPressed: () {
                    print("google");
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  extendedPadding: EdgeInsets.only(left: 100, right: 100),
                  label: const Text(
                    'Register with Phone Number',
                    style: TextStyle(color: Colors.white),
                  ), // <-- Text
                  backgroundColor: Color.fromARGB(255, 96, 245, 123),
                  icon: new Icon(Icons.phone),
                  onPressed: () {
                    Navigator.of(context).pushNamed(myphone);
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "Or,",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Enter your Email',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextField(
                    controller: _pass,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Enter your Password',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  extendedPadding: const EdgeInsets.only(left: 150, right: 150),
                  label: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ), // <-- Text
                  backgroundColor: Color.fromARGB(255, 48, 143, 221),
                  icon: new Icon(Icons.login),
                  onPressed: () async {
                    final email = _email.text;
                    final pass = _pass.text;
                    context.read<AuthBloc>().add(AuthEventLogin(email, pass));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not Registered?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventShouldRegister());
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
