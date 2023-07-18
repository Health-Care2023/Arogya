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
  late final SQLHelper _sqlHelper;

  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _middlename;
  late final TextEditingController _email;
  late final TextEditingController _pass;

  @override
  void initState() {
    _sqlHelper = SQLHelper();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _middlename = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'asset/healthcare.png',
                width: double.infinity,
                height: 200,
              ),
              const SizedBox(height: 30),
              const Text("Register",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              const SizedBox(height: 10),

              SizedBox(
                child: TextField(
                  controller: _firstname,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'First Name',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: _middlename,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Middle Name',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: _lastname,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Last Name',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Email',
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
              // TextField(
              //   controller: _lastname,
              //   enableSuggestions: false,
              //   autocorrect: false,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     hintText: 'Last Name',
              //     border: InputBorder.none,
              //     filled: true,
              //     fillColor: Colors.white,
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(width: 1, color: Colors.black),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   style:
              //       const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextField(
              //   controller: _email,
              //   enableSuggestions: false,
              //   autocorrect: false,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     hintText: 'Enter your email',
              //     border: InputBorder.none,
              //     filled: true,
              //     fillColor: Colors.white,
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(width: 1, color: Colors.black),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   style:
              //       const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              // ),
              // const SizedBox(height: 10),
              // TextField(
              //   controller: _pass,
              //   obscureText: true,
              //   enableSuggestions: false,
              //   autocorrect: false,
              //   decoration: InputDecoration(
              //     hintText: 'Enter password',
              //     border: InputBorder.none,
              //     filled: true,
              //     fillColor: Colors.white,
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(width: 1, color: Colors.black),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   style:
              //       const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              // ),
              // const SizedBox(height: 30),
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

                    Authservice.firebase().sendEmailVerification();

                    await _sqlHelper.createUser(
                      name:
                          '${_firstname.text} ${_middlename.text} ${_lastname.text}',
                      email: _email.text,
                      aadhar_no: '',
                      gender: 'Male',
                      phone1: '',
                      phone2: '',
                      profession: 'Service',
                      address1: '',
                      district: '',
                      dateofbirth: '',
                      address2: '',
                      address3: '',
                      pincode: '',
                      wardNo: '',
                    );

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
                      'Log In',
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
