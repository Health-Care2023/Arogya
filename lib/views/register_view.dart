import 'package:flutter/material.dart';
import 'package:hello/Utilities/show_error_dialog.dart';
import 'package:hello/constants/routes.dart';
import 'package:hello/services/auth/auth_exceptions.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/db/database_helper.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _aadharNo;
  late final TextEditingController _gender;
  late final TextEditingController _pass;
  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController();
    _email = TextEditingController();
    _aadharNo = TextEditingController();
    _gender = TextEditingController();
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
          // title: const Text('Register', style: TextStyle(fontSize: 25)),
          backgroundColor: Colors.white,
          // centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'asset/healthcare.png',
                    width: double.infinity,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextField(
                      controller: _name,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Enter your Name',
                      ),
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
                      controller: _aadharNo,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Enter your Aadhar No',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextField(
                      controller: _gender,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Enter your Gender',
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
                    extendedPadding: EdgeInsets.only(left: 150, right: 150),
                    label: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ), // <-- Text
                    backgroundColor: Color.fromARGB(255, 48, 143, 221),
                    icon: new Icon(Icons.app_registration),
                    onPressed: () async {
                      final email = _email.text;
                      final pass = _pass.text;
                      try {
                        await Authservice.firebase()
                            .createUser(email: email, password: pass);
                        Map<String, dynamic> patient = {
                          'name': _name.text,
                          'email': _email.text,
                          'aadhar_no': _aadharNo.text,
                          'gender': _gender.text,
                        };
                        int insertedId =
                            await databaseHelper.insertPatient(patient);
                        print('Inserted Patient ID: $insertedId');
                        Authservice.firebase().sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } on WeakPasswordException {
                        await showErrorDialog(context, 'Weak password');
                      } on EmailAlreadyInUseException {
                        await showErrorDialog(context, 'email-already-in-use');
                      } on InvalidEmailException {
                        await showErrorDialog(context, 'Invalid Email Address');
                      } on GenericException {
                        await showErrorDialog(context, 'Failed to register');
                      }
                    },
                  ),
                  // SizedBox(
                  //     height: 40,
                  //     width: 200,
                  //     child: ElevatedButton(
                  //         onPressed: () async {
                  //           final email = _email.text;
                  //           final pass = _pass.text;
                  //           try {
                  //             await Authservice.firebase()
                  //                 .createUser(email: email, password: pass);
                  //             Map<String, dynamic> patient = {
                  //               'name': _name.text,
                  //               'email': _email.text,
                  //               'aadhar_no': _aadharNo.text,
                  //               'gender': _gender.text,
                  //             };
                  //             int insertedId =
                  //                 await databaseHelper.insertPatient(patient);
                  //             print('Inserted Patient ID: $insertedId');
                  //             Authservice.firebase().sendEmailVerification();
                  //             Navigator.of(context).pushNamed(verifyEmailRoute);
                  //           } on WeakPasswordException {
                  //             await showErrorDialog(context, 'Weak password');
                  //           } on EmailAlreadyInUseException {
                  //             await showErrorDialog(
                  //                 context, 'email-already-in-use');
                  //           } on InvalidEmailException {
                  //             await showErrorDialog(
                  //                 context, 'Invalid Email Address');
                  //           } on GenericException {
                  //             await showErrorDialog(
                  //                 context, 'Failed to register');
                  //           }
                  //         },
                  //         child: const Text('Register',
                  //             style: TextStyle(fontSize: 15)),
                  //         style: ElevatedButton.styleFrom(
                  //           primary: Colors.deepPurple,
                  //           onPrimary: Colors.white70,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(15.0)),
                  //           minimumSize: Size(150, 20),
                  //         ))),
                  // SizedBox(height: 10),
                  // SizedBox(
                  //     child: ElevatedButton(
                  //         onPressed: () {
                  //           Navigator.of(context).pushNamedAndRemoveUntil(
                  //               loginroute, (route) => false);
                  //         },
                  //         child: const Text('Already Registered?Login',
                  //             style: TextStyle(fontSize: 15)),
                  //         style: ElevatedButton.styleFrom(
                  //           primary: Colors.deepPurple,
                  //           onPrimary: Colors.white70,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(15.0)),
                  //           minimumSize: Size(180, 50),
                  //         )))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already Registered?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginroute, (route) => false);
                        },
                        child: const Text(
                          'Login',
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
        ));
  }
}
