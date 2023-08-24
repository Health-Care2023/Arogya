import 'dart:typed_data';

import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;
  const AuthEventForgotPassword({this.email});
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister(this.email, this.password);
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin(this.email, this.password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventUpdateProfile extends AuthEvent {
  final void Function() onDataUpdated;
  const AuthEventUpdateProfile(this.onDataUpdated);
}

class AuthEventUpdatedProfile extends AuthEvent {
  const AuthEventUpdatedProfile();
}

class AuthEventUpdatingProfile extends AuthEvent {
  final String name;
  final String email;
  final String aadhar_no;
  final String gender;
  final String phone1;
  final String phone2;
  final String profession;
  final String address1;
  final String district;
  final String address2;
  final String address3;
  final String pincode;
  final String wardNo;
  final String dateofbirth;
  final Uint8List image;
  final String emergency1;
  final String emergency2;
  const AuthEventUpdatingProfile({
    required this.name,
    required this.email,
    required this.aadhar_no,
    required this.gender,
    required this.phone1,
    required this.phone2,
    required this.profession,
    required this.address1,
    required this.district,
    required this.address2,
    required this.address3,
    required this.pincode,
    required this.wardNo,
    required this.dateofbirth,
    required this.image,
    required this.emergency1,
    required this.emergency2,
  });
}

class AuthEventUpdateEmergency extends AuthEvent {
  final String email;
  const AuthEventUpdateEmergency({required this.email});
}
