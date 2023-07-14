import 'package:flutter/material.dart';
import 'package:hello/Utilities/show_error_dialog.dart';
import 'package:hello/constants/routes.dart';
import 'package:hello/services/auth/auth_exceptions.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/db/database_helper.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _middlename;
  late final TextEditingController _countrycode;
  late final TextEditingController _phone1;
  late final TextEditingController _phone2;
  late final TextEditingController _profession;
  late final TextEditingController _email;
  late final TextEditingController _aadharNo;
  late final TextEditingController _gender;
  late final TextEditingController _pass;
  late final TextEditingController _dob;
  late final TextEditingController _address1;
  late final TextEditingController _address2;
  late final TextEditingController _address3;
  late final TextEditingController _wordno;
  late final TextEditingController _district;
  late final TextEditingController _pincode;

  //TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _middlename = TextEditingController();
    _countrycode = TextEditingController();
    _phone1 = TextEditingController();
    _phone2 = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
    _aadharNo = TextEditingController();
    _gender = TextEditingController();
    _profession = TextEditingController();
    _address1 = TextEditingController();
    _address2 = TextEditingController();
    _address3 = TextEditingController();
    _wordno = TextEditingController();
    _district = TextEditingController();
    _pincode = TextEditingController();
    //_pass = TextEditingController();
    _dob = TextEditingController();
    _firstname.text = "";
    _middlename.text = "";
    _lastname.text = "";
    _dob.text = "";
    _gender.text = 'Male';
    _profession.text = 'Service';
    _countrycode.text = "+91";
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
        body: SingleChildScrollView(
            child: Container(
          color: Color.fromARGB(255, 160, 173, 252),
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'asset/healthcare.png',
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(height: 10),
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
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
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
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _firstname,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
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
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
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
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _phone1,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Alternate Phone No 1',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _phone2,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Alternate Phone No 2',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                    controller: _dob, //editing controller of this TextField
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      //icon: Icon(Icons.calendar_today),
                      prefixIcon: Icon(Icons.calendar_today),
                      iconColor: Colors.blue, //icon of text field
                      hintText: "Enter Date Of Birth", //label text of field
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true, // when true user cannot edit text
                    onTap: () async {
                      //when click we have to show the datepicker
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1923),
                        lastDate: DateTime(2123),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat("dd-MM-yyyy").format(pickedDate);
                        setState(() {
                          _dob.text = formattedDate.toString();
                        });
                      } else {
                        print("Not Selected");
                      }
                    }),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                  value: _gender.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      _gender.text = newValue!;
                    });
                  },
                  items: <String>['Male', 'Female', 'Others']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _aadharNo,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Adhaar Card Number',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                  value: _profession.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      _profession.text = newValue!;
                    });
                  },
                  items: <String>[
                    'Service',
                    'Business',
                    'Agriculture',
                    'Homemaker',
                    'Student',
                    'Others'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _address1,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Addressline-1',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _address2,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'addressline-2,post office,landmark',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _address3,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'City/town/village name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _wordno,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Word No/Block No',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _district,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'District',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _pincode,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'pincode',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
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
                            Map<String, dynamic> patient = {
                              'name': _firstname.text +
                                  _middlename.text +
                                  _lastname.text,
                              'email': _email.text,
                              'aadhar_no': _aadharNo.text,
                              'gender': _gender.text,
                              'profession': _profession.text,
                              'address1': _address1.text,
                              'address2': _address2.text,
                              'address3': _address3.text,
                              'District': _district.text,
                              'Pincode': _pincode.text,
                              'WordNo': _wordno.text,
                              'Phone1': _phone1.text,
                              'Phone2': _phone2.text,
                              'dateOfbirth': _dob.text
                            };
                            int insertedId =
                                await databaseHelper.insertPatient(patient);
                            print('Inserted Patient ID: $insertedId');
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
                        ))),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      child: const Text('Already Registered?Login',
                          style: TextStyle(fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        onPrimary: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        minimumSize: Size(180, 50),
                      ))
                ])
              ],
            ),
          ),
        )));
  }
}
