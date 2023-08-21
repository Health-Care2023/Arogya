



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final Function(String) onChanged;

  CustomDropdown({required this.options, required this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender.isEmpty ? null : selectedGender,
      hint: Text('Select Gender'),
      // padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2),
      onChanged: (value) {
        setState(() {
          selectedGender = value!;
          widget.onChanged(selectedGender);
        });
      },
      dropdownColor: Color.fromARGB(255, 255, 254, 254), // Customize the dropdown background color
      // dropdownWidth: 120,
      items: widget.options.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Container(
            // width : 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
              ),
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
        ));
      }).toList(),
    );
  }
}