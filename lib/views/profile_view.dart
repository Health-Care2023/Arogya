import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello/db/database_helper.dart';
import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Helper/loading/loading_screen.dart';
import '../services/auth/auth_service.dart';
import '../services/auth/bloc/auth_state.dart';

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

class ProfileView extends StatefulWidget {
  final void Function() onDataUpdated;
  const ProfileView({required this.onDataUpdated});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // final String email;
  late String imgString;
  PickedFile? pickedImage;
  late File _imageFile;
  final ImagePicker _picker = ImagePicker();
  late final SQLHelper _sqlhelper;
  Uint8List? _image;

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
  late final TextEditingController _photo;

  //TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _sqlhelper = SQLHelper();
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
    _dob = TextEditingController();
    _photo = TextEditingController();

    _firstname.text = " ";
    _middlename.text = "";
    _lastname.text = "";
    _dob.text = "";
    _countrycode.text = "+91";
    _imageFile = File("asset/user_image.png");
    _gender.text = "Male";
    _profession.text = "Service";
    // _photo.text = Utility.base64String(_imageFile.readAsBytesSync());
    // _photo.text = "";
    refreshJournals();
    super.initState();
  }

  String get userEmail => Authservice.firebase().currentUser!.email!;

  void refreshJournals() async {
    DatabaseUser db = await _sqlhelper.getUser(email: userEmail);

    setState(() {
      _email.text = db.email;

      List<String> name = db.name.split(" ");
      _firstname.text = name[0];
      _middlename.text = name[1];
      _lastname.text = name[2];

      _dob.text = db.dateofbirth;
      _gender.text = db.gender;
      _profession.text = db.profession;
      _phone1.text = db.phone1;
      _phone2.text = db.phone2;
      _aadharNo.text = db.aadhar_no;
      _address1.text = db.address1;
      _address2.text = db.address2;
      _address3.text = db.address3;
      _wordno.text = db.wardNo;
      _district.text = db.district;
      _pincode.text = db.pincode;
      _image = db.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthStateUpdatingProfile) {
          widget.onDataUpdated;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Your Profile"),
            backgroundColor: Color.fromARGB(255, 5, 14, 82),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  imageProfile(),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      border: OutlineInputBorder(
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
                      labelText: 'Enter password',
                      border: OutlineInputBorder(
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
                      labelText: 'First Name',
                      border: OutlineInputBorder(
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
                      labelText: 'Middle Name',
                      border: OutlineInputBorder(
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
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
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
                      labelText: 'Alternate Phone No 1',
                      border: OutlineInputBorder(
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
                      labelText: 'Enter Alternate Phone No 2',
                      border: OutlineInputBorder(
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
                        prefixIcon: Icon(Icons.calendar_today),
                        iconColor: Colors.blue, //icon of text field
                        labelText: "Enter Date Of Birth", //label text of field
                        border: OutlineInputBorder(
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
                      labelText: 'Adhaar Card Number',
                      border: OutlineInputBorder(
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
                      border: OutlineInputBorder(
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
                      labelText: 'Addressline-1',
                      border: OutlineInputBorder(
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
                      labelText: 'addressline-2,post office,landmark',
                      border: OutlineInputBorder(
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
                      labelText: 'City/town/village name',
                      border: OutlineInputBorder(
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
                      labelText: 'Word No/Block No',
                      border: OutlineInputBorder(
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
                      labelText: 'District',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton.extended(
                    extendedPadding: EdgeInsets.only(left: 150, right: 150),
                    label: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ), // <-- Text
                    backgroundColor: Color.fromARGB(255, 48, 143, 221),
                    icon: new Icon(Icons.update),
                    onPressed: () async {
                      // await _sqlhelper.updateItem(
                      //   name:
                      //       '${_firstname.text} ${_middlename.text} ${_lastname.text}',
                      //   email: _email.text,
                      //   aadhar_no: _aadharNo.text,
                      //   gender: _gender.text,
                      //   phone1: _phone1.text,
                      //   phone2: _phone2.text,
                      //   profession: _profession.text,
                      //   address1: _address1.text,
                      //   district: _district.text,
                      //   dateofbirth: _dob.text,
                      //   address2: _address2.text,
                      //   address3: _address3.text,
                      //   pincode: _pincode.text,
                      //   wardNo: _wordno.text,
                      //   image: _image!,
                      // );
                      context.read<AuthBloc>().add(AuthEventUpdatingProfile(
                            name:
                                '${_firstname.text} ${_middlename.text} ${_lastname.text}',
                            email: _email.text,
                            aadhar_no: _aadharNo.text,
                            gender: _gender.text,
                            phone1: _phone1.text,
                            phone2: _phone2.text,
                            profession: _profession.text,
                            address1: _address1.text,
                            district: _district.text,
                            dateofbirth: _dob.text,
                            address2: _address2.text,
                            address3: _address3.text,
                            pincode: _pincode.text,
                            wardNo: _wordno.text,
                            image: _image!,
                          ));
                      widget.onDataUpdated();
                      LoadingScreen()
                          .show(context: context, text: "Updating...");
                      Future.delayed(
                        Duration(seconds: 4),
                        () {
                          LoadingScreen().hide();
                        },
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     backgroundColor:
                      //         Colors.green, // Custom background color
                      //     content: Row(
                      //       children: [
                      //         Icon(Icons.check_circle_outline,
                      //             color: Colors.white), // Custom tick icon
                      //         SizedBox(width: 8), // Spacing between icon and text
                      //         Text(
                      //           "Profile Updated",
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //     duration: Duration(
                      //         seconds: 1), // Adjust the duration as needed
                      //   ),
                      // );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ))),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            // backgroundImage: FileImage(File(_imageFile.path)),
            backgroundImage: MemoryImage(_image ?? Uint8List(0)),
          ),
          Positioned(
              bottom: 21.0,
              right: 21.0,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    size: 25.0,
                    color: Colors.teal,
                  )))
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context as BuildContext).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(children: <Widget>[
          Text(
            "Choose your profile picture",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ]));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = File(pickedFile!.path);
      _image = _imageFile.readAsBytesSync();
    });
  }
}
