import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:hello/db/database_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final String email;
  const ProfileView(this.email);

  @override
  State<ProfileView> createState() => _ProfileViewState(email);
}

class _ProfileViewState extends State<ProfileView> {
  final String email;
  PickedFile? pickedImage;
  late File _imageFile;
  final ImagePicker _picker = ImagePicker();

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

  var images;

  _ProfileViewState(this.email);

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
    _dob = TextEditingController();

    _firstname.text = "";
    _middlename.text = "";
    _lastname.text = "";
    _dob.text = "";
    _gender.text = 'Male';
    _profession.text = 'Service';
    _countrycode.text = "+91";
    _imageFile = File("asset/user_image.png");
    refreshJournals();
    super.initState();
  }

  Map<String, dynamic>? _journals;
  void refreshJournals() async {
    _journals = await databaseHelper.getPatientByEmail(email);
    if (_journals != null) {}

    setState(() {
      _email.text = _journals!['email'];
      List<String> name = _journals!['name'].split(" ");
      _firstname.text = name[0];
      _middlename.text = name[1];
      _lastname.text = name[2];
      _dob.text = _journals!['dateofbirth'];
      // _gender.text = _journals!['gender'];
      // _profession.text = _journals!['profession'];
      _phone1.text = _journals!['phone1'];
      _phone2.text = _journals!['phone2'];
      _aadharNo.text = _journals!['aadhar_no'];
      _address1.text = _journals!['address1'];
      _address2.text = _journals!['address2'];
      _address3.text = _journals!['address3'];
      _wordno.text = _journals!['wordno'];
      // _district.text = _journals!['district'];
      _pincode.text = _journals!['pincode'];
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _email.dispose();
  //   _pass.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Image.asset(
            //   'asset/healthcare.png',
            //   width: double.infinity,
            //   height: 200,
            // ),
            imageProfile(),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> patient = {
                    'name': _firstname.text + _middlename.text + _lastname.text,
                    'email': _email.text,
                    'aadhar_no': _aadharNo.text,
                    'gender': _gender.text,
                    'phone1': _phone1.text,
                    'phone2': _phone2.text,
                    'profession': _profession.text,
                    'address1': _address1.text,
                    'address2': _address2.text,
                    'address3': _address3.text,
                    'district': _district.text,
                    'pincode': _pincode.text,
                    'wordno': _wordno.text,
                    'dateofbirth': _dob.text
                  };
                  await databaseHelper.updatePatient(patient);
                },
                child: Text("Update"))
          ],
        ),
      ),
    )));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            backgroundImage: FileImage(File(_imageFile.path)),
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
    final pickedFile = await _picker
        .pickImage(
      source: source,
    )
        .then((imgFile) async {
      String imgString = Utility.base64String(await imgFile!.readAsBytes());
    });
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  // gridView() {
  //   return Padding(
  //     padding: EdgeInsets.all(5.0),
  //     child: GridView.count(
  //       crossAxisCount: 2,
  //       childAspectRatio: 1.0,
  //       mainAxisSpacing: 4.0,
  //       crossAxisSpacing: 4.0,
  //       children: images.map((photo) {
  //         // print("photo name");
  //         // print(photo.photoName);
  //         // return Utility.imageFromBase64String(photo.photoName ?? "");
  //       }).toList(),
  //     ),
  //   );
  // }
}
