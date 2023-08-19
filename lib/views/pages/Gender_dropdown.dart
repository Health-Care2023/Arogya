



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  final List<String> genderOptions;
  final Function(String) onChanged;

  GenderDropdown({required this.genderOptions, required this.onChanged});

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender.isEmpty ? null : selectedGender,
      hint: Text('Select Gender'),
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2),
      onChanged: (value) {
        setState(() {
          selectedGender = value!;
          widget.onChanged(selectedGender);
        });
      },
      items: widget.genderOptions.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Expanded(
            child: Row(
              children: [
                Radio<String>(
                  value: gender,
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                      widget.onChanged(selectedGender);
                    });
                  },
                ),
                Text(gender),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}