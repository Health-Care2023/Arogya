import 'package:flutter/material.dart';
import 'package:hello/Utilities/show_error_dialog.dart';
import 'package:hello/constants/routes.dart';
import 'package:hello/services/auth/auth_exceptions.dart';
import 'package:hello/services/auth/auth_service.dart';

//import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register', style: TextStyle(fontSize: 25)),
          backgroundColor: Color.fromARGB(255, 160, 173, 252),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(255, 160, 173, 252),
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'asset/healthcare.png',
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _pass,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          final email = _email.text;
                          final pass = _pass.text;
                          try {
                            await Authservice.firebase()
                                .createUser(email: email, password: pass);

                            Authservice.firebase().sendEmailVerification();
                            Navigator.of(context).pushNamed(verifyEmailRoute);
                          } on WeakPasswordException {
                            await showErrorDialog(context, 'Weak password');
                          } on EmailAlreadyInUseException {
                            await showErrorDialog(
                                context, 'email-already-in-use');
                          } on InvalidEmailException {
                            await showErrorDialog(
                                context, 'Invalid Email Address');
                          } on GenericException {
                            await showErrorDialog(
                                context, 'Failed to register');
                          }
                        },
                        child: const Text('Register',
                            style: TextStyle(fontSize: 15)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          onPrimary: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          minimumSize: Size(150, 20),
                        ))),
                SizedBox(height: 10),
                SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginroute, (route) => false);
                        },
                        child: const Text('Already Registered?Login',
                            style: TextStyle(fontSize: 15)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          onPrimary: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          minimumSize: Size(180, 50),
                        )))
              ],
            ),
          ),
        ));
  }
}
