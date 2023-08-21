import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello/Utilities/show_error_dialog.dart';

import 'package:hello/services/auth/auth_exceptions.dart';

import 'package:hello/db/database_helper.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';

import 'package:flutter/services.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final SQLHelper _sqlHelper;
  //CloseDialog? _closeDialogHandle;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _middlename;
  late final TextEditingController _email;
  late final TextEditingController _pass;
  Uint8List _imageBytes = Uint8List(0);

  @override
  void initState() {
    _sqlHelper = SQLHelper();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _middlename = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();

    loadImageFromAsset('asset/user_image.png').then((bytes) {
      setState(() {
        _imageBytes = bytes;
      });
    });
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // TODO: implement listener
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordException) {
            await showErrorDialog(context, 'Please choose a strong password');
          } else if (state.exception is EmailAlreadyInUseException) {
            await showErrorDialog(
                context, 'Email is already in use.Please login..');
          } else if (state.exception is GenericException) {
            await showErrorDialog(context, 'Something went wrong..');
          }
        }
      },
      child: Scaffold(
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

                      context
                          .read<AuthBloc>()
                          .add(AuthEventRegister(email, pass));

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
                        image: _imageBytes,
                        emergency1: '',
                        emergency2: '',
                      );
                      await openDialog(context);
                    }),
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
                        context.read<AuthBloc>().add(const AuthEventLogOut());
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
      )),
    );
  }

  Future<Uint8List> loadImageFromAsset(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  Future openDialog(BuildContext context) async {
    // Obtain the AuthBloc using the closest ancestor BlocProvider
    final authBloc = BlocProvider.of<AuthBloc>(context);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          // Wrap the Text widget with Center
          child: Text("Verify Your Email"),
        ),
        alignment: Alignment.center,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Did not get it?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () async {
                authBloc.add(const AuthEventSendEmailVerification());
              },
              child: const Text(
                'Resend it',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
