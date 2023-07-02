import 'package:flutter/material.dart';
import 'package:hello/constants/routes.dart';
import 'package:hello/services/auth/auth_exceptions.dart';
import 'package:hello/services/auth/auth_service.dart';
import '../Utilities/show_error_dialog.dart';

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
    return Scaffold(
        appBar: AppBar(
          // title: const Text('Login', style: TextStyle(fontSize: 25)),
          backgroundColor: Colors.white,
          // centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
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
                // TextField(
                //   controller: _email,
                //   enableSuggestions: false,
                //   autocorrect: false,
                //   keyboardType: TextInputType.emailAddress,
                //   decoration: InputDecoration(
                //     hintText: 'Enter Your Email',
                //     border: InputBorder.none,
                //     filled: true,
                //     fillColor: Colors.white,
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(width: 1, color: Colors.black),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   style: const TextStyle(
                //       fontSize: 15, fontWeight: FontWeight.w700),
                // ),
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
                // TextField(
                //   controller: _pass,
                //   obscureText: true,
                //   enableSuggestions: false,
                //   autocorrect: false,
                //   decoration: InputDecoration(
                //     hintText: 'Enter Your Password',
                //     border: InputBorder.none,
                //     filled: true,
                //     fillColor: Colors.white,
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(width: 1, color: Colors.black),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   style: const TextStyle(
                //       fontSize: 15, fontWeight: FontWeight.w700),
                // ),
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  extendedPadding: EdgeInsets.only(left: 150, right: 150),
                  label: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ), // <-- Text
                  backgroundColor: Color.fromARGB(255, 48, 143, 221),
                  icon: new Icon(Icons.login),
                  onPressed: () async {
                    final email = _email.text;
                    final pass = _pass.text;

                    try {
                      await Authservice.firebase()
                          .logIn(email: email, password: pass);
                      // ignore: use_build_context_synchronously
                      final user = Authservice.firebase().currentUser;
                      if (user?.isEmailVerified ?? false) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          notesroute,
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            verifyEmailRoute, (route) => false);
                      }
                    } on UserNotFoundException {
                      await showErrorDialog(
                        context,
                        'User Not Found',
                      );
                    } on WrongPasswordException {
                      await showErrorDialog(
                        context,
                        'Wrong Password',
                      );
                    } on GenericException {
                      await showErrorDialog(
                        context,
                        'Authentication Error',
                      );
                    }
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
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            registerroute, (route) => false);
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
                // SizedBox(
                //   height: 40,
                //   width: 200,
                //   child: ElevatedButton(
                //       onPressed: () async {
                //         final email = _email.text;
                //         final pass = _pass.text;

                //         try {
                //           await Authservice.firebase()
                //               .logIn(email: email, password: pass);
                //           // ignore: use_build_context_synchronously
                //           final user = Authservice.firebase().currentUser;
                //           if (user?.isEmailVerified ?? false) {
                //             Navigator.of(context).pushNamedAndRemoveUntil(
                //               notesroute,
                //               (route) => false,
                //             );
                //           } else {
                //             Navigator.of(context).pushNamedAndRemoveUntil(
                //                 verifyEmailRoute, (route) => false);
                //           }
                //         } on UserNotFoundException {
                //           await showErrorDialog(
                //             context,
                //             'User Not Found',
                //           );
                //         } on WrongPasswordException {
                //           await showErrorDialog(
                //             context,
                //             'Wrong Password',
                //           );
                //         } on GenericException {
                //           await showErrorDialog(
                //             context,
                //             'Authentication Error',
                //           );
                //         }
                //       },
                //       child:
                //           const Text('Login', style: TextStyle(fontSize: 15)),
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.deepPurple,
                //         onPrimary: Colors.white70,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15.0)),
                //         minimumSize: Size(150, 20),
                //       )),
                // ),
                // SizedBox(height: 10),
                // SizedBox(
                //   child: ElevatedButton(
                //       onPressed: () {
                //         Navigator.of(context).pushNamedAndRemoveUntil(
                //             registerroute, (route) => false);
                //       },
                //       child: const Text("Not registered Yet? Register",
                //           style: TextStyle(fontSize: 15)),
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.deepPurple,
                //         onPrimary: Colors.white70,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15.0)),
                //         minimumSize: Size(180, 50),
                //       )),
                // ),
                // SizedBox(height: 10),
                // SizedBox(
                //     child: ElevatedButton(
                //         onPressed: () {
                //           Navigator.of(context).pushNamed(myphone);
                //         },
                //         child: const Text("Register with Phone Number",
                //             style: TextStyle(fontSize: 15)),
                //         style: ElevatedButton.styleFrom(
                //           primary: Colors.deepPurple,
                //           onPrimary: Colors.white70,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(15.0)),
                //           minimumSize: Size(180, 50),
                //         )))
              ],
            ),
          ),
        ));
  }
}
