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
  // late final TextEditingController _countrycode;
  // late final TextEditingController _phone1;
  // late final TextEditingController _phone2;
  // late final TextEditingController _profession;
  late final TextEditingController _email;
  // late final TextEditingController _aadharNo;
  // late final TextEditingController _gender;
  late final TextEditingController _pass;
  // late final TextEditingController _dob;
  // late final TextEditingController _address1;
  // late final TextEditingController _address2;
  // late final TextEditingController _address3;
  // late final TextEditingController _wordno;
  // late final TextEditingController _district;
  // late final TextEditingController _pincode;

  //TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _sqlHelper = SQLHelper();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _middlename = TextEditingController();
    // _countrycode = TextEditingController();
    // _phone1 = TextEditingController();
    // _phone2 = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
    // _aadharNo = TextEditingController();
    // _gender = TextEditingController();
    // _profession = TextEditingController();
    // _address1 = TextEditingController();
    // _address2 = TextEditingController();
    // _address3 = TextEditingController();
    // _wordno = TextEditingController();
    // _district = TextEditingController();
    // _pincode = TextEditingController();
    // _dob = TextEditingController();
    // _firstname.text = "";
    // _middlename.text = "";
    // _lastname.text = "";
    // _dob.text = "";
    // _gender.text = 'Male';
    // _profession.text = 'Service';
    // _countrycode.text = "+91";
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
        body: Container(
      color: Color.fromARGB(255, 160, 173, 252),
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
              const SizedBox(height: 10),
              TextField(
                controller: _firstname,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _middlename,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Middle Name',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastname,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _pass,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
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

                          await _sqlHelper.createUser(
                              name:
                                  '${_firstname.text} ${_middlename.text} ${_lastname.text}',
                              email: _email.text,
                              aadhar_no: '',
                              gender: '',
                              phone1: '',
                              phone2: '',
                              profession: '',
                              address1: '',
                              district: '',
                              dateofbirth: '',
                              address2: '',
                              pincode: '',
                              wardNo: '');

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
                          await showErrorDialog(context, 'Failed to register');
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
                      ))),
            ],
          ),
        ),
      ),
    ));
  }
}
