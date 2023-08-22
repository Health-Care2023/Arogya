import 'package:flutter/cupertino.dart';

class Doctor {
  final String name;
  final Icon icon;
  bool selected;

  Doctor({required this.name, required this.icon ,this.selected = false});
}